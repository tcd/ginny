require "dry/inflector"

module Ginny
  # Used to generate a [class](https://ruby-doc.org/core-2.6.5/Class.html).
  class Class

    # Name of the class.
    # @return [String]
    attr_accessor :name
    # Description of the class. [Markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) is supported.
    # @return [String]
    attr_accessor :description
    # Name of a class to inherit from. (Ex: `YourNewClass < Parent`)
    # @return [String]
    attr_accessor :parent
    # List of modules to declare the class inside.
    # @return [String]
    attr_accessor :modules
    # An array of {Ginny::Attr}s.
    # @return [Array<Ginny::Attr>]
    attr_accessor :attrs
    # String to write into the body of the class.
    # @return [String]
    attr_accessor :body
    # If `true`, a method similar to [ActiveRecord::Base.create](https://apidock.com/rails/ActiveRecord/Persistence/ClassMethods/create) will be generated for the class.
    # @return [Boolean]
    attr_accessor :default_constructor
    # String to prepend to the name of the generated file.
    # @return [String]
    attr_accessor :file_prefix
    # By default, names are *classified* using [Dry::Inflector#classify](https://github.com/dry-rb/dry-inflector#usage).
    # Set this to `false` to disable *classification* and use raw `name` input.
    # @return [Boolean]
    attr_accessor :classify_name

    # @return [void]
    def initialize()
      self.attrs = []
      self.modules = []
      self.file_prefix = ""
      self.body = ""
      self.default_constructor = false
      self.classify_name = true
    end

    # Constructor for a Class. Use `create`, not `new`.
    #
    # @param args [Hash<Symbol>]
    # @return [Class]
    def self.create(args = {})
      c = Ginny::Class.new()
      c.name        = args[:name]
      c.description = args[:description]
      c.parent      = args[:parent]
      c.modules     = args[:modules] unless args[:modules].nil?
      c.attrs       = Ginny::Attr.from_array(args[:attrs]) if args[:attrs]&.is_a?(Array)
      c.body        = args[:body] unless args[:body].nil?
      c.file_prefix = args[:file_prefix] || ""
      c.classify_name = args[:classify_name] unless args[:classify_name].nil?
      c.default_constructor = args[:default_constructor]
      return c
    end

    # Write generated code out to a file.
    #
    # @param folder [String]
    # @param file [String]
    # @return [String]
    def generate(folder = ".", file: nil)
      name = file.nil? ? self.file_name() : file
      path = File.join(File.expand_path(folder), name)
      File.open(path, "a") { |f| f.write(self.render() + "\n") }
      return path
    end

    # Return generated code as a string.
    #
    # @return [String]
    def render()
      parts = []
      parts << (self.description&.length&.positive? ? self.description.comment.strip : nil)
      parts << (self.parent.nil? ? "class #{self.class_name()}" : "class #{self.class_name()} < #{self.parent}")
      parts << self.render_attributes()
      parts << self.render_body()
      parts << "end"
      if self.modules.length > 0
        body = parts.compact.join("\n").gsub(/([[:blank:]]+)$/, "")
        return Ginny.mod(body, self.modules)
      end
      return parts.compact.join("\n").gsub(/([[:blank:]]+)$/, "")
    end

    # @return [String,nil]
    def render_body()
      if self.body.length > 0
        if self.default_constructor
          return ("\n" + self.constructor() + "\n\n" + self.body).indent(2)
        end
        return self.body.indent(2)
      end
      return "\n" + self.constructor().indent(2) if self.default_constructor
      return nil
    end

    # @return [String]
    def render_attributes()
      return nil unless self.attrs.length > 0
      return self.attrs.map(&:render).join("\n").indent(2)
    end

    # @return [String]
    def class_name()
      return self.name if !self.classify_name
      # Don't classify two letter names.
      # return self.name if self.name =~ /\A^[A-Za-z]{2}$\Z/
      inflector = Dry::Inflector.new do |inflections|
        inflections.plural("data", "data")
        inflections.singular(/([t])a\z/i, '\1a')
      end
      return inflector.classify(inflector.underscore(self.name))
    end

    # @return [String]
    def file_name()
      inflector = Dry::Inflector.new do |inflections|
        inflections.plural("data", "data")
        inflections.singular(/([t])a\z/i, '\1a')
      end
      return self.file_prefix + inflector.underscore(self.name) + ".rb"
    end

    # @return [String]
    def constructor()
      char = self.name.chr.downcase
      body = "#{char} = #{self.class_name}.new\n"
      body << self.attrs.map { |a| "#{char}.#{a.name} = params[:#{a.name}]\n" }.join()
      body << "return #{char}\n"
      Ginny::Func.create({
        name: "self.create",
        return_type: "self",
        params: [{ name: "params", type: "Hash", default: {} }],
        body: body,
      }).render()
    end

  end
end
