module TelemetryService
  module Controls
    module PublishError
      def self.example(error_id=nil, substitute: nil)
        error_id ||= Controls::ID.example
        substitutes = Array(substitute)

        recorded_event = TelemetryService::Controls::Messages::Recorded.example

        publish_error = TelemetryService::Error::Publish.build(recorded_event)

        substitutes.each do |name|
          SubstAttr::Substitute.(name, publish_error)

          if name == :clock
            publish_error.clock.now = Controls::Time.example
          end
        end

        publish_error
      end
    end
  end
end
