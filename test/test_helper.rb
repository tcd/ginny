$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "ginny"

require "minitest/autorun"

# Return Pathname for a file used in tests.
#
# Only works when tests are run from the project root.
#
# @param path [String]
def file_fixture(path)
  return File.expand_path(File.join(File.dirname(__dir__), "test", "fixtures", "files", path))
end
