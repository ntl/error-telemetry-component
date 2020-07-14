module ErrorTelemetryComponent
  module Controls
    module ErrorData
      def self.example
        ::ErrorData::Controls::ErrorData.example
      end

      def self.data
        ::Transform::Write.raw_data(example)
      end
    end
  end
end
