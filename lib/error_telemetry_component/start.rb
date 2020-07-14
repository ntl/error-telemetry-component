module ErrorTelemetryComponent
  module Start
    def self.call
      Consumers::Commands.start('error:command')
      Consumers::Events.start('error')
    end
  end
end
