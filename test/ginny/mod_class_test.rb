require "test_helper"

class ModClassTest < Minitest::Test

  def test_mod_without_body
    want = <<~RUBY.strip
      module Level1
        module Level2
        end
      end
    RUBY
    have = Ginny::Mod.create(
      modules: ["Level1", "Level2"],
    ).render()
    assert_equal(want, have)
  end

  def test_mod_with_body
    want = <<~RUBY.strip
      module Level1
        module Level2
          # Say hello.
          # @return [String]
          def greet()
          end
        end
      end
    RUBY
    have = Ginny::Mod.create(
      modules: ["Level1", "Level2"],
      body: Ginny::Func.create(
        name: "greet",
        return_type: "String",
        description: "Say hello.",
      ).render(),
    ).render()
    assert_equal(want, have)
  end

end
