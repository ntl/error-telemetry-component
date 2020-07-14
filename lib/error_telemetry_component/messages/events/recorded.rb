module ErrorTelemetryComponent
  module Messages
    module Events
      class Recorded
        include Messaging::Message
        include Lapse

        attribute :error_id
        attribute :time
        attribute :source
        attribute :hostname
        attribute :error

        def self.build(data=nil)
          data ||= {}
          Transform::Read.instance(data, self)
        end

        def to_h
          Transform::Write.raw_data(self)
        end

        def lapsed?(now)
          elapsed_milliseconds(now) > self.class.effective_milliseconds
        end

        module Transformer
          def self.raw_data(instance)
            data = instance.attributes

            error_raw_data = Transform::Write.raw_data(instance.error)
            data[:error] = error_raw_data

            data
          end

          def self.instance(raw_data)
            instance = Recorded.new

            SetAttributes.(instance, raw_data, exclude: :error)

            error_raw_data = raw_data[:error]

            if error_raw_data
              instance.error = ErrorData.build(error_raw_data)
            end

            instance
          end
        end
      end
    end
  end
end
