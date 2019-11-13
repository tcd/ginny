require "test_helper"

class SymbolizeTest < Minitest::Test

  def test_object_of_objects
    input = {
      "drinks" => {
        "gibson" => { "garnish" => "onion" },
        "martini" => { "garnish" => "olive" },
      },
    }
    want = {
      drinks: {
        gibson: { garnish: "onion" },
        martini: { garnish: "olive" },
      },
    }
    assert_equal(want, Ginny.symbolize_keys(input))
  end

  def test_array_of_objects
    input = [
      {
        "name" => "Name",
        "description" => nil,
        "type" => "String",
      },
      {
        "name" => "Age",
        "description" => "Number of years the person has been alive.",
        "type" => "Integer",
      },
    ]
    want = [
      {
        name: "Name",
        description: nil,
        type: "String",
      },
      {
        name: "Age",
        description: "Number of years the person has been alive.",
        type: "Integer",
      },
    ]
    assert_equal(want, Ginny.symbolize_keys(input))
  end

  def test_object_with_array_of_objects
    input = {
      "data" => [
        {
          "name" => "Name",
          "description" => nil,
          "type" => "String",
        },
        {
          "name" => "Age",
          "description" => "Number of years the person has been alive.",
          "type" => "Integer",
        },
      ],
    }
    want = {
      data: [
        {
          name: "Name",
          description: nil,
          type: "String",
        },
        {
          name: "Age",
          description: "Number of years the person has been alive.",
          type: "Integer",
        },
      ],
    }
    assert_equal(want, Ginny.symbolize_keys(input))
  end

  def test_object_of_objects_and_arrays
    input = {
      "name" => "Person",
      "attrs": [
        {
          "name" => "Name",
          "description" => nil,
          "type" => "String",
        },
        {
          "name" => "Age",
          "description" => "Number of years the person has been alive.",
          "type" => "Integer",
        },
      ],
    }

    want = {
      name: "Person",
      attrs: [
        {
          name: "Name",
          description: nil,
          type: "String",
        },
        {
          name: "Age",
          description: "Number of years the person has been alive.",
          type: "Integer",
        },
      ],
    }
    assert_equal(want, Ginny.symbolize_keys(input))
  end

end
