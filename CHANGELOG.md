# Changelog

## master (unreleased)

### Added

- Generate Functions with Yard doc comments. (`Ginny::Func`)
- Generate Function Parameters. (`Ginny::Param`)
- Add support for generating classes with inheritance.
- Add `ginny` executable (WIP).

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