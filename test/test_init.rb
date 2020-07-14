ENV['CONSOLE_DEVICE'] ||= 'stdout'
ENV['LOG_COLOR'] ||= 'on'

if ENV['LOG_LEVEL']
  ENV['LOGGER'] ||= 'on'
else
  ENV['LOG_LEVEL'] ||= 'trace'
end

ENV['LOGGER'] ||= 'off'
ENV['LOG_OPTIONAL'] ||= 'on'

ENV['LOAD_CLIENT'] ||= 'off'

puts RUBY_DESCRIPTION

if ENV['LOAD_CLIENT'] == 'off'
  require_relative '../init'

  require 'error_telemetry_component/controls'
else
  require_relative '../client_init'

  require 'error_telemetry/client/controls'
end

include ErrorTelemetryComponent
