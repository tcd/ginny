require "test_helper"

class GinnyTest < Minitest::Test

  def setup
    @person = <<~RUBY.strip
      # This class models a person.
      class Human < Mammal
        # @return [String]
        attr_accessor :name
        # Number of years the human has been alive.
        # @return [Integer]
        attr_reader :age
      end
    RUBY
  end

  def test_that_it_has_a_version_number
    refute_nil(::Ginny::VERSION)
  end

  def test_load_from_json
    have = Ginny::Class.create(Ginny.load_json(file_fixture("in/person.json"))).render()
    assert_equal(@person.strip, have.strip)
  end

  def test_load_from_yaml
    have = Ginny::Class.create(Ginny.load_yaml(file_fixture("in/person.yml"))).render()
    assert_equal(@person, have)
  end

  def test_yaml_with_multiline_string
    want = File.read(file_fixture("out/directive.rb")).strip
    have = Ginny::Class.create(Ginny.load_yaml(file_fixture("in/directive.yml"))).render()
    assert_equal(want, have)
  end

end
