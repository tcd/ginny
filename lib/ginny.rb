# require "ginny/version"
# require "ginny/error"
# require "ginny/symbolize"
# require "ginny/string"
# require "ginny/Class"
# require "ginny/load"

module Ginny
  QUOTE = '"'.freeze
end

Dir.glob(File.join(__dir__, "ginny", "**/*.rb")).each { |file| require file }
