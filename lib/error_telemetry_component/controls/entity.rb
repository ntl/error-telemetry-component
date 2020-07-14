module ErrorTelemetryComponent
  module Controls
    module Entity
      def self.example(published_time: nil)
        error_id = ID.example
        error = Controls::Error.example
        hostname = Controls::Host.name
        recorded_time = Controls::Time.reference

        entity = ErrorTelemetryComponent::Entity.new
        entity.id = error_id
        entity.error = error
        entity.hostname = hostname
        entity.recorded_time = recorded_time
        entity.published_time = published_time
        entity
      end

      module Finished
        def self.example
          published_time = Controls::Time.reference
          Entity.example published_time: published_time
        end
      end
    end
  end
end
