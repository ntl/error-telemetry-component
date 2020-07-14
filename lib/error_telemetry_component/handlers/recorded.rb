module ErrorTelemetryComponent
  module Handlers
    class Recorded
      include Messaging::Handle

      dependency :publish, ErrorTelemetryComponent::Publish

      def configure
        ErrorTelemetryComponent::Publish.configure(self)
      end

      handle Messages::Events::Recorded do |event|
        publish.(event)
      end
    end
  end
end
