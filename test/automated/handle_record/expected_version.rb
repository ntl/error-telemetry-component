require_relative '../automated_init'

context "Handle Record Command" do
  context "Recorded" do
    context "Expected Version" do
      handler = Handlers::Record.new

      record_command = Controls::Messages::Record.example

      handler.(record_command)

      writer = handler.write

      recorded = writer.one_message do |event|
        event.instance_of?(Messages::Events::Recorded)
      end

      refute(recorded.nil?)

      test "No stream" do
        no_stream = writer.written?(recorded) do |_, expected_version|
          expected_version == MessageStore::NoStream.name
        end

        assert(no_stream)
      end
    end
  end
end
