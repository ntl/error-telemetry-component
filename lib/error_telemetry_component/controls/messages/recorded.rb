module ErrorTelemetryComponent
  module Controls
    module Messages
      module Recorded
        def self.example(error_id=nil, time: nil)
          error_id ||= Controls::ID.example
          time ||= Controls::Time.example

          message = ErrorTelemetryComponent::Messages::Events::Recorded.new

          message.error_id = error_id
          message.hostname = Controls::Host.name
          message.time = time
          message.error = Controls::ErrorData.example

          message
        end

        def self.data
          data = {}

          data['error_id'] = Controls::ID.example
          data['hostname'] = Controls::Host.name
          data['time'] = Controls::Time.example
          data['error'] = Controls::ErrorData.example.to_h

          data
        end

        module Lapsed
          def self.example(error_id=nil, time: nil)
            time ||= LapseTime.example
            Recorded.example(time)
          end
        end
      end
    end
  end
end
