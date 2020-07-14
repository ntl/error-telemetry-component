require_relative '../automated_init'

context "Publish" do
  context "Lapsed" do
    recorded_event = ErrorTelemetryComponent::Controls::Messages::Recorded::Lapsed.example

    error_id = recorded_event.error_id or fail
    time = recorded_event.time or fail

    now = ErrorTelemetryComponent::Controls::LapseTime::Raw.later

    publish = Publish.new

    publish.clock.now = now

    publish.(recorded_event)

    test "Does not send the error to Raygun" do
      posted = publish.raygun_post.posted?

      refute(posted)
    end

    context "Lapsed Event" do
      writer = publish.write

      lapsed = writer.one_message do |event|
        event.instance_of?(Messages::Events::Lapsed)
      end

      test "Written" do
        refute(lapsed.nil?)
      end

      test "Written to the error stream" do
        written_to_stream = writer.written?(lapsed) do |stream_name|
          stream_name == "error-#{error_id}"
        end

        assert(written_to_stream)
      end

      context "Attributes" do
        test "error_id" do
          assert(lapsed.error_id == error_id)
        end

        test "time" do
          assert(lapsed.time == Clock.iso8601(now))
        end
      end
    end
  end
end
