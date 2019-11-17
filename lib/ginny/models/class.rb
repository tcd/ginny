module Ginny
  # Used to generate a [class](https://ruby-doc.org/core-2.6.5/Class.html)
  class Class

    # Name of the class.
    # @return [String]
    attr_accessor :name
    # Description of the class. [Markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) is supported.
    # @return [String]
    attr_accessor :description
    # Name of a class to inherit from. (Ex: `YourNewClass < Parent`)
    # @return [String]
    attr_accessor :parent
    # An array of {Ginny::Attr}s.
    # @return [Array<Ginny::Attr>]
    attr_accessor :attrs

    # @return [void]
    def initialize()
      self.attrs = []
    end

    # Constructor for a Class. Use `create`, not `new`.
    #
    # @param args [Hash<Symbol>]
    # @return [Class]
    def self.create(args = {})
      c = Ginny::Class.new()
      c.name        = args[:name]
      c.description = args[:description]
      c.parent      = args[:parent]
      c.attrs       = Ginny::Attr.from_array(args[:attrs]) if args[:attrs]&.is_a?(Array)
      return c
    end

    # @param folder [String]
    # @return [String]
    def write_to_file(folder)
      name = self.name.downcase + ".rb"
      path = File.join(File.expand_path(folder), name)
      File.open(path, "a") { |f| f.write(self.render()) }
      return path
    end

    # @return [String]
    def render()
      parts = []
      parts << (self.description&.length&.positive? ? self.description.comment.strip : nil)
      parts << (self.parent.nil? ? "class #{self.name}" : "class #{self.name} < #{self.parent}")
      parts << self.render_attributes()
      parts << "end"
      return parts.compact.join("\n")
    end

    # @return [String]
    def render_attributes()
      return nil unless self.attrs.length > 0
      return self.attrs.map(&:render).join("\n").indent(2)
    end

  end
end
