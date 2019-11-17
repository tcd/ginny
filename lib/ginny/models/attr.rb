module Ginny
  # Used to generate an instance variable with getters/setters.
  #
  # [attr]: https://docs.ruby-lang.org/en/master/Module.html#method-i-attr
  # [attr_accessor]: https://docs.ruby-lang.org/en/master/Module.html#method-i-attr_accessor
  # [attr_reader]: https://docs.ruby-lang.org/en/master/Module.html#method-i-attr_reader
  class Attr

    # Name of the attribute.
    # @return [String]
    attr_accessor :name
    # Description of the attribute. [Markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) is supported.
    # @return [String]
    attr_accessor :description
    # [Type](https://rubydoc.info/gems/yard/file/docs/GettingStarted.md#Declaring_Types) of the attribute.
    # @return [String]
    attr_accessor :type
    # Default value for the attribute; set in it's Class's `initialize` function.
    # @return [String]
    attr_accessor :default
    # If `true`, an `attr_reader` will be generated for the attribute instead of an `attr_accessor`.
    # @return [Boolean]
    attr_accessor :read_only

    # @return [void]
    def initialize()
      self.read_only = false
    end

    # Constructor for an Attr. Use `create`, not `new`.
    #
    # @param args [Hash]
    # @return [Attr]
    def self.create(args = {})
      a = Ginny::Attr.new()
      a.name        = args[:name]
      a.description = args[:description]
      a.type        = args[:type]
      a.read_only   = args[:read_only]
      return a
    end

    # @param array [Array<Hash>]
    # @return [Array<Ginny::Attr>]
    def self.from_array(array)
      return array.map { |f| self.create(f) }
    end

    # @return [String]
    def render()
      parts = []
      parts << (@description&.length&.positive? ? @description.comment : nil)
      parts << "@return [#{self.type}]".comment
      parts << "attr_#{self.read_only ? 'reader' : 'accessor'} :#{self.name.downcase}"
      return parts.compact.join("\n")
    end

    # Used for documenting attributes that are "declared dynamically via meta-programming".
    # See the documentation on [YARD directives][1] for more info.
    #
    # [1]: https://www.rubydoc.info/gems/yard/file/docs/Tags.md#attribute
    #
    # @return [String]
    def render_dynamic()
      parts = []
      parts << "@!attribute #{self.name.downcase} [#{self.read_only ? 'r' : 'rw'}]".comment
      parts << (@description&.length&.positive? ? @description.indent(2).comment : nil)
      parts << "@return [#{self.type}]".indent(2).comment
      return parts.compact.join("\n")
    end

  end
end
