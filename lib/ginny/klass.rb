require "erb"

module Ginny
  class Klass
    include ERB::Util

    attr_accessor :name
    attr_accessor :description
    attr_accessor :attrs

    # @return [void]
    def initialize(name, description)
      @name = name
      @description = description
    end

    # @return [String]
    def template
      return <<~ERB
        <%= description -%>
        class <%= @name %>
        end
      ERB
    end

    # @return [String]
    def render
      ERB.new(self.template, trim_mode: "%-").result(binding)
    end

    # @return [String]
    def render_description()
      return nil
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

    def initialize(name:, description:, type:, read_only: false)
      self.name = name
      self.description = description
      self.type = type
      self.read_only = read_only
    end

    # @return [String]
    def template_1
      return <<~ERB
        # @!attribute grams [rw]
        #   The weight of the product variant in grams.
        #   @return []
      ERB
    end

    # @return [String]
    def template
      return <<~ERB
        # <%= attr_string %>
        #   <%= description -%>
        #   <%= type_string %>
        <%= attr_string %>
      ERB
    end

    # @return [String]
    def render
      ERB.new(self.template, trim_mode: "%-").result(binding)
    end

    # @return [String]
    def type_string()
      return "@return [#{self.type}]"
    end

    # @return [String]
    def attr_string()
      access = "r"
      access << "w" unless self.read_only
      return "@!attribute #{self.grams} [#{access}]"
    end

  end
end
