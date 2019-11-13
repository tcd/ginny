require "yaml"
require "json"

module Ginny

  # @param path [String]
  # @return [Hash<Symbol>]
  def self.load_yaml(path)
    return Ginny.symbolize_keys(YAML.load_file(File.expand_path(path)))
  end

  # @param path [String]
  # @return [Hash<Symbol>]
  def self.load_json(path)
    return JSON.parse(File.read(File.expand_path(path)), symbolize_names: true)
  end

end
