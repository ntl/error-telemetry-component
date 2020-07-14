require_relative './client_automated_init'

context "Client" do
  context "Recording an Error" do
    substitute = [:host_info, :clock]
    record_error = ErrorTelemetry::Client::Controls::RecordError.example(substitute: substitute)

    record_message, stream_name = record_error.()

    read_data = MessageStore::Postgres::Get::Stream::Last.(stream_name)

    context "Writes the record message" do
      test "Event Type" do
        assert(read_data.type == record_message.message_type)
      end

      test "error" do
        read_error = read_data.data[:error]

        recorded_error = record_error.error_data
        recorded_error = ::Transform::Write.raw_data(recorded_error)
        recorded_error = Casing::Underscore.(recorded_error)

        assert(read_error == recorded_error)
      end

      test "hostname" do
        recorded_hostname = record_error.host_info.hostname
        read_hostname = read_data.data[:hostname]

        assert(read_hostname == recorded_hostname)
      end

      test "source" do
        recorded_source = record_error.source
        read_source = read_data.data[:source]

        assert(read_source == recorded_source)
      end

      test "time" do
        recorded_time = record_error.clock.iso8601
        read_time = read_data.data[:time]

        assert(read_time == recorded_time)
      end
    end
  end
end
