require "simplecov"
formatters = []
formatters << SimpleCov::Formatter::HTMLFormatter
if ENV["CI"] == "true"
  require "coveralls"
  formatters << Coveralls::SimpleCov::Formatter
end
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(formatters)

SimpleCov.start do
  add_filter "/bin/"
  add_filter "/exe/"
  add_filter "/test/"

  track_files "/lib/**/*.rb"
end

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "ginny"
require "pry"

require "minitest/autorun"
require "minitest/focus"
require "minitest/reporters"
Minitest::Reporters.use!([
  Minitest::Reporters::DefaultReporter.new(color: true),
  # Minitest::Reporters::SpecReporter.new,
])


# ==============================================================================
# Helper Methods
# ==============================================================================

require "time"
require "fileutils"

# Return Pathname for a file used in tests.
#
# @param path [String]
def file_fixture(path)
  return File.expand_path(File.join(File.dirname(__dir__), "test", "fixtures", "files", path))
end

# Path to a scratch folder that can be used for testing.
#
# The folder is created before and emptied after each time the test suite is run.
#
# @return [String]
def scratch_folder()
  return File.expand_path(File.join(File.dirname(__dir__), "tmp", "scratch-folder-for-testing"))
end

# @return [void]
def make_test_folder()
  FileUtils.mkdir_p(scratch_folder())
end

# @return [void]
def make_test_folder()
  FileUtils.rm_rf(scratch_folder())
end

# ==============================================================================
# Custom Assertions
# ==============================================================================

module MiniTest::Assertions
  # Calls `assert_equal`; prints arguments if the assertion fails.
  #
  # @raise [ArgumentError] unless both arguments are strings
  # @param want [String] Expected
  # @param have [String] Actual
  def assert_equal_and_print(want, have)
    raise ArgumentError unless want.is_a?(String) && have.is_a?(String)

    clear = "\e[0m"
    _bold = "\e[1m"
    red = "\e[31m"
    green = "\e[32m"

    msg = <<~END
      #{'=' * 80}
      expected:
      #{green + want + clear}
      actual:
      #{red + have + clear}
      #{'=' * 80}
    END

    # assert_equal(want, have, "#{clear}\n#{'=' * 80}\nEXPECTED:\n\n#{want}\nACTUAL:\n\n#{have}\n#{'=' * 80}\n#{red}")
    assert_equal(want, have, ("\n" + clear + msg + red))
  end
end
