# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'error_telemetry-client'
  s.version = '0.1.0.1'
  s.summary = 'Interface for processes to interact with the error-telemetry component'
  s.description = ' '

  s.authors = ['The Eventide Project']
  s.email = 'opensource@eventide-project.org'
  s.homepage = 'https://github.com/ntl/error-telemetry-component'
  s.licenses = ['MIT']

  s.require_paths = ['lib']

  files = Dir['lib/error_telemetry/**/*.rb']

  files += Dir['lib/error_telemetry_component/{controls.rb,controls/**/*.rb}']

  files << 'lib/error_telemetry_component/load.rb'

  File.read('lib/error_telemetry_component/load.rb').each_line.map do |line|
    next if line == "\n"

    _, filename = line.split(/[[:blank:]]+/, 2)

    filename.gsub!(/['"]/, '')
    filename.strip!

    filename = File.join('lib', "#{filename}.rb")

    if File.exist?(filename)
      files << filename
    end
  end

  s.files = files

  s.platform = Gem::Platform::RUBY
  s.bindir = 'bin'

  s.add_dependency 'evt-messaging-postgres'
  s.add_dependency 'evt-configure'

  s.add_dependency 'ntl-error_data'

  s.add_development_dependency 'test_bench'
end

