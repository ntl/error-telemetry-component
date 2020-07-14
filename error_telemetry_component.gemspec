# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'error_telemetry_component'
  s.version = '0.0.0.0'
  s.summary = 'Error telemetry recording and publishing component'
  s.description = ' '

  s.authors = ['The Eventide Project']
  s.email = 'opensource@eventide-project.org'
  s.homepage = 'https://github.com/ntl/error-telemetry-component'
  s.licenses = ['MIT']

  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.2.3'

  s.add_dependency 'eventide-postgres'
  s.add_dependency 'evt-component_host'

  s.add_dependency 'ntl-raygun_client'

  s.add_development_dependency 'test_bench'
end
