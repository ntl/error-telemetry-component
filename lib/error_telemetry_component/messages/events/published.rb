module ErrorTelemetryComponent
  module Messages
    module Events
      class Published
        include Messaging::Message

        attribute :error_id
        attribute :time

        module LogText
          module Completion
            def self.call(published)
              "Published error (Error ID: #{published.error_id})"
            end
          end
        end
      end
    end
  end
end
