require "coolkit"

# Ruby code generator.
module Ginny
  QUOTE = '"'.freeze
  INDENT = "  ".freeze
end

Dir.glob(File.join(__dir__, "ginny", "**/*.rb")).each { |file| require file }
