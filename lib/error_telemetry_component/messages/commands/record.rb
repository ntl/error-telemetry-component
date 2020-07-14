module ErrorTelemetryComponent
  module Messages
    module Commands
      class Record
        include Messaging::Message

        attribute :error_id
        attribute :time
        attribute :source
        attribute :hostname
        attribute :error

        def transform_write(data)
          data[:error] = data.delete(:error).to_h
        end
=begin
        def self.build(data=nil)
          data ||= {}
          ::Transform::Read.instance(data, self)
        end

        def to_h
          ::Transform::Write.raw_data(self)
        end

        module Transformer
          def self.raw_data(instance)
            data = instance.attributes

            error_raw_data = ::Transform::Write.raw_data(instance.error)
            data[:error] = error_raw_data

            data
          end

          def self.instance(raw_data)
            instance = Record.new

            SetAttributes.(instance, raw_data, exclude: :error)

            error_raw_data = raw_data[:error]

            if error_raw_data
              instance.error = ErrorData.build(error_raw_data)
            end

            instance
          end
        end
=end
      end
    end
  end
end
