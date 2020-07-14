module ErrorTelemetryComponent
  module Consumers
    class Commands
      include Consumer::Postgres

      handler Handlers::Record
    end

    class Events
      include Consumer::Postgres

      handler Handlers::Recorded
    end
  end
end
