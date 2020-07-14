require_relative '../../automated_init'

context "Recorded Message" do
  context "Lapsed Predicate" do
    recorded_event = ErrorTelemetryComponent::Controls::Messages::Recorded::Lapsed.example

    context "Lapsed" do
      now = ErrorTelemetryComponent::Controls::LapseTime::Raw.later

      comment "(After #{recorded_event.class.effective_hours} hours)"

      lapsed = recorded_event.lapsed?(now)

      test do
        assert(lapsed)
      end
    end

    context "Not Lapsed" do
      now = ErrorTelemetryComponent::Controls::LapseTime::Raw.example
      now -= 1

      comment "(After #{recorded_event.class.effective_hours} hours, minus one second)"

      lapsed = recorded_event.lapsed?(now)

      test do
        refute(lapsed)
      end
    end
  end
end
