require_relative '../automated_init'

context "Handle Record Command" do
  context "Recorded" do
    handler = Handlers::Record.new

    record_command = Controls::Messages::Record.example

    error_id = record_command.error_id or fail
    time = record_command.time or fail
    source = record_command.source or fail
    hostname = record_command.hostname or fail
    error = record_command.error or fail

    handler.(record_command)

    writer = handler.write

    recorded = writer.one_message do |event|
      event.instance_of?(Messages::Events::Recorded)
    end

    test "Recorded Event is Written" do
      refute(recorded.nil?)
    end

    test "Written to the error stream" do
      written_to_stream = writer.written?(recorded) do |stream_name|
        stream_name == "error-#{error_id}"
      end

      assert(written_to_stream)
    end

    context "Attributes" do
      test "error_id" do
        assert(recorded.error_id == error_id)
      end

      test "time" do
        assert(recorded.time == time)
      end

      test "source" do
        assert(recorded.source == source)
      end

      test "hostname" do
        assert(recorded.hostname == hostname)
      end

      test "error" do
        assert(recorded.error == error)
      end
    end
  end
end
