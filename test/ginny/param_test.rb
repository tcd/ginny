require "test_helper"

class ParamTest < Minitest::Test

  def test_simple
    want = "example"
    have = Ginny::Param.create(name: "example").render()
    assert_equal(want, have)
  end

  def test_optional
    want = "example = nil"
    have = Ginny::Param.create(name: "example", optional: true).render()
    assert_equal(want, have)
  end

  def test_default_string
    q = Ginny::QUOTE
    want = "example = #{q}default#{q}"
    have = Ginny::Param.create(name: "example", default: "default").render()
    assert_equal(want, have)
  end

  def test_default_symbol
    want = "example = :default"
    have = Ginny::Param.create(name: "example", default: :default).render()
    assert_equal(want, have)
  end

  def test_default_numeric
    want = "example = 420.69"
    have = Ginny::Param.create(name: "example", default: 420.69).render()
    assert_equal(want, have)
  end

  def test_keyword
    want = "example:"
    have = Ginny::Param.create(name: "example", keyword: true).render()
    assert_equal(want, have)
  end

  def test_optional_keyword
    want = "example: nil"
    have = Ginny::Param.create(name: "example", optional: true, keyword: true).render()
    assert_equal(want, have)
  end

  def test_default_string_keyword
    q = Ginny::QUOTE
    want = "example: #{q}default#{q}"
    have = Ginny::Param.create(name: "example", default: "default", keyword: true).render()
    assert_equal(want, have)
  end

  def test_default_boolean_keyword
    want = "example: true"
    have = Ginny::Param.create(name: "example", default: true, keyword: true).render()
    assert_equal(want, have)
  end

  def test_doc
    want = "# @param example [String]"
    have = Ginny::Param.create(name: "example", type: "String").render_doc()
    assert_equal(want, have)
  end

  def test_doc_with_description
    want = "# @param example [String] example description"
    have = Ginny::Param.create(name: "example", type: "String", description: "example description").render_doc()
    assert_equal(want, have)
  end

end
