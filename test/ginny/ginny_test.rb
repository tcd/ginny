require "test_helper"
require "yaml"
require "pry"

class GinnyTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil(::Ginny::VERSION)
  end

  def test_1
    want = File.read(file_fixture("out/person_1.rb"))
    have = Ginny::Klass.create(name: "Clay", description: "An awesome guy.").render()
    assert_equal(want, have)
  end

  def test_2
    want = File.read(file_fixture("out/person_2.rb"))
    k = Ginny::Klass.create(name: "Person")
    k.attrs = Ginny::Attribute.from_array([
      {
        name: "Name",
        type: "String"
      },
      {
        name: "Age",
        description: "Number of years the person has been alive.",
        type: "Integer"
      },
    ])
    have = k.render()
    assert_equal(want, have)
  end

  # def test_attribute_constructor
  #   # dat = File.read(file_fixture("out/person_2.rb"))
  #   data = YAML.load_file(file_fixture("in/person_2.yml"))
  #   binding.pry
  #   have = Ginny::Attribute.from_array(data["attrs"])
  #   assert_equal(2, have.length)
  # end

end
