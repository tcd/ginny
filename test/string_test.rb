require "test_helper"

class StringTest < Minitest::Test

  def test_indent_1
    want = <<-STRING
  def some_method
    some_code
  end
    STRING
    have = <<~STRING.indent(2)
      def some_method
        some_code
      end
    STRING
    assert_equal(want, have)
  end

  def test_indent_2
    assert_equal("    foo", "  foo".indent(2))
    assert_equal("\t\tfoo\n\t\t\t\tbar", "foo\n\t\tbar".indent(2))
    assert_equal("\t\tfoo", "foo".indent(2, "\t"))
  end

  def test_indent_3
    assert_equal("  foo\n\n  bar", "foo\n\nbar".indent(2))
    assert_equal("  foo\n  \n  bar", "foo\n\nbar".indent(2, nil, true))
  end

  def test_comment_1
    want = <<-STRING
# def some_method
#   some_code
# end
    STRING
    have = <<~STRING.comment()
      def some_method
        some_code
      end
    STRING
    assert_equal(want, have)
  end

  def test_comment_2
    assert_equal("# foo", "foo".comment())
    assert_equal("#   foo", "  foo".comment())
    assert_equal("# foo\n# \t\tbar", "foo\n\t\tbar".comment())
  end

  def test_comment_3
    assert_equal("# foo\n# \n# bar", "foo\n\nbar".comment())
    assert_equal("# foo\n\n# bar", "foo\n\nbar".comment(false))
  end

end
