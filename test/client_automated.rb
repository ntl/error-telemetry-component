require_relative './client_test_init'

TestBench::Run.(
  'test/automated/client',
  exclude_file_pattern: %r{/skip\.|(?:_init\.rb|\.sketch\.rb|_sketch\.rb|\.skip\.rb)\z|_integration}
) or exit 1
