# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'error_telemetry-client'
  s.version = '0.1.0.0'
  s.summary = 'Interface for processes to interact with the error-telemetry component'
  s.description = ' '

  s.authors = ['The Eventide Project']
  s.email = 'opensource@eventide-project.org'
  s.homepage = 'https://github.com/evt-archive/error-telemetry-component'
  s.licenses = ['MIT']

  s.require_paths = ['lib']

  s.files = [
    'lib/error_telemetry_component/client.rb',
    'lib/error_telemetry_component/client/record.rb',
    'lib/error_telemetry_component/messages/commands/record.rb',
    'lib/error_telemetry_component/host_info.rb',
    'lib/error_telemetry_component/record.rb',
    'lib/error_telemetry_component/controls/error.rb',
    'lib/error_telemetry_component/controls/record_error.rb',
    'lib/error_telemetry_component/controls/source.rb',
    'lib/error_telemetry_component/controls/time.rb'
  ]
  s.platform = Gem::Platform::RUBY
  s.bindir = 'bin'

  s.add_dependency 'evt-clock'
  s.add_dependency 'evt-dependency'
  s.add_dependency 'evt-error_data'

  s.add_dependency 'eventide-postgres'
end

