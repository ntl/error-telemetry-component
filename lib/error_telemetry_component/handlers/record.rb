module ErrorTelemetryComponent
  module Handlers
    class Record
      include Messaging::Handle
      include Messaging::StreamName

      include Log::Dependency

      dependency :store, Store
      dependency :writer, Messaging::Postgres::Write

      category :error

      def configure_dependencies
        Store.configure(self)
        Messaging::Postgres::Write.configure(self)
      end

      handle Messages::Commands::Record do |command|
        version = store.get_version command.error_id

        if version != :no_stream
          return
        end

        logger.todo "Remove special handling of error after event-store-messaging uses the serialize library [Nathan Ladd, Scott Bellware, Fri Feb 5 2016]"
        event = Messages::Events::Recorded.proceed command, :exclude => [:error]
        event.error = command.error

        stream_name = stream_name(event.error_id)

        writer.write_initial event, stream_name
      end
    end
  end
end

