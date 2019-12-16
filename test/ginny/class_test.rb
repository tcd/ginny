require "test_helper"

class ClassTest < Minitest::Test

  def test_empty_class_with_no_description
    want = <<~RB.strip
      class Example
      end
    RB
    have = Ginny::Class.create(name: "Example").render()
    assert_equal_and_print(want, have)
  end

  def test_empty_class_with_description
    want = <<~RB.strip
      # This is just an example.
      class Example
      end
    RB
    have = Ginny::Class.create(
      name: "Example",
      description: "This is just an example.",
    ).render()
    assert_equal(want, have)
  end

  def test_empty_class_with_parent
    want = <<~RB.strip
      # This example is object-oriented.
      class Example < Parent
      end
    RB
    have = Ginny::Class.create(
      name: "Example",
      description: "This example is object-oriented.",
      parent: "Parent",
    ).render()
    assert_equal(want, have)
  end

  def test_class_with_attributes
    want = <<~RB.strip
      # This class models a person.
      class Human < Mammal
        # @return [String]
        attr_accessor :name
        # Number of years the human has been alive.
        # @return [Integer]
        attr_accessor :age
      end
    RB
    have = Ginny::Class.create(
      name: "Human",
      description: "This class models a person.",
      parent: "Mammal",
      attrs: [
        { name: "name", type: "String" },
        { name: "age", description: "Number of years the human has been alive.", type: "Integer" },
      ],
    ).render()
    assert_equal(want, have.strip)
  end

  def test_default_constructor_1
    want = <<~RB.indent(2).strip
      # @param params [Hash]
      # @return [self]
      def self.create(params = {})
        h = Human.new
        h.name = params[:name]
        h.age = params[:age]
        return h
      end
    RB
    g_class = Ginny::Class.create(
      name: "Human",
      default_constructor: true,
      attrs: [
        { name: "name", type: "String" },
        { name: "age", description: "Number of years the human has been alive.", type: "Integer" },
      ],
    )
    have = g_class.render_body()
    assert_equal_and_print(want, have.strip)
  end

  def test_default_constructor_with_body
    want = <<~RB.strip
      # This class models a person.
      class Human < Mammal
        # @return [String]
        attr_accessor :name
        # Number of years the human has been alive.
        # @return [Integer]
        attr_accessor :age

        # @param params [Hash]
        # @return [self]
        def self.create(params = {})
          h = Human.new
          h.name = params[:name]
          h.age = params[:age]
          return h
        end

        puts('idk man')
      end
    RB
    have = Ginny::Class.create(
      name: "Human",
      description: "This class models a person.",
      parent: "Mammal",
      default_constructor: true,
      body: "puts('idk man')",
      attrs: [
        { name: "name", type: "String" },
        { name: "age", description: "Number of years the human has been alive.", type: "Integer" },
      ],
    ).render()
    assert_equal_and_print(want, have.strip)
  end

  def test_default_constructor_without_body
    want = <<~RB.strip
      # This class models a person.
      class Human < Mammal
        # @return [String]
        attr_accessor :name
        # Number of years the human has been alive.
        # @return [Integer]
        attr_accessor :age

        # @param params [Hash]
        # @return [self]
        def self.create(params = {})
          h = Human.new
          h.name = params[:name]
          h.age = params[:age]
          return h
        end
      end
    RB
    have = Ginny::Class.create(
      name: "Human",
      description: "This class models a person.",
      parent: "Mammal",
      default_constructor: true,
      attrs: [
        { name: "name", type: "String" },
        { name: "age", description: "Number of years the human has been alive.", type: "Integer" },
      ],
    ).render()
    assert_equal_and_print(want, have.strip)
  end

  def test_class_with_in_module
    want = <<~RB.strip
      module MilkyWay
        module Earth
          # This class models a person.
          class Human < Mammal
            # @return [String]
            attr_accessor :name
            # Number of years the human has been alive.
            # @return [Integer]
            attr_reader :age
          end
        end
      end
    RB
    have = Ginny::Class.create(Ginny.load_file(file_fixture("in/person2.yml"))).render()
    assert_equal(want, have.strip)
  end

  def test_class_with_body
    want = <<~RB.strip
      module C4
        module Elements
          # - Id: 112
          # - Name: Pier Name
          # - Type: AN
          # - Min/Max: 2/14
          # - Description: Free-form name of the pier.
          class PierName < C4::Element::AN
            # @return [void]
            def initialize()
              @id = 112
              @name = "Pier Name"
              @type = "AN"
              self.min = 2
              self.max = 14
            end
          end
        end
      end
    RB
    have = Ginny::Class.create(
      name: "PierName",
      parent: "C4::Element::AN",
      modules: ["C4", "Elements"],
      description: <<~STRING.strip,
        - Id: 112
        - Name: Pier Name
        - Type: AN
        - Min/Max: 2/14
        - Description: Free-form name of the pier.
      STRING
      body: <<~RB.strip,
        # @return [void]
        def initialize()
          @id = 112
          @name = "Pier Name"
          @type = "AN"
          self.min = 2
          self.max = 14
        end
      RB
    ).render()
    assert_equal(want, have.strip)
  end

  def test_preserving_newlines
    want = <<~RB.strip
      module Eddy
        module Elements
          class SecurityInformationQualifier < Eddy::Element::ID
            # @return [void]
            def initialize()
              @id = "I03"
            end

            # @return [Array<String>]
            def code_list()
              return [
                "00",
                "01"
              ]
            end
          end
        end
      end
    RB
    constructor = Ginny::Func.create({
      name: "initialize",
      body: '@id = "I03"',
    }).render()
    code_list = Ginny::Func.create({
      name: "code_list",
      return_type: "Array<String>",
      body: <<~FUNC_BODY,
        return [
          "00",
          "01"
        ]
      FUNC_BODY
    }).render()
    have = Ginny::Class.create({
      name: "SecurityInformationQualifier",
      parent: "Eddy::Element::ID",
      modules: ["Eddy", "Elements"],
      body: constructor + "\n\n" + code_list,
    }).render()
    assert_equal(want, have)
  end

  def test_class_name
    c1 = Ginny::Class.create({name: "SecurityInformationQualifiers"})
    assert_equal("SecurityInformationQualifier", c1.class_name())
    c2 = Ginny::Class.create({name: "Security_Information_Qualifiers"})
    assert_equal("SecurityInformationQualifier", c2.class_name())
    c3 = Ginny::Class.create({name: "GS", classify_name: false})
    assert_equal("GS", c3.class_name())
  end
end
