require "test_helper"
require "yaml"
require "pry"

class GinnyTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil(::Ginny::VERSION)
  end

  def test_1
    want = File.read(file_fixture("out/person_1.rb"))
    have = Ginny::Klass.new(name: "Clay", description: "An awesome guy.").render()
    assert_equal(want, have)
  end

  # def test_2
  #   want = File.read(file_fixture("out/person_2.rb"))
  #   have = Ginny::Klass.new(name: "Person").render()
  #   assert_equal(want, have)
  # end

  def test_attribute_constructor
    # dat = File.read(file_fixture("out/person_2.rb"))
    data = YAML.load_file(file_fixture("in/person_2.yml"))
    binding.pry
    have = Ginny::Attribute.from_array(data["attrs"])
    assert_equal(2, have.length)
  end

end
