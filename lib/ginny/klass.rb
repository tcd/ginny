require "erb"

module Ginny
  class Klass
    include ERB::Util

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
      k = Klass.new()
      k.name = args[:name]
      k.description = args[:description]
      return k
    end

    # @return [String]
    def render()
      parts = []
      parts << render_description()
      parts << "class #{self.name}"
      parts << self.render_attributes()
      parts << "end"
      return parts.compact.join("\n").strip
    end

    # @return [String]
    def render_description()
      return (self.description&.length&.positive? ? self.description.comment : "")
    end

    # @return [String]
    def render_attributes()
      return nil unless self.attrs.length > 0
      return self.attrs.map(&:render).join("\n").indent(2)
    end
  end

  class Attribute
    include ERB::Util

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
      a = Attribute.new()
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
      parts << "attr_accessor :#{self.name}"
      return parts.compact.join("\n")
    end

    # @return [String]
    def render_attr()
      access = "r"
      access << "w" unless self.read_only
      return "@!attribute #{self.name} [#{access}]"
    end

    # @return [String]
    def render_description()
      return (self.description&.length&.positive? ? self.description.indent(2).comment : nil)
    end

  end
end
