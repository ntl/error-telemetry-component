require_relative '../automated_init'

context "Publish" do
  context "Published" do
    time = ErrorTelemetryComponent::Controls::LapseTime.example
    recorded_event = ErrorTelemetryComponent::Controls::Messages::Recorded.example(time: time)

    error_id = recorded_event.error_id or fail

    publish = Publish.new

    publish.clock.now = Clock.parse(time)

    raygun_post = publish.raygun_post
    raygun_sink = RaygunClient::HTTP::Post.register_telemetry_sink(raygun_post)

    publish.(recorded_event)

    test "Sends the error to Raygun" do
      control_data = ErrorTelemetryComponent::Controls::RaygunData.example(time: time)

      posted = raygun_sink.posted? do |data|
        data == control_data
      end

      assert(posted)
    end

    context "Published Event" do
      writer = publish.write

      published = writer.one_message do |event|
        event.instance_of?(Messages::Events::Published)
      end

      test "Written" do
        refute(published.nil?)
      end

      test "Written to the error stream" do
        written_to_stream = writer.written?(published) do |stream_name|
          stream_name == "error-#{error_id}"
        end

        assert(written_to_stream)
      end

      context "Attributes" do
        test "error_id" do
          assert(published.error_id == error_id)
        end

        test "time" do
          assert(published.time == time)
        end
      end
    end
  end
end
