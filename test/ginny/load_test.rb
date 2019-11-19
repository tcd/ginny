require "test_helper"

class LoadTest < Minitest::Test

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

  def test_get_extension
    cases = {
      "/Users/clay/TCD/ruby/ginny/test/ginny/load_test.rb" => ".rb",
      "/USERS/CLAY/TCD/RUBY/GINNY/TEST/GINNY/LOAD_TEST.RB" => ".rb",
      "example.json" => ".json",
      "EXAMPLE.JSON" => ".json",
      "example.class.json" => ".json",
      "example.class.yaml" => ".yaml",
      "example.class.yml" => ".yml",
      "example.class.excessive.sections.yml" => ".yml",
    }
    cases.each do |key, val|
      assert_equal(val, Ginny.get_extension(key))
    end
  end

  def test_load_file
    json = Ginny::Class.create(Ginny.load_file(file_fixture("in/person.json"))).render()
    assert_equal(@person.strip, json.strip)
    yaml = Ginny::Class.create(Ginny.load_file(file_fixture("in/person.yml"))).render()
    assert_equal(@person, yaml)
  end

end
