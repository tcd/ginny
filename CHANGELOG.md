# Changelog

<!-- ## master (unreleased) -->

## 0.6.0 (2019-12-14)

### Added

- Add `default_constructor` option for `Ginny::Class`, which will generate a method similar to [ActiveRecord::Base.create][create_method_link] for the class.

[create_method_link][https://apidock.com/rails/ActiveRecord/Persistence/ClassMethods/create]

## 0.5.4 (2019-12-09)

### Changed

- Improve regular expressions for trimming trailing whitespace.

## 0.5.3 (2019-12-09)

### Changed

- Modify inflections for `data`.

## 0.5.2 (2019-12-09)

### Added

- Improved doc comments for various functions.
- Add `Ginny::INDENT` constant.

### Changed

- Make sure not to remove newlines when trimming trailing whitespace before calls to render.

## 0.5.1 (2019-12-03)

### Added

- JSON Schema definition for Ginny definition files.

### Changed 

- Update badges in readme.
- Add [tcd/coolkit](https://github.com/tcd/coolkit) dependency.
    - Extracted `String.indent`, `String.comment`, and `symbolize_keys` into their own gem for reuse.

## 0.5.0 (2019-11-28)

### Added

- Add [dry-rb/dry-inflector](https://github.com/dry-rb/dry-inflector) dependency.
- Add `file_prefix` option to `Ginny::Class` for a string to prepend to the name of the generated file.

### Changed 

- Update *description* and *documentation_uri* in gemspec.

### Fixed

- Fix doc comment in `Ginny.symbolize_keys` that was causing `yard gems` to give this warning:
    ```
    [warn]: @param tag has unknown parameter name: obj 
        in file `lib/food_truck/symbolize.rb' near line 10
    ```

## 0.4.0 (2019-11-21)

### Added

- Add `body` argument to `Ginny::Class` for code to be generated in the class body.

## 0.3.0 (2019-11-21)

### Added

- Add the option to wrap generated code in modules.

## 0.2.1 (2019-11-18)

### Changed

- Generate function body in `Ginny::Func.render`

## 0.2.0 (2019-11-17)

### Added

- Generate Functions with Yard doc comments. (`Ginny::Func`)
- Generate Function Parameters. (`Ginny::Param`)
- Add support for generating classes with inheritance.
- Add `food_truck` executable (WIP).

### Changed

- Rename `Ginny::Klass` to `Ginny::Class`
- Rename `Ginny::Attribute` to `Ginny::Attr`

### Fixed

- Don't use Yard `@!attribute` tags unless the attributes are added dynamically (ex: Rails Models)

## 0.1.0 (2019-11-15)

### Added

- Add changelog
- Implement basic functionality.
    - Generate Classes with Yard doc comments. (`Ginny::Klass`)
    - Generate getters/setters (`attr_accessor`s) with Yard doc comments. (`Ginny::Attribute`)
    - Load data from YAML/JSON files.
