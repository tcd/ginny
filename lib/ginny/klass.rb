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

    # @param args [Hash<String>]
    # @return [Klass]
    def self.create(args = {})
      k = Klass.new()
      k.name = args[:name]
      k.description = args[:description]
      return k
    end

    # @return [String]
    def template()
      return <<~ERB
        <%=- render_description %>
        class <%= @name %>
          <%- for @attr in attrs -%>
            <%=- @attr.render %>
          <%- end -%>
        end
      ERB
    end

    # @return [String]
    def render()
      ERB.new(self.template, trim_mode: "-").result(binding)
    end

    # @return [String]
    def render_description()
      return (self.description&.length&.positive? ? self.description.comment : "")
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

    # @return [Attribute]
    def self.create(args = {})
      a = Attribute.new()
      a.name = args[:name]
      a.description = args[:description]
      a.type = args[:type]
      a.read_only = args[:read_only]
      return a
    end

    # # @param name [String]
    # # @param description [String]
    # # @param type [String]
    # # @param read_only [Boolean]
    # # @return [Attribute]
    # def self.create(name: "", description: "", type: nil, read_only: false)
    #   a = Attribute.new()
    #   a.name        = name
    #   a.description = description
    #   a.type        = type
    #   a.read_only   = read_only
    #   return a
    # end

    # @param array [Array<Hash>]
    # @return [Array<self>]
    def self.from_array(array)
      return array.map { |f| self.create(f) }
    end

    # @return [String]
    def template_1()
      return <<~ERB
        # @!attribute grams [rw]
        #   The weight of the product variant in grams.
        #   @return []
      ERB
    end

    # @return [String]
    def template()
      return <<~ERB
        # <%= attr_string %>
            <%=- render_description %>
        #   <%= type_string %>
        <%= attr_string %>
      ERB
    end

    # @return [String]
    def render()
      ERB.new(self.template, trim_mode: "-").result(binding)
    end

    # @return [String]
    def type_string()
      return "@return [#{self.type}]"
    end

    # @return [String]
    def attr_string()
      access = "r"
      access << "w" unless self.read_only
      return "@!attribute #{self.name} [#{access}]"
    end

    # @return [String]
    def render_description()
      return (self.description&.length&.positive? ? self.description.comment : "")
    end

  end
end
