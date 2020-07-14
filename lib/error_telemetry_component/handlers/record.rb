module ErrorTelemetryComponent
  module Handlers
    class Record
      include Messaging::Handle
      include Messaging::StreamName

      include Log::Dependency

      dependency :store, Store
      dependency :write, Messaging::Postgres::Write

      category :error

      def configure
        Store.configure(self)
        Messaging::Postgres::Write.configure(self)
      end

      handle Messages::Commands::Record do |record|
        error_id = command.error_id

        version = store.get_version(error_id)

        if version != MessageStore::NoStream.version
          logger.info(tag: :ignored) { "Command ignored (Command: #{record.message_type}, Error ID: #{error_id})" }
          return
        end

        recorded = Messages::Events::Recorded.follow(record)

        stream_name = stream_name(error_id)

        write.initial(recorded, stream_name)
      end
    end
  end
end

