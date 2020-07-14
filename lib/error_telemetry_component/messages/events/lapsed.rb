module ErrorTelemetryComponent
  module Messages
    module Events
      class Lapsed
        include Messaging::Message

        attribute :error_id
        attribute :time

        module LogText
          module Completion
            def self.call(lapsed)
              "Lapsed error - not published (Error ID: #{lapsed.error_id})"
            end
          end
        end
      end
    end
  end
end
