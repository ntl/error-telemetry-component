module ErrorTelemetryComponent
  module ConvertErrorData
    module RaygunData
      def self.call(recorded_event)
        logger.trace { "Converting recorded event to Raygun data" }
        logger.trace(tag: :data) { "Recorded event: #{recorded_event.inspect}" }

        data = RaygunClient::Data.new

        data.occurred_time = recorded_event.time
        data.machine_name = recorded_event.hostname
        data.client = RaygunClient::Data::ClientInfo.build

        data.error = recorded_event.error

        data.tags = Array(recorded_event.source)
        data.custom_data = { :error_id => recorded_event.error_id }

        logger.debug { "Converted recorded event to Raygun data" }
        logger.debug(tag: :data) { "Raygun data: #{data.inspect}" }

        data
      end

      def self.logger
        @logger ||= Log.build(self)
      end
    end
  end
end
