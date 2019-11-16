require "test_helper"

class FuncTest < Minitest::Test

  def test_init
    want = <<~RUBY.strip()
      # @return [void]
      def initialize()
      end
    RUBY
    have = Ginny::Func.create(name: "initialize").render()
    assert_equal(want, have)
  end

  def test_description
    want = <<~RUBY.strip()
      # Example description.
      # @return [void]
      def initialize()
      end
    RUBY
    have = Ginny::Func.create(name: "initialize", description: "Example description.").render()
    assert_equal(want, have)
  end

  def test_return_type
    want = <<~RUBY.strip()
      # Example description.
      # @return [String]
      def initialize()
      end
    RUBY
    have = Ginny::Func.create(name: "initialize", return_type: "String", description: "Example description.").render()
    assert_equal(want, have)
  end

  def test_single_param
    want = <<~RUBY.strip()
      # Say hello.
      # @param name [String]
      # @return [String]
      def greet(name = "dude")
      end
    RUBY
    have = Ginny::Func.create(
      name: "greet",
      return_type: "String",
      description: "Say hello.",
      params: [{ name: "name", type: "String", default: "dude" }],
    ).render()
    assert_equal(want, have)
  end

  def test_two_params
    want = <<~RUBY.strip()
      # Say hello.
      # @param name [String]
      # @param loud [Boolean]
      # @return [String]
      def greet(name, loud = false)
      end
    RUBY
    have = Ginny::Func.create(
      name: "greet",
      return_type: "String",
      description: "Say hello.",
      params: [
        { name: "name", type: "String" },
        { name: "loud", type: "Boolean", default: false },
      ],
    ).render()
    assert_equal(want, have)
  end

  def test_six_params
    skip()
    want = <<~RUBY.strip()
      # @return [String]
      def argumentative(
        one,
        two,
        three,
        four,
        five,
        six
      )
      end
    RUBY
    have = Ginny::Func.create(
      name: "argumentative",
      return_type: "String",
      params: [
        { name: "one" },
        { name: "two" },
        { name: "three" },
        { name: "four" },
        { name: "five" },
        { name: "six" },
      ],
    ).render()
    assert_equal_and_print(want, have)
  end

end