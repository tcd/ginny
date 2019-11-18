# Monkeypatch some convenience methods in to the String class.
class String
  # Adds a comment string (`"# "`) after every newline in a string.
  #
  # @param indent_empty_lines [Boolean]
  # @return [void]
  def comment!(indent_empty_lines = true)
    re = indent_empty_lines ? /^/ : /^(?!$)/
    gsub!(re, "# ")
  end

  # Returns a copy of a string with a comment (`"# "`) after every newline in a string.
  #
  # @param indent_empty_lines [Boolean]
  # @return [String]
  def comment(indent_empty_lines = true)
    dup.tap { |s| s.comment!(indent_empty_lines) }
  end
end
