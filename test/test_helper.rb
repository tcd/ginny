require "simplecov"
SimpleCov.start do
  add_filter "/bin/"
  add_filter "/test/"

  track_files "lib/**/*.rb"
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
    # SimpleCov::Formatter::HTMLFormatter,
    # SimpleCov::Formatter::Console,
  ])
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

# Return Pathname for a file used in tests.
#
# @param path [String]
def file_fixture(path)
  return File.expand_path(File.join(File.dirname(__dir__), "test", "fixtures", "files", path))
end
