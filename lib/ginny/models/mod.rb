module Ginny
  # Used to generate a [module](https://ruby-doc.org/core-2.6.5/Module.html).
  class Mod

    # List of modules to declare the module inside. Only one is required.
    # @return [String]
    attr_accessor :modules
    # Description of the module. [Markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) is supported.
    # @return [String]
    attr_accessor :description
    # String to write into the body of the module.
    # @return [String]
    attr_accessor :body

    # @return [void]
    def initialize()
      self.modules = []
    end

    # Constructor for a Func. Use `create`, not `new`.
    #
    # @param args [Hash<Symbol>]
    # @return [Ginny::Func]
    def self.create(args = {})
      m = Ginny::Mod.new()
      m.modules     = args[:modules] unless args[:modules].nil?
      m.description = args[:description]
      m.body        = args[:body]
      return m
    end

    # Write generated code out to a file.
    #
    # @param folder [String]
    # @param file [String]
    # @return [String]
    def generate(folder = ".", file: nil)
      name = file.nil? ? self.file_name() : file
      path = File.join(File.expand_path(folder), name)
      File.open(path, "a") { |f| f.write(self.render() + "\n") }
      return path
    end

    # Return generated code as a string.
    #
    # @return [String]
    def render()
      return Ginny.mod(self.body, self.modules)
    end
  end
end
