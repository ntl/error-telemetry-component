module ErrorTelemetryComponent
  module Messages
    module Commands
      class Record
        include Messaging::Message

        attribute :error_id, String
        attribute :time, String
        attribute :source, String
        attribute :hostname, String
        attribute :error, ErrorData

        def transform_write(data)
          raw_error_data = data.delete(:error).to_h

          data[:error] = raw_error_data
        end

        def transform_read(data)
          error_data = data.delete(:error)

          data[:error] = ErrorData.build(error_data)
        end
      end
    end
  end
end
