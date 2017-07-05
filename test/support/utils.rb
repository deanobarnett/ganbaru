# frozen_string_literal: true

def with_no_stdout
  old_stdout = $stdout
  $stdout = StringIO.new
  yield
  $stdout = old_stdout
end

def with_no_stderr
  old_stderr = $stderr
  $stderr = StringIO.new
  yield
  $stderr = old_stderr
end
