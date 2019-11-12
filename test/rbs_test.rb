require "test_helper"

class RbsTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil(::Rbs::VERSION)
  end
end
