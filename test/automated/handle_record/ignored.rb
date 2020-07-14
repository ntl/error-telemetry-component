require_relative '../automated_init'

context "Handle Record Command" do
  context "Recorded" do
    context "Ignored" do
      handler = Handlers::Record.new

      entity = Controls::Entity.example

      handler.store.add(entity.id, entity)

      record_command = Controls::Messages::Record.example

      handler.(record_command)

      writer = handler.write

      test "Recorded Event is not written" do
        refute(writer.written?)
      end
    end
  end
end
