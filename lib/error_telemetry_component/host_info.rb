module ErrorTelemetryComponent
  class HostInfo
    configure :host_info, factory_method: :new

    def hostname
      self.class.hostname
    end

    def self.hostname
      Socket.gethostname
    end

    module Substitute
      NullHostInfo = Struct.new(:hostname)

      def self.build
        NullHostInfo.new
      end
    end
  end
end
