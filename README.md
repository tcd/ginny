# Ginny


[![Build Status](https://travis-ci.org/tcd/gql.svg?branch=master)](https://travis-ci.org/tcd/gql)
[![Coverage Status](https://coveralls.io/repos/github/tcd/ginny/badge.svg?branch=master)](https://coveralls.io/github/tcd/ginny?branch=master)
[![Documentation](http://img.shields.io/badge/docs-rubydoc.org-blue.svg)](https://rubydoc.org/github/tcd/ginny/master)
[![GitHub](https://img.shields.io/github/license/tcd/ginny)](https://github.com/tcd/ginny/blob/master/LICENSE.txt)

[![Gem](https://img.shields.io/gem/v/ginny)](https://rubygems.org/gems/ginny) [[1]][gem link 1] [[2]][gem link 2]

[gem link 1]: https://help.rubygems.org/discussions/problems/37131-gem-push-name-too-close-to-typo-protected-gem
[gem link 2]: https://github.com/rubygems/rubygems.org/issues/2058

## Installation

Add this line to your application's Gemfile:

```ruby
gem "ginny"
```

And then execute:

```ruby
bundle
```

Or install it yourself as:

```ruby
gem install ginny
```

## Usage

### From the command line

```yaml
# person.yml
---
name: Human
description: This class models a person.
modules: [MilkyWay, Earth]
parent: Mammal
attrs:
- name: Name
  type: String
- name: Age
  description: Number of years the human has been alive.
  type: Integer
  read_only: true

```

```shell
$ ginny person.yml
```

### From Ruby code

```ruby
require "ginny"

data = {
  name: "Human",
  description: "This class models a person.",
  modules: ["MilkyWay", "Earth"],
  parent: "Mammal",
  attrs: [
    { name: "name", type: "String" },
    { name: "age",  type: "Integer" read_only: true, description: "Number of years the human has been alive." },
  ],
}

c = Ginny::Class.create(data)
c.render()   #=> Returns the generated code as a string.
c.generate() #=> Writes the generated code to a given folder, or the current directory if no argument is passed.
```

```ruby
# human.rb
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
```

## Supported Arguments

### `Ginny::Class`

|      Name       |         Type         |                          Description                           |
| --------------- | -------------------- | -------------------------------------------------------------- |
| name (required) | `String`             | Name of the class.                                             |
| description     | `String`             | Description of the class. [Markdown][markdown] is supported.   |
| body            | `String`             | String to write into the body of the class.                    |
| parent          | `String`             | Name of a class to inherit from. (Ex: `YourNewClass < Parent`) |
| modules         | `Array<String>`      | List of modules to declare the class inside of                 |
| attrs           | `Array<Ginny::Attr>` | An array of Attrs.                                             |

### `Ginny::Attr`

|      Name       |   Type    |                                                       Description                                                        |
| --------------- | --------- | ------------------------------------------------------------------------------------------------------------------------ |
| name (required) | `String`  | Name of the attribute.                                                                                                   |
| description     | `String`  | Description of the attribute. [Markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) is supported. |
| type            | `String`  | [Type](https://rubydoc.info/gems/yard/file/docs/GettingStarted.md#Declaring_Types) of the attribute.                     |
| default         | `Any`     | Default value for the attribute; set in it's Class's `initialize` function.                                              |
| read_only       | `Boolean` | If `true`, an `attr_reader` will be generated for the attribute instead of an `attr_accessor`.                           |

### `Ginny::Func`

|      Name       |         Type          |                                                Description                                                 |
| --------------- | --------------------- | ---------------------------------------------------------------------------------------------------------- |
| name (required) | `String`              | Name of the function.                                                                                      |
| description     | `String`              | Description of the function. [Markdown][markdown] is supported.                                            |
| return_type     | `String`              | Return [type](https://rubydoc.info/gems/yard/file/docs/GettingStarted.md#Declaring_Types) of the function. |
| body            | `String`              | String to write into the body of the function.                                                             |
| modules         | `Array<String>`       | List of modules to declare the function inside of                                                          |
| params          | `Array<Ginny::Param>` | An array of Params.                                                                                        |

### `Ginny::Param`

|      Name       |   Type    |                                                     Description                                                      |
| --------------- | --------- | -------------------------------------------------------------------------------------------------------------------- |
| name (required) | `String`  | Name of the param.                                                                                                   |
| description     | `String`  | Description of the param. [Markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) is supported. |
| type            | `String`  | [Type](https://rubydoc.info/gems/yard/file/docs/GettingStarted.md#Declaring_Types) of the param.                     |
| default         | `Any`     | Default value for the param. Set `optional` as `true` for a default `nil` value.                                     |
| optional        | `Boolean` | If `true`, the default value will be `nil`.                                                                          |
| keyword         | `Boolean` | If `true`, the param will be generated as a [keyword argument](https://bugs.ruby-lang.org/issues/14183).             |

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tcd/ginny.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
