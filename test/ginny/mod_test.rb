require "test_helper"

class ModTest < Minitest::Test

  def test_mod_1_level
    want = <<~RUBY.strip
      module Example
      end
    RUBY
    have = Ginny.mod(nil, "Example")
    assert_equal(want, have)
  end

  def test_mod_2_levels
    want = <<~RUBY.strip
      module Level1
        module Level2
        end
      end
    RUBY
    have = Ginny.mod(nil, "Level1", "Level2")
    assert_equal(want, have)
  end

  def test_mod_3_levels
    want = <<~RUBY.strip
      module Level1
        module Level2
          module Level3
          end
        end
      end
    RUBY
    have = Ginny.mod(nil, "Level1", "Level2", "Level3")
    assert_equal(want, have)
  end

  def test_mod_10_levels
    want = <<~RUBY.strip
      module Level1
        module Level2
          module Level3
            module Level4
              module Level5
                module Level6
                  module Level7
                    module Level8
                      module Level9
                        module Level10
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    RUBY
    names = (1..10).map { |i| "Level#{i}" }
    have = Ginny.mod(nil, names)
    assert_equal(want, have)
  end

  def test_body_1
    want = <<~RUBY.strip
      module Example
        puts('Hello World')
      end
    RUBY
    have = Ginny.mod("puts('Hello World')", "Example")
    assert_equal(want, have)
  end

  def test_body_2
    want = <<~RUBY.strip
      module Level1
        module Level2
          module Level3
            module Level4
              module Level5
                module Level6
                  module Level7
                    module Level8
                      module Level9
                        module Level10
                          puts('Hello World')
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    RUBY
    body = "puts('Hello World')"
    names = (1..10).map { |i| "Level#{i}" }
    have = Ginny.mod(body, names)
    assert_equal(want, have)
  end

  def test_just_body
    func = <<~RUBY.strip
      def greet
        puts('Hello World')
      end
    RUBY
    want = func
    have = Ginny.mod(func)
    assert_equal(want, have)
  end

end
