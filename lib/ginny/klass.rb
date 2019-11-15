module Ginny
  class Klass
    # @!attribute name [rw]
    #   @return [String]
    attr_accessor :name
    # @!attribute description [rw]
    #   @return [String]
    attr_accessor :description
    # @!attribute attrs [rw]
    #   @return [Array<Ginny::Attribute>]
    attr_accessor :attrs

    # @return [void]
    def initialize()
      self.attrs = []
    end

    # @param args [Hash<Symbol>]
    # @return [Klass]
    def self.create(args = {})
      k = Ginny::Klass.new()
      k.name = args[:name]
      k.description = args[:description]
      k.attrs = Ginny::Attribute.from_array(args[:attrs]) if args[:attrs]&.is_a?(Array)
      return k
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
      parts << render_description()
      parts << "class #{self.name}"
      parts << self.render_attributes()
      parts << "end\n"
      return parts.compact.join("\n")
    end

    # @return [String]
    def render_description()
      return (self.description&.length&.positive? ? self.description.comment.strip : "")
    end

    # @return [String]
    def render_attributes()
      return nil unless self.attrs.length > 0
      return self.attrs.map(&:render).join("\n").indent(2)
    end
  end

  class Attribute
    # @!attribute name [rw]
    #   @return [String]
    attr_accessor :name
    # @!attribute description [rw]
    #   @return [String]
    attr_accessor :description
    # @!attribute type [rw]
    #   @return [String]
    attr_accessor :type
    # @!attribute read_only [rw]
    #   @return [Boolean]
    attr_accessor :read_only

    # @return [void]
    def initialize()
      self.read_only = false
    end

    # @param args [Hash]
    # @return [Attribute]
    def self.create(args = {})
      a = Ginny::Attribute.new()
      a.name = args[:name]
      a.description = args[:description]
      a.type = args[:type]
      a.read_only = args[:read_only]
      return a
    end

    # @param array [Array<Hash>]
    # @return [Array<self>]
    def self.from_array(array)
      return array.map { |f| self.create(f) }
    end

    # @return [String]
    def render()
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
