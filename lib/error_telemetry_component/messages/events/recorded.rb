module ErrorTelemetryComponent
  module Messages
    module Events
      class Recorded
        include EventStore::Messaging::Message
        include Lapse

        attribute :error_id
        attribute :error
        attribute :hostname
        attribute :time

        def self.build(data)
          new.tap do |instance|
            SetAttributes.(instance, data, exclude: :error)

            error_data = ErrorData.build data['error']

            instance.error = error_data
          end
        end

        # TODO Move out [Scott, Sun Jan 31 2016]
        # Controls need access to this, too
        def lapsed?(now)
          elapsed_milliseconds(now) > self.class.effective_milliseconds
        end
      end
    end
  end
end
