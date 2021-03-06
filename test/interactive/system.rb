require_relative './interactive_init'

recent_error = ErrorTelemetryComponent::Controls::Error.example
lapsed_error = ErrorTelemetryComponent::Controls::Error.example

record = ErrorTelemetryComponent::Record.build(recent_error, 'error-telemetry')
record.()

record = ErrorTelemetryComponent::Record.build(lapsed_error, 'error-telemetry')
Dependency::Substitute.(:clock, record)
record.clock.now = Controls::Time::Raw.example
record.()
