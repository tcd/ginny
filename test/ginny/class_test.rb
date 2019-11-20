require "test_helper"

class ClassTest < Minitest::Test

  def test_empty_class_with_no_description
    want = <<~RUBY.strip
      class Example
      end
    RUBY
    have = Ginny::Class.create(name: "Example").render()
    assert_equal_and_print(want, have)
  end

  def test_empty_class_with_description
    want = <<~RUBY.strip
      # This is just an example.
      class Example
      end
    RUBY
    have = Ginny::Class.create(
      name: "Example",
      description: "This is just an example.",
    ).render()
    assert_equal(want, have)
  end

  def test_empty_class_with_parent
    want = <<~RUBY.strip
      # This example is object-oriented.
      class Example < Parent
      end
    RUBY
    have = Ginny::Class.create(
      name: "Example",
      description: "This example is object-oriented.",
      parent: "Parent",
    ).render()
    assert_equal(want, have)
  end

  def test_class_with_attributes
    want = <<~RUBY.strip
      # This class models a person.
      class Human < Mammal
        # @return [String]
        attr_accessor :name
        # Number of years the human has been alive.
        # @return [Integer]
        attr_accessor :age
      end
    RUBY
    have = Ginny::Class.create(
      name: "Human",
      description: "This class models a person.",
      parent: "Mammal",
      attrs: [
        { name: "name", type: "String" },
        { name: "age", description: "Number of years the human has been alive.", type: "Integer" },
      ],
    ).render()
    assert_equal(want.strip, have.strip)
  end

  def test_class_with_in_module
    want = <<~RUBY.strip
      module MilkyWay
        module Earth
          # This class models a person.
          class Human < Mammal
            # @return [String]
            attr_accessor :name
            # Number of years the human has been alive.
            # @return [Integer]
            attr_reader :age
          end
        end
      end
    RUBY
    have = Ginny::Class.create(Ginny.load_file(file_fixture("in/person2.yml"))).render()
    assert_equal(want.strip, have.strip)
  end

end
