module Telemetry
  module Errors
    module Messages
      module Commands
        class RecordError
          include EventStore::Messaging::Message
        end
      end
    end
  end
end