require_relative './test_init'

TestBench::Run.(
  'test/automated',
  exclude_pattern: %r{/skip\.|(?:_init\.rb|\.sketch\.rb|_sketch\.rb|\.skip\.rb)\z|_integration}
) or exit 1
