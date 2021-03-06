require_relative './automated_init'

context "Error Projection" do
  context "Recorded" do
    entity = ErrorTelemetryComponent::Entity.new
    projection = ErrorTelemetryComponent::Projection.new entity

    recorded = ErrorTelemetryComponent::Controls::Messages::Recorded.example

    projection.(recorded)

    context "Entity Data" do
      test "id" do
        assert(entity.id == recorded.error_id)
      end

      test "error" do
        assert(entity.error == recorded.error)
      end

      test "hostname" do
        assert(entity.hostname == recorded.hostname)
      end

      test "recorded_time" do
        assert(entity.recorded_time == recorded.time)
      end
    end
  end

  context "Published" do
    entity = ErrorTelemetryComponent::Entity.new
    projection = ErrorTelemetryComponent::Projection.new entity

    published = ErrorTelemetryComponent::Controls::Messages::Published.example

    projection.(published)

    context "Entity Data" do
      test "published_time" do
        assert(entity.published_time == published.time)
      end
    end
  end

  context "Lapsed" do
    entity = ErrorTelemetryComponent::Entity.new
    projection = ErrorTelemetryComponent::Projection.new entity

    lapsed = ErrorTelemetryComponent::Controls::Messages::Lapsed.example

    projection.(lapsed)

    context "Entity Data" do
      test "lapsed_time" do
        assert(entity.lapsed_time == lapsed.time)
      end
    end
  end
end
