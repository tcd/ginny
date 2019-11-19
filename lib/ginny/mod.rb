module Ginny

  # Used to generate a [module](https://ruby-doc.org/core-2.6.5/doc/syntax/modules_and_classes_rdoc.html).
  #
  # More accurately, wrap the `body` (first argument) with any following module definitions (additional arguments).
  #
  # @example
  #   Ginny.mod("puts('Hello World')", "Level1", "Level2")
  #   #=> module Level1
  #         module Level2
  #           puts('Hello World')
  #         end
  #       end
  #
  # @param body [String] Name of module namespaces.
  # @param names [String,Array<String>] Name of module namespaces.
  # @return [String]
  def self.mod(body, *names)
    names.flatten!
    count = names.length
    return body unless count.positive?()
    level = 0
    head = []
    tail = []
    names.each do |name|
      head.push("module #{name}".indent(level))
      tail.unshift("end".indent(level))
      level += 2
    end
    return (head + [body&.indent(level)] + tail).compact.join("\n")
  end
end
