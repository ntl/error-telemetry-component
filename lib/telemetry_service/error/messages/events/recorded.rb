module TelemetryService
  module Error
    module Messages
      module Events
        class Recorded
          include EventStore::Messaging::Message

          attribute :error_id
          attribute :error
          attribute :hostname
          attribute :time
        end
      end
    end
  end
end