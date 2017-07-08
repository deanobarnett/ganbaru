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

def with_no_output
  old_stderr = $stderr
  old_stdout = $stdout
  $stderr = StringIO.new
  $stdout = StringIO.new
  yield
  $stderr = old_stderr
  $stdout = old_stdout
end
