require 'error_telemetry/client'
require 'error_telemetry/client/controls'

error = ErrorTelemetry::Client::Controls::Error.example

ErrorTelemetry::Client::Record.(error, 'error-telemetry-package')
