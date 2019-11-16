module Ginny
  class Attr
    # @return [String]
    attr_accessor :name
    # @return [String]
    attr_accessor :description
    # @return [String]
    attr_accessor :type
    # Default value for the attribute; set in it's Class's `initialize` function.
    # @return [String]
    attr_accessor :default
    # @return [Boolean]
    attr_accessor :read_only

    # @return [void]
    def initialize()
      self.read_only = false
    end

    # @param args [Hash]
    # @return [Attr]
    def self.create(args = {})
      a = Ginny::Attr.new()
      a.name = args[:name]
      a.description = args[:description]
      a.type = args[:type]
      a.read_only = args[:read_only]
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
      parts << self.render_description()
      parts << "@return [#{self.type}]".comment
      parts << "attr_accessor :#{self.name.downcase}"
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
      parts << self.render_attr().comment
      parts << self.render_description()
      parts << "@return [#{self.type}]".indent(2).comment
      parts << "attr_accessor :#{self.name.downcase}"
      return parts.compact.join("\n")
    end

    # @return [String]
    def render_attr()
      access = "r"
      access << "w" unless self.read_only
      return "@!attribute #{self.name.downcase} [#{access}]"
    end

    # @return [String]
    def render_description()
      return (self.description&.length&.positive? ? self.description.indent(2).comment : nil)
    end

  end
end
