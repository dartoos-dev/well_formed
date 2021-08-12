# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Dart Package Versioning](https://dart.dev/tools/pub/versioning).

## [Unreleased]

### Added

- IntField widget for integer input values —
  [24](https://github.com/dartoos-dev/well_formed/issues/24).
- NumField widget for floating-point input values —
  [10](https://github.com/dartoos-dev/well_formed/issues/10).

## [0.3.0] - 2021-08-10

### Changed

- update the version of the "Formdator" dependency to 0.10.0 —
  [19](https://github.com/dartoos-dev/well_formed/issues/19).
- DigitField: [21](https://github.com/dartoos-dev/well_formed/issues/21)
  **BREAKING CHANGES**.
  - set the [inputFormatters] attribute to
    [FilteringTextInputFormatter.digitsOnly] and remove it from the constructors
    parameter list
  - set the [keyboardType] to [TextInputType.number] and remove it from the
    constructors parameter list.

## [0.2.0] - 2021-08-07

### Added

- CepField widget for CEP (Código de Endereçamento Postal) input values —
  [7](https://github.com/dartoos-dev/well_formed/issues/7).
- WellFormed, a convenient well-formed form widget!
- Several unit tests in addition to improvements to the existing ones —
  [15](https://github.com/dartoos-dev/well_formed/issues/15).

### Changed

- The description of this package.

### Removed

- The FormFieldTester class has been removed and the WellFormed class is its
  replacement. **BREAKING CHANGE**

## [0.1.0] - 2021-07-31

### Added

- BasicTextField, a text form field that can be made required and/or have its
  input data trimmed — [12](https://github.com/dartoos-dev/well_formed/issues/12).
- DigitField, a digit-only form field —
  [11](https://github.com/dartoos-dev/well_formed/issues/11).
- Example code that can be run —
  [9](https://github.com/dartoos-dev/well_formed/issues/9).

## [0.0.1] - 2021-07-21
