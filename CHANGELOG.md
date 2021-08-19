# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Dart Package Versioning](https://dart.dev/tools/pub/versioning).

## [Unreleased]

## [0.3.7] - 2021-08-19

### Added

- improvements to the documentation in general.

### Fixed

- line break error in README.
- several broken links in README.

## [0.3.6] - 2021-08-18

### Fixed

- README's internal links

## [0.3.5] - 2021-08-18

### Added

- BrMobileField, a text form field for entering Brazilian mobile numbers —
  [46](https://github.com/dartoos-dev/well_formed/issues/46).
- BrPhoneField, a text form field for entering Brazilian telephone numbers —
  [46](https://github.com/dartoos-dev/well_formed/issues/46).
- several improvements to the README file.

## [0.3.4] - 2021-08-18

### Added

- HexField, a text form field for entering hexadecimal digits —
  [41](https://github.com/dartoos-dev/well_formed/issues/41).

### Changed

- The IntField constructor sets the inputFormatters to allow only digits and
  the plus '+' or minus '-' signs.
- IntField.pos constructor sets the inputFormatters to only allow digits and
  the plus '+' sign.
- IntField.neg constructor sets the inputFormatters to only allow digits and
  the minus '-' sign.

### Fixed

- some sections of the README file.
- a few unit tests.

## [0.3.3] - 2021-08-17

### Added

- CpfField, a text form field for entering CPF values —
  [31](https://github.com/dartoos-dev/well_formed/issues/31)
- CpfField, a text form field for entering CNPJ values —
  [32](https://github.com/dartoos-dev/well_formed/issues/32)
- Several improvements to the README file.

## [0.3.2] - 2021-08-13

### Added

- EmailFiel, a text form field for entering email addresses —
  [8](https://github.com/dartoos-dev/well_formed/issues/8).

## [0.3.1] - 2021-08-12

### Added

- IntField widget, a form field for entering integer numbers —
  [24](https://github.com/dartoos-dev/well_formed/issues/24).
- NumField widget, a form field for entering floating point numbers —
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
