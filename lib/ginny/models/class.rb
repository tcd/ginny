module Ginny
  # [Classes](https://ruby-doc.org/core-2.6.5/Class.html)
  class Class
    # @return [String]
    attr_accessor :name
    # @return [String]
    attr_accessor :description
    # @return [Array<Ginny::Attr>]
    attr_accessor :attrs

    # @return [void]
    def initialize()
      self.attrs = []
    end

    # @param args [Hash<Symbol>]
    # @return [Class]
    def self.create(args = {})
      c = Ginny::Class.new()
      c.name = args[:name]
      c.description = args[:description]
      c.attrs = Ginny::Attr.from_array(args[:attrs]) if args[:attrs]&.is_a?(Array)
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
end
