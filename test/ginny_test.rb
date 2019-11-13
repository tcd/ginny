require "test_helper"

class GinnyTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil(::Ginny::VERSION)
  end

  # def test_1
  #   want = File.read(file_fixture("out/person_1.rb")).strip
  #   have = Ginny::Klass.new("Clay", "An awesome guy.").render()
  #   assert_equal(want, have)
  # end
end
