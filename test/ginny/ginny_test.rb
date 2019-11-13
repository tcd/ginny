require "test_helper"

class GinnyTest < Minitest::Test

  def test_that_it_has_a_version_number
    refute_nil(::Ginny::VERSION)
  end

  def test_1
    want = File.read(file_fixture("out/person_1.rb")).strip
    have = Ginny::Klass.create(name: "Clay", description: "An awesome guy.").render()
    assert_equal(want, have)
  end

  def test_2
    want = File.read(file_fixture("out/person_2.rb")).strip
    k = Ginny::Klass.create(name: "Person")
    k.attrs = Ginny::Attribute.from_array([
      {
        name: "name",
        type: "String"
      },
      {
        name: "age",
        description: "Number of years the person has been alive.",
        type: "Integer"
      },
    ])
    have = k.render()
    assert_equal(want, have)
  end

end
