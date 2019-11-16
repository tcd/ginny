module Ginny
  class Func
    # @return [String]
    attr_accessor :name
    # @return [String]
    attr_accessor :description
    # @return [String]
    attr_accessor :return_type
    # @return [String]
    attr_accessor :body
    # @return [Array<Param>]
    attr_accessor :params

    # @return [void]
    def initialize()
      self.params = []
    end

    # @param args [Hash<Symbol>]
    # @return [Ginny::Func]
    def self.create(args = {})
      f = Ginny::Func.new()
      f.name        = args[:name]
      f.description = args[:description]
      f.return_type = args[:return_type]
      f.params      = Ginny::Param.from_array(args[:params]) if args[:params]&.is_a?(Array)
      return f
    end

    # @return [String]
    def render()
      # return self.render_compact() if self.body.nil? && self.params.length == 0
      parts = []
      parts << self.render_description()
      parts << self.params.map(&:render_doc).join("\n") unless self.params.length == 0
      parts << self.render_return_type()
      parts << "def " + self.name + self.render_params()
      parts << "end"
      return parts.compact.join("\n")
    end

    # # @return [String]
    # def render_compact()
    #   parts = []
    #   parts << self.description
    #   parts << "def #{self.name}(); end"
    #   return parts.compact.join("\n")
    # end

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
