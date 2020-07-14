require_relative '../automated_init'

context "Recorded Message" do
  test "Serialize" do
    example = ErrorTelemetryComponent::Controls::Messages::Recorded.example

    control_data = ErrorTelemetryComponent::Controls::Messages::Recorded.data

    message_data = Transform::Write.(example, :message_data)
    data = message_data.data

    assert(data == control_data)
  end

  context "Deserialize" do
    example_data = ErrorTelemetryComponent::Controls::Messages::Recorded.data

    control_instance = ErrorTelemetryComponent::Controls::Messages::Recorded.example

    instance = ErrorTelemetryComponent::Messages::Events::Recorded.build(example_data)

    assert(instance == control_instance)
  end
end
