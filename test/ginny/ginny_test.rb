require "test_helper"

class GinnyTest < Minitest::Test

  def test_that_it_has_a_version_number
    refute_nil(::Ginny::VERSION)
  end

  def test_class_constructor
    want = File.read(file_fixture("out/person_1.rb")).strip
    have = Ginny::Klass.create(name: "Clay", description: "An awesome guy.").render()
    assert_equal(want, have)
  end

  def test_attribute_constructor
    want = File.read(file_fixture("out/person_2.rb")).strip
    have = Ginny::Klass.create(name: "Person", attrs: [
      { name: "name", type: "String" },
      { name: "age", description: "Number of years the person has been alive.", type: "Integer" },
    ]).render()
    assert_equal(want, have)
  end

  def test_class_constructor_from_json
    want = File.read(file_fixture("out/person_1.rb")).strip()
    have = Ginny::Klass.create(Ginny.load_json(file_fixture("in/person_1.json"))).render()
    assert_equal(want, have)
  end

  def test_attribute_constructor_from_json
    want = File.read(file_fixture("out/person_2.rb")).strip()
    have = Ginny::Klass.create(Ginny.load_json(file_fixture("in/person_2.json"))).render()
    assert_equal(want, have)
  end

  def test_class_constructor_from_yaml
    want = File.read(file_fixture("out/person_1.rb")).strip()
    have = Ginny::Klass.create(Ginny.load_yaml(file_fixture("in/person_1.yml"))).render()
    assert_equal(want, have)
  end

  def test_attribute_constructor_from_yaml
    want = File.read(file_fixture("out/person_2.rb")).strip()
    have = Ginny::Klass.create(Ginny.load_yaml(file_fixture("in/person_2.yml"))).render()
    assert_equal(want, have)
  end

end
