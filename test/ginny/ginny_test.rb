require "test_helper"

class GinnyTest < Minitest::Test

  def test_that_it_has_a_version_number
    refute_nil(::Ginny::VERSION)
  end

  def test_load_from_json
    want = <<~RUBY.strip
      class Person
        # @return [String]
        attr_accessor :name
        # Number of years the person has been alive.
        # @return [Integer]
        attr_accessor :age
      end
    RUBY
    have = Ginny::Class.create(Ginny.load_json(file_fixture("in/person.json"))).render()
    assert_equal(want.strip, have.strip)
  end

  def test_load_from_yaml
    want = <<~RUBY.strip
      class Person
        # @return [String]
        attr_accessor :name
        # Number of years the person has been alive.
        # @return [Integer]
        attr_accessor :age
      end
    RUBY
    have = Ginny::Class.create(Ginny.load_yaml(file_fixture("in/person.yml"))).render()
    assert_equal(want, have)
  end

  # def test_yaml_with_multiline_string
  #   want = File.read(file_fixture("out/directive.rb"))
  #   have = Ginny::Class.create(Ginny.load_yaml(file_fixture("in/directive.yml"))).render()
  #   assert_equal(want, have)
  # end

end
