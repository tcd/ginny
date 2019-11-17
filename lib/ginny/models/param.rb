module Ginny
  # Used to generate a function [parameter][2].
  #
  # [1]: http://ruby-for-beginners.rubymonstas.org/bonus/arguments_parameters.html
  # [2]: https://ruby-doc.org/core-2.6.5/doc/syntax/methods_rdoc.html#label-Arguments
  class Param

    # Name of the param.
    # @return [String]
    attr_accessor :name
    # Description of the param. [Markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) is supported.
    # @return [String]
    attr_accessor :description
    # [Type](https://rubydoc.info/gems/yard/file/docs/GettingStarted.md#Declaring_Types) of the attribute.
    # @return [String]
    attr_accessor :type
    # Default value for the Param.
    # Set `optional` as `true` for a default `nil` value.
    # @return [String]
    attr_accessor :default
    # If `true`, the default value will be `nil`.
    # FIXME: This is a workaround for the fact that that passing `nil` to `default` messes with conditionals. Not sure of a simpler way to do this.
    # @return [Boolean]
    attr_accessor :optional
    # If `true`, the param will be generated as a [keyword argument](https://bugs.ruby-lang.org/issues/14183).
    # @return [Boolean]
    attr_accessor :keyword

    # Constructor for a Param. Use `create`, not `new`.
    #
    # @param [Hash<Symbol>] args
    # @option args [String] :name
    # @option args [String] :description
    # @option args [String] :type
    # @option args [Object] :default
    # @option args [Boolean] :keyword (false)
    # @option args [Boolean] :optional (false)
    # @return [Ginny::Param]
    def self.create(args = {})
      p = Ginny::Param.new()
      p.name        = args[:name]
      p.description = args[:description]
      p.type        = args[:type]
      p.default     = args[:default]
      p.keyword     = args[:keyword] || false
      p.optional    = args[:optional] || false
      return p
    end

    # @param array [Array<Hash>]
    # @return [Array<Ginny::Param>]
    def self.from_array(array)
      return array.map { |p| self.create(p) }
    end

    # @return [String]
    def render
      parts = []
      parts << @name
      default = self.render_default_value()
      if @keyword
        parts << ":"
        parts << (" " + default) if default
      elsif default
        parts << (" = " + default)
      end
      return parts.compact.join("")
    end

    # @return [String,nil]
    def render_default_value
      # `nil` default value
      return "nil" if self.optional
      # No default value
      return nil if self.default.nil?
      # Add quotes to a String.
      return (Ginny::QUOTE + self.default + Ginny::QUOTE) if self.type == "String" || self.default.is_a?(String)
      # Add colon to a Symbol.
      return ":#{self.default}" if self.type == "Symbol" || self.default.is_a?(Symbol)
      # `to_s` should handle everything else.
      return self.default.to_s
    end

    # @return [String]
    def render_doc
      return "# @param #{self.name} [#{self.type}] #{self.description}".strip
    end

  end
end
