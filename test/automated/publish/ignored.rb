require_relative '../automated_init'

context "Publish" do
  context "Ignored" do
    publish = Publish.new

    entity = Controls::Entity::Finished.example

    publish.store.add(entity.id, entity)

    recorded_event = Controls::Messages::Recorded.example

    publish.(recorded_event)

    writer = publish.write

    test "Nothing is written" do
      refute(writer.written?)
    end
  end
end
