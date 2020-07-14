require_relative '../../automated_init'

context "Recorded Message" do
  context "Transformation" do
    test "Instance Into Message Data" do
      example = ErrorTelemetryComponent::Controls::Messages::Recorded.example

      control_data = ErrorTelemetryComponent::Controls::Messages::Recorded.data

      message_data = Transform::Write.(example, :message_data)
      data = message_data.data

      assert(data == control_data)
    end

    context "Message Data Into an Instance" do
      example_data = ErrorTelemetryComponent::Controls::Messages::Recorded.data

      control_instance = ErrorTelemetryComponent::Controls::Messages::Recorded.example

      instance = ErrorTelemetryComponent::Messages::Events::Recorded.build(example_data)

      assert(instance == control_instance)
    end
  end
end
