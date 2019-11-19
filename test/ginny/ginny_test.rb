require "test_helper"

class GinnyTest < Minitest::Test

  def test_that_it_has_a_version_number
    refute_nil(::Ginny::VERSION)
  end

end
