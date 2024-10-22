module Ginny
  # Used to generate a [method][2].
  #
  # [1]: https://ruby-doc.org/core-2.6.5/Method.html
  # [2]: https://ruby-doc.org/core-2.6.5/doc/syntax/methods_rdoc.html
  class Func

    # Name of the function.
    # @return [String]
    attr_accessor :name
    # Description of the function. [Markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) is supported.
    # @return [String]
    attr_accessor :description
    # Return [type](https://rubydoc.info/gems/yard/file/docs/GettingStarted.md#Declaring_Types) of the function.
    # @return [String]
    attr_accessor :return_type
    # String to write into the body of the function.
    # @return [String]
    attr_accessor :body
    # List of modules to declare the function inside of.
    # @return [String]
    attr_accessor :modules
    # An array of {Ginny::Param}s.
    # @return [Array<Param>]
    attr_accessor :params

    # @return [void]
    def initialize()
      self.params = []
      self.modules = []
    end

    # Constructor for a Func. Use `create`, not `new`.
    #
    # @param args [Hash<Symbol>]
    # @return [Ginny::Func]
    def self.create(args = {})
      f = Ginny::Func.new()
      f.name        = args[:name]
      f.description = args[:description]
      f.return_type = args[:return_type]
      f.body        = args[:body]
      f.modules     = args[:modules] unless args[:modules].nil?
      f.params      = Ginny::Param.from_array(args[:params]) if args[:params]&.is_a?(Array)
      return f
    end

    # Return generated code as a string.
    #
    # @return [String]
    def render()
      # return self.render_compact() if self.body.nil? && self.params.length == 0
      parts = []
      parts << self.render_description()
      parts << self.params.map(&:render_doc).join("\n") unless self.params.length == 0
      parts << self.render_return_type()
      parts << "def " + self.name + self.render_params()
      parts << self.body.indent(2) unless self.body.nil?
      parts << "end"

      body = parts.compact.join("\n").gsub(/(\s+)$/, "")

      return Ginny.mod(body, self.modules) if self.modules.length > 0
      return body
    end

    # @return [String]
    def render_params()
      return "()" if self.params.length == 0
      # if self.params.length >= 5
      #   return "(\n" + self.params.map(&:render).join(",\n").indent(2) + "\n)"
      # end
      return "(" + self.params.map(&:render).join(", ") + ")"
    end

    # @return [String]
    def render_return_type
      type = self.return_type.nil? ? "void" : self.return_type
      return "# @return [#{type}]"
    end

    # @return [String]
    def render_description()
      return (self.description&.length&.positive? ? self.description.comment.strip : nil)
    end

  end
end
