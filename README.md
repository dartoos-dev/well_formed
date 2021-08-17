# well_formed

<img
src="https://user-images.githubusercontent.com/24878574/126539340-83d14f37-93e0-4fae-8029-f7ec9de71d88.png"
alt="EO-Color logo" width="153" height="153"/>

[![EO principles respected
here](https://www.elegantobjects.org/badge.svg)](https://www.elegantobjects.org)
[![DevOps By
Rultor.com](https://www.rultor.com/b/dartoos-dev/well_formed)](https://www.rultor.com/p/dartoos-dev/well_formed)

[![pub](https://img.shields.io/pub/v/well_formed)](https://pub.dev/packages/well_formed)
[![license](https://img.shields.io/badge/license-mit-green.svg)](https://github.com/dartoos-dev/well_formed/blob/master/LICENSE)
[![PDD status](https://www.0pdd.com/svg?name=dartoos-dev/well_formed)](https://www.0pdd.com/p?name=dartoos-dev/well_formed)

[![build](https://github.com/dartoos-dev/well_formed/actions/workflows/build.yml/badge.svg)](https://github.com/dartoos-dev/well_formed/actions/)
[![codecov](https://codecov.io/gh/dartoos-dev/well_formed/branch/master/graph/badge.svg?token=W6spF0S796)](https://codecov.io/gh/dartoos-dev/well_formed)
[![CodeFactor Grade](https://img.shields.io/codefactor/grade/github/rafamizes/well_formed)](https://www.codefactor.io/repository/github/rafamizes/well_formed)
[![style: lint](https://img.shields.io/badge/style-lint-4BC0F5.svg)](https://pub.dev/packages/lint)
[![Hits-of-Code](https://hitsofcode.com/github/dartoos-dev/well_formed?branch=master)](https://hitsofcode.com/github/dartoos-dev/well_formed/view?branch=master)

## Contents

- [Overview](#overview)
- [Getting Started](#getting-started)
  - [Form Field in Action](#form-field-in-action)
- [List of Form Fields by Category](#list-of-form-fields)
  - [Brazil](#brazil)
  - [Core](#core)
  - [Net](#net)
  - [Numeric](#numeric)
- [Demo application](#demo-application)
  - [Blank Field Error Messages](#blank-field-error-messages)
  - [Invalid Inputs](#invalid-inputs)
  - [Fields With Proper Values](#fields-with-proper-values)
- [Left Out Properties](#left-out-properties)
- [References](#references)

## Overview

Well-**Form**ed Widget Fields — Well-Formed is a form field package designed to
relieve developers of much of the form-related coding. This is achieved by
providing out-of-the-box field masking, validation, smart trimming, and more. In
addition, this package aims to:

- improve source code readability by providing form fields with "semantic" names
  — names that convey their purpose at first glance — such as "EmailField",
  "CpfField", "DigitField", "IntField", and so on.
- automate the selection of the keyboard type according to the field's purpose.
- **not to end up being yet another buggy Flutter form package!**

In order to be a reliable package, every class is well-documented and fully unit
tested by a CI/CD pipeline with rigorous quality gates.

## Getting Started

Most of the form fields in this package are built on top of the `TextFormField`
widget so that they remain **fully compatible** with the `Form` widget.
This is important to avoid erroneous (buggy) behavior, such as when a field does
not reset when its parent `Form` widget is reset.

In addition to supporting most of the `TextFormField` properties, additional properties
have been introduced to facilitate the creation of "Smarter" form fields with stunning
capabilities such as:

- **Fields that can easily be made mandatory (required)** by just filling in the
  `blank` property with text.
- **Automatic field masking**. For example ('#' is a digit [0–9]):
  `CpfField` — '###.###.###-##'; `CnpjField` — '##.###.###/####-##';
  `BrMobileField` — '(##) #####-####'; and so on.
- **Stripping**: this is the optional removal of non-digit characters. It is
  enabled by default. To disable it, simply set the `strip` property to `false`.
- **Smart trimming**: this is when trimming is also applied to form field
  callback functions. The affected callback functions are `onSaved`,`onChanged`
  and `onFieldSubmitted`. To enable it, simply set the `trim` property to `true`.
- **Validation** with custom error messages (`blank`, `malformed`, `long`, etc.).
- **Automatic keyboard type selection**: the most suitable keyboard type is selected
  according to the field type. For example, the `EmailFiel` class sets the
  keyboardType to `TextInputType.emailAddress`, which in turn is optimized for
  email addresses.

### Form Field in Action

The code below demonstrates how to use the `EmailField` widget with the `trim`
property set to `true` so that the entered email value is trimmed before being
validated. Furthermore, the example also illustrates some important features:

- auto validation
- error messages
- length constraint

```dart
  …
  // the form's mandatory state key
  final formKey = GlobalKey<FormState>();
  …
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: [
        EmailField.len(
          50, // limits the length to up to 50 characters
          trim: true, // trims the entered email
          blank: 'Inform the email', // error message if the field is left blank
          malformed: 'Invalid email', // error message if the email is invalid
          long: 'The email is too long', // error message for long emails
          decoration: const InputDecoration(
            labelText: 'Enter an email with up to 50 characters',
          ),
        ),
      ]),
    );
  }
```

## List of Form Fields

The list of form fields with detailed information about each one (constructors,
parameters, etc.):

- [well_formed](https://pub.dev/documentation/well_formed/latest/).

### Brazil

Form fields related to
[Brazil](https://pub.dev/documentation/well_formed/latest/brazil/brazil-library.html).
Each '#' represents a digit [0–9].

- [BrMobileField](https://pub.dev/documentation/well_formed/latest/brazil/BrMobileField-class.html)
  — a masked _(##) #####-####_ form field for Brazilian mobile numbers.
- [BrPhoneField](https://pub.dev/documentation/well_formed/latest/brazil/BrPhone-class.html)
  — a masked _(##) ####-####_ form field for Brazilian landline telephone
  numbers.
- [CepField](https://pub.dev/documentation/well_formed/latest/brazil/CepField-class.html)
  — a masked _#####-###_ form field for CEP (Código de Endereçamento Postal).
- [CnpjField](https://pub.dev/documentation/well_formed/latest/brazil/CnpjField-class.html)
  — masked _##.###.###/####-##_ form field for CNPJ (Cadastro Nacional da Pessoa
  Jurídica).
- [CpfField](https://pub.dev/documentation/well_formed/latest/brazil/CnpjField-class.html)
  — a masked _###.###.###-##_ form field for CPF (Cadastro da Pessoa Física).

### Core

[Core](https://pub.dev/documentation/formdator/latest/core/core-library.html)
components.

- [BasicTextField](https://pub.dev/documentation/well_formed/latest/core/BasicTextField-class.html)
  — a text form field that can be made required and/or have its input data
  trimmed.
- [WellFormed](https://pub.dev/documentation/well_formed/latest/core/WellFormed-class.html)
  — a convenient and well-formed form widget! It builds a
  [Form](https://api.flutter.dev/flutter/widgets/Form-class.html) widget within
  a structure consisting of
  [SafeArea](https://api.flutter.dev/flutter/widgets/SafeArea-class.html) and
  [Column](https://api.flutter.dev/flutter/widgets/Column-class.html) widgets.

### Net

Inter[net](https://pub.dev/documentation/well_formed/latest/net/net-library.html)
related form fields.

[EmailField](https://pub.dev/documentation/well_formed/latest/net/EmailField-class.html)
— form field optimized for emails. You can limit the length of an email by using
the `EmailField.len` constructor.

### Numeric

[Numeric](https://pub.dev/documentation/formdator/latest/numeric/numeric-library.html)
— form fields related to numbers or digits. Example of numeric inputs: a
three-digit code; a six-digit password; a hexadecimal value; the Minimum Order
Quantity of a product; and so on.

[DigitField](https://pub.dev/documentation/well_formed/latest/numeric/DigitField-class.html)
— digit-only form field. You can constrain the number of digits in several ways:

- to a fixed number of digits through the `DigitField.len` constructor
- to a minimum number of digits through the `DigitField.min` constructor
- to a maximum number of digits through the `DigitField.max` constructor
- within a range through the `DigitField.range` constructor

[IntField](https://pub.dev/documentation/well_formed/latest/numeric/IntField-class.html)
— integer values form field. You can constrain the allowed values in several
ways:

- to positive values through the `IntField.pos` constructor
- to negative values through the `IntField.neg` constructor
- to values greater than or equal to a minimum value through the `IntField.min`
  constructor
- to values less than or equal to a maximum value through the `IntField.max`
  constructor
- within a range through the `IntField.range` constructor

[NumField](https://pub.dev/documentation/well_formed/latest/numeric/NumField-class.html)
— floating-point values form field. You can constrain the allowed values in
several ways:

- to positive values through the `NumField.pos` constructor
- to negative values through the `NumField.neg` constructor
- to values greater than or equal to a minimum value through the `NumField.min`
  constructor
- to values less than or equal to a maximum value through the `NumField.max`
  constructor
- within a range through the `NumField.range` constructor

## Demo application

The demo application provides a fully working example, focused on demonstrating
exactly five widgets in action — _WellFormed_, _DigitField_, _IntField_,
_EmailField_, and _CpfField_. You can take the code in this demo and experiment
with it.

To run the demo application:

```shell
git clone https://github.com/dartoos-dev/well_formed.git
cd well_formed/example/
flutter run -d chrome
```

This should launch the demo application on Chrome in debug mode.

![well_formed_demo_app](https://user-images.githubusercontent.com/24878574/129643495-1bbec3f3-bfc0-4940-9428-fb20c015a2ea.png)

### Blank Field Error Messages

![blank-fields](https://user-images.githubusercontent.com/24878574/129643680-111256a0-87a6-4018-a267-3f6525694801.png)

### Invalid Inputs

![invalid-inputs](https://user-images.githubusercontent.com/24878574/129644049-9a344cd2-101b-43f8-8878-302ac61e6973.png)

### Fields With Proper Values

![valid-inputs](https://user-images.githubusercontent.com/24878574/129644261-da1d2621-7f85-4835-8f6d-bf55ae3fd8f6.png)

## Left out Properties

Regarding compatibility with the
[TextFormField](https://api.flutter.dev/flutter/material/TextFormField-class.html)
class, some properties were left out for one of two reasons:

- the property has been deprecated by the Flutter sdk. This is the case of the
  `autovalidate` and `maxLengthEnforced` properties.
- the property has been considered too superfluous — they have little use in the
  context of form fields. This is the case of the following properties (A–Z):

```Dart
Brightness? keyboardAppearance,
Color? cursorColor,
FocusNode? focusNode,
GestureTapCallback? onTap,
InputCounterWidgetBuilder? buildCounter,
Iterable<String>? autofillHints,
MaxLengthEnforcement? maxLengthEnforcement,
Radius? cursorRadius,
ScrollController? scrollController,
ScrollPhysics? scrollPhysics,
SmartDashesType? smartDashesType,
SmartQuotesType? smartQuotesType,
StrutStyle? strutStyle,
TextAlignVertical? textAlignVertical,
TextCapitalization textCapitalization = TextCapitalization.none,
TextSelectionControls? selectionControls,
ToolbarOptions? toolbarOptions,
bool autofocus,
bool enableSuggestions,
bool expands,
bool? showCursor,
double cursorWidth,
double? cursorHeight,
int? maxLines,
int? minLines,
```

## References

- [TextFormField](https://api.flutter.dev/flutter/material/TextFormField-class.html)
- [Build a Flutter form](https://flutter.dev/docs/cookbook/forms/validation)
- [Mozilla input types](https://developer.mozilla.org/en-US/docs/Learn/Forms/HTML5_input_types)
