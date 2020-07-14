require 'socket'

require 'error_data'

require 'dependency'; Dependency.activate
require 'initializer'; Initializer.activate

require 'error_telemetry_component/messages/commands/record'

require 'error_telemetry_component/host_info'
require 'error_telemetry_component/record'

require 'error_telemetry_component/client/record'
