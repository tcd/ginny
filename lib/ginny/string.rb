class String
  # Same as {indent}, except it indents the receiver in-place.
  #
  # Returns the indented string, or `nil` if there was nothing to indent.
  #
  # @param amount [Integer] The level of indentation to add.
  # @param indent_string [String] Defaults to tab if a tab is present in the string, and `" "` otherwise.
  # @param indent_empty_lines [Boolean]
  #
  # @return [void]
  def indent!(amount, indent_string = nil, indent_empty_lines = false)
    indent_string = indent_string || self[/^[ \t]/] || " "
    re = indent_empty_lines ? /^/ : /^(?!$)/
    gsub!(re, indent_string * amount)
  end

  # Indents the lines in the receiver.
  #
  # @example
  #   <<EOS.indent(2)
  #   def some_method
  #     some_code
  #   end
  #   EOS
  #   # =>
  #     def some_method
  #       some_code
  #     end
  #
  # The second argument, `indent_string`, specifies which indent string to
  # use. The default is `nil`, which tells the method to make a guess by
  # peeking at the first indented line, and fallback to a space if there is
  # none.
  #
  # @example
  #   "  foo".indent(2)        # => "    foo"
  #   "foo\n\t\tbar".indent(2) # => "\t\tfoo\n\t\t\t\tbar"
  #   "foo".indent(2, "\t")    # => "\t\tfoo"
  #
  # While `indent_string` is typically one space or tab, it may be any string.
  #
  # The third argument, `indent_empty_lines`, is a flag that says whether
  # empty lines should be indented. Default is `false`.
  #
  # @example
  #   "foo\n\nbar".indent(2)            # => "  foo\n\n  bar"
  #   "foo\n\nbar".indent(2, nil, true) # => "  foo\n  \n  bar"
  #
  # @param amount [Integer] The level of indentation to add.
  # @param indent_string [String] Defaults to tab if a tab is present in the string, and `" "` otherwise.
  # @param indent_empty_lines [Boolean]
  #
  # @return [String]
  def indent(amount, indent_string = nil, indent_empty_lines = false)
    dup.tap { |s| s.indent!(amount, indent_string, indent_empty_lines) }
  end

  # It does exactly what you think it does.
  def comment!(indent_empty_lines = true)
    re = indent_empty_lines ? /^/ : /^(?!$)/
    gsub!(re, "# ")
  end

  # It does exactly what you think it does.
  def comment(indent_empty_lines = true)
    dup.tap { |s| s.comment!(indent_empty_lines) }
  end
end
