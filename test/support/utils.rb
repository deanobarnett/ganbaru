# frozen_string_literal: true
def with_no_stdout
  old_stdout = $stdout
  $stdout = StringIO.new
  yield
  $stdout = old_stdout
end
