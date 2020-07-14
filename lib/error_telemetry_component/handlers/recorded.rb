module ErrorTelemetryComponent
  module Handlers
    class Recorded
      include Messaging::Handle
      include Messaging::StreamName

      dependency :clock, Clock::UTC
      dependency :writer, Messaging::Postgres::Write
      dependency :publish, ErrorTelemetryComponent::Publish

      category :error

      def configure_dependencies
        Clock::UTC.configure self
        Messaging::Postgres::Write.configure self
        ErrorTelemetryComponent::Publish.configure self
      end

      handle Messages::Events::Recorded do |event|
        publish.(event)
      end
    end
  end
end
