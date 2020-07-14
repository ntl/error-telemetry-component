require 'messaging/postgres'

require 'error_telemetry_component/load'

module ErrorTelemetry
  module Client
    Record = ErrorTelemetryComponent::Record

    Messages = ErrorTelemetryComponent::Messages
  end
end
