require_relative '../automated_init'

context "Record Message" do
  test "Serialize" do
    example = ErrorTelemetryComponent::Controls::Messages::Record.example

    control_data = ErrorTelemetryComponent::Controls::Messages::Record.data

    message_data = Transform::Write.(example, :message_data)
    data = message_data.data

    assert(data == control_data)
  end

  context "Deserialize" do
    example_data = ErrorTelemetryComponent::Controls::Messages::Record.data

    control_instance = ErrorTelemetryComponent::Controls::Messages::Record.example

    instance = ErrorTelemetryComponent::Messages::Commands::Record.build(example_data)

    assert(instance == control_instance)
  end
end
