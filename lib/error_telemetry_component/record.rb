module ErrorTelemetryComponent
  class Record
    include Messaging::StreamName

    include Log::Dependency

    dependency :clock, Clock::UTC
    dependency :identifier, Identifier::UUID::Random
    dependency :host_info, HostInfo
    dependency :write, Messaging::Postgres::Write

    initializer :error_data, :source

    category :error

    def self.build(error, source=nil)
      error_data = convert_error(error)

      instance = new(error_data, source)

      Clock::UTC.configure(instance)
      Identifier::UUID::Random.configure(instance)
      HostInfo.configure(instance)
      Messaging::Postgres::Write.configure(instance)

      instance
    end

    def self.call(error, source=nil)
      instance = build(error, source)
      instance.()
    end

    def call
      logger.trace { "Recoding error" }

      record = Messages::Commands::Record.new
      record.error_id = identifier.get
      record.hostname = host_info.hostname

      record.error = error_data

      record.source = source

      record.time = clock.iso8601

      command_stream_name = command_stream_name(record.error_id)

      write.(record, command_stream_name)

      logger.info { "Recoded error (#{LogText::RecordCommand.(record)})" }

      return record, command_stream_name
    end

    def self.convert_error(error)
      ErrorData::Convert::Error.(error)
    end

    module LogText
      module RecordCommand
        def self.call(record)
          "Error ID: #{record.error_id}, Error Message: #{record.error.message}, Time: #{record.time}, Hostname: #{record.hostname}, Source: #{record.source})"
        end
      end
    end
  end
end
