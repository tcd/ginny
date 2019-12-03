require "pathname"
require "json"
require "yaml"

module Ginny

  # Load data from a YAML file.
  #
  # @param path [String]
  # @return [Hash<Symbol>]
  def self.load_yaml(path)
    return Coolkit.symbolize_keys(YAML.load_file(File.expand_path(path)))
  end

  # Load data from a JSON file.
  #
  # @param path [String]
  # @return [Hash<Symbol>]
  def self.load_json(path)
    return JSON.parse(File.read(File.expand_path(path)), symbolize_names: true)
  end

  # @param path [String] Path of the file to determine the extension of.
  # @return [String]
  def self.get_extension(path)
    file = Pathname.new(path)
    return file.extname.downcase
  end

  # Load data from a YAML or JSON file.
  #
  # @param path [String]
  # @return [Hash<Symbol>]
  def self.load_file(path)
    case Pathname.new(path).extname.downcase
    when ".yml", ".yaml"
      return self.load_yaml(path)
    when ".json"
      return self.load_json(path)
    else
      raise Ginny::Error "invalid file type"
    end
  end

end
