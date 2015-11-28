module TelemetryService
  module Controls
    module Messages
      module RecordError
        def self.example
          msg = TelemetryService::Messages::Commands::RecordError.new

          msg.error = Controls::ErrorData::JSON.data
          msg.machine_name = Controls::ErrorData.machine_name
          msg.time = Controls::Time.example

          msg
        end
      end
    end
  end
end