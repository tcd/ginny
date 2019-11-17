require "test_helper"

class AttrTest < Minitest::Test

  def test_attr
    want = <<~RUBY.strip()
      # @return [String]
      attr_accessor :example
    RUBY
    have = Ginny::Attr.create(
      name: "example",
      type: "String",
    ).render()
    assert_equal(want, have)
  end

  def test_attr_with_description
    want = <<~RUBY.strip()
      # This is just an example
      # @return [String]
      attr_accessor :example
    RUBY
    have = Ginny::Attr.create(
      name: "example",
      type: "String",
      description: "This is just an example",
    ).render()
    assert_equal(want, have)
  end

  def test_attr_read_only
    want = <<~RUBY.strip()
      # @return [String]
      attr_reader :example
    RUBY
    have = Ginny::Attr.create(
      name: "example",
      type: "String",
      read_only: true,
    ).render()
    assert_equal(want, have)
  end

  def test_dynamic
    want = <<~RUBY.strip()
      # @!attribute example [rw]
      #   @return [String]
    RUBY
    have = Ginny::Attr.create(
      name: "example",
      type: "String",
    ).render_dynamic()
    assert_equal(want, have)
  end

  def test_dynamic_with_description
    want = <<~RUBY.strip()
      # @!attribute example [rw]
      #   This is just an example
      #   @return [String]
    RUBY
    have = Ginny::Attr.create(
      name: "example",
      type: "String",
      description: "This is just an example",
    ).render_dynamic()
    assert_equal(want, have)
  end

  def test_dynamic_read_only
    want = <<~RUBY.strip()
      # @!attribute example [r]
      #   @return [String]
    RUBY
    have = Ginny::Attr.create(
      name: "example",
      type: "String",
      read_only: true,
    ).render_dynamic()
    assert_equal(want, have)
  end

  def test_enumerize_enum
    skip()
    want = <<~RUBY.strip()
      # @!attribute example [rw]
      #   @return [:yes, :no]
      enumerize :example, in: [:yes, :no]
    RUBY
    have = Ginny::Attr.create(
      name: "example",
      enumerize: [:yes, :no],
    ).render()
    assert_equal(want, have)
  end

  def test_activerecord_enum
    skip()
    want = <<~RUBY.strip()
      # @!attribute example [rw]
      #   @return [:yes, :no]
      enum example: [:yes, :no]
    RUBY
    have = Ginny::Attr.create(
      name: "example",
      enum: [:yes, :no],
    ).render()
    assert_equal(want, have)
  end

end
