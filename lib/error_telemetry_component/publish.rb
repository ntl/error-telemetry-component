module ErrorTelemetryComponent
  class Publish
    include Messaging::StreamName
    include Messages::Events

    include Log::Dependency
    include Telemetry::Dependency

    configure :publish

    dependency :clock, Clock::UTC
    dependency :raygun_post, RaygunClient::HTTP::Post
    dependency :store, Store
    dependency :write, Messaging::Postgres::Write

    category :error

    def self.build
      instance = new

      Clock::UTC.configure(instance)
      RaygunClient::HTTP::Post.configure(instance, attr_name: :raygun_post)
      Store.configure(instance)
      Messaging::Postgres::Write.configure(instance)

      instance
    end

    def self.call(recorded_event)
      instance = build
      instance.(recorded_event)
    end

    def call(recorded_event)
      logger.trace { "Handling recorded error (#{LogText::RecordedEvent.(recorded_event)})" }

      return if finished?(recorded_event)

      unless recorded_event.lapsed?(clock.now)
        event, event_stream_name = send_error_to_raygun(recorded_event)
      else
        event, event_stream_name = record_lapsed_event(recorded_event)
      end

      logger.info { event.class::LogText::Completion.(event) }

      return event, event_stream_name
    end

    def finished?(recorded_event)
      logger.trace { "Retrieving error from store (Error ID: #{recorded_event.error_id})" }

      entity, version = store.get(recorded_event.error_id, :include => :version)

      if entity && entity.finished?
        logger.debug { "Error retrieved from store (Error ID: #{recorded_event.error_id}, Version: #{version}, Finished: true)" }
        true
      else
        logger.debug { "Error retrieved from store (Error ID: #{recorded_event.error_id}, Version: #{version}, Finished: false)" }
        false
      end
    end

    def send_error_to_raygun(recorded_event)
      logger.trace { "Sending error to Raygun (#{LogText::RecordedEvent.(recorded_event)})" }

      raygun_data = ConvertErrorData::RaygunData.(recorded_event)

      response = raygun_post.(raygun_data)
      telemetry.record :published, Telemetry::EventData.new(response)

      event, event_stream_name = record_published_event(recorded_event)

      logger.debug { "Sent error to Raygun (#{LogText::RaygunData.(raygun_data)})" }

      return event, event_stream_name
    end

    def record_published_event(recorded_event)
      logger.trace { "Recording published event (#{LogText::RecordedEvent.(recorded_event)})" }

      event = Published.follow(recorded_event, copy: [
        :error_id
      ])

      event.time = clock.iso8601

      event_stream_name = stream_name(event.error_id)

      write.(event, event_stream_name)
      telemetry.record :wrote_event, Telemetry::EventData.new(event, event_stream_name)

      logger.debug { "Recorded published event (Error ID: #{event.error_id}, Published Time: #{event.time})" }

      return event, event_stream_name
    end

    def record_lapsed_event(recorded_event)
      logger.trace { "Recording lapsed event (#{LogText::RecordedEvent.(recorded_event)})" }

      event = Lapsed.follow(recorded_event, copy: [
        :error_id
      ])

      event.time = clock.iso8601

      event_stream_name = stream_name(event.error_id)

      write.(event, event_stream_name)
      telemetry.record :wrote_event, Telemetry::EventData.new(event, event_stream_name)

      logger.debug { "Recorded lapsed event (Error ID: #{event.error_id}, Lapsed Time: #{event.time})" }

      return event, event_stream_name
    end

    def self.register_telemetry_sink(publish)
      sink = Telemetry.sink
      publish.telemetry.register sink
      sink
    end

    module Telemetry
      class Sink
        include ::Telemetry::Sink

        record :published
        record :wrote_event
      end

      RaygunResponseData = Struct.new :response
      EventData = Struct.new :event, :stream_name

      def self.sink
        Sink.new
      end
    end

    module LogText
      module RaygunData
        def self.call(raygun_data)
          "Error ID: #{raygun_data.custom_data[:error_id]}, Error Message: #{raygun_data.error.message}, Occurred: #{raygun_data.occurred_time}, Hostname: #{raygun_data.machine_name})"
        end
      end

      module RecordedEvent
        def self.call(recorded_event)
          "Error ID: #{recorded_event.error_id}, Error Message: #{recorded_event.error.message}, Time: #{recorded_event.time}, Hostname: #{recorded_event.hostname})"
        end
      end
    end
  end
end
