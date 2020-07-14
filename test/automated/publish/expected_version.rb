require_relative '../automated_init'

context "Publish" do
  context "Expected Version" do
    publish = Publish.new

    entity = Controls::Entity.example
    version = Controls::Version.example

    publish.store.add(entity.id, entity, version)

    recorded_event = Controls::Messages::Recorded.example

    publish.clock.now = Clock.parse(recorded_event.time)

    publish.(recorded_event)

    writer = publish.write

    published = writer.one_message do |event|
      event.instance_of?(Messages::Events::Published)
    end

    refute(published.nil?)

    test "Is not set" do
      is_entity_version = writer.written?(published) do |_, expected_version|
        expected_version.nil? && expected_version != version
      end

      assert(is_entity_version)
    end
  end
end
