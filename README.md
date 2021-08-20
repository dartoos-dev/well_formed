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
    - [BrMobileField](#brmobilefield)
    - [BrPhoneField](#brphonefield)
    - [CepField](#cepfield)
    - [CnpjField](#cnpjfield)
    - [CpfField](#cpffield)
  - [Core](#core)
    - [BasicTextField](#basictextfield)
    - [WellFormed](#wellformed)
  - [Net](#net)
    - [EmailField](#emailfield)
  - [Numeric](#numeric)
    - [DigitField](#digitfield)
    - [HexField](#hexfield)
    - [IntField](#intfield)
    - [NumField](#numfield)
- [Demo application](#demo-application)
  - [Blank Field Error Messages](#blank-field-error-messages)
  - [Invalid Inputs](#invalid-inputs)
  - [Fields With Proper Values](#fields-with-proper-values)
- [Left Out Properties](#left-out-properties)
- [References](#references)

## Overview

Well-**Form**ed is a form field package designed to relieve developers of much
of the form-related coding. This is achieved by providing automatic field validation
and masking, smart trimming, and more.

In addition, this package aims to:

- help developers to always keep the users' data **well-formed**.
- improve source code readability by providing form fields with **semantic
  names**; that is, names that convey their purpose at first glance like
  _EmailField_, _Ipv4Field_, _UrlField_, and so on.
- automate the selection of the keyboard type according to the field's purpose.

In order to be a reliable package, every class is well-documented and fully unit-tested
by a CI/CD pipeline with rigorous quality gates.

## Getting Started

Most of the form fields in this package are built on top of the
[TextFormField](https://api.flutter.dev/flutter/material/TextFormField-class.html)
widget so that they remain **fully compatible** with the
[Form](https://api.flutter.dev/flutter/widgets/Form-class.html) widget. This is
important to avoid erroneous (buggy) behavior, such as when a field does not
reset when its parent `Form` widget is reset.

Besides supporting most of the `TextFormField` properties, additional
properties have been introduced to facilitate the creation of "Smarter" form
fields with stunning capabilities such as:

- **Required fields**: any field can be made required. To do this, simply assign
  an error message to the field's `blank` property.
- **Validation**: this is done automatically according to the field type. You
  can use your own error messages by assigning them to properties like `blank`,
  `malformed`, `long`, etc. In addition, you can pass an extra validation step to
  the `validator` property.
- **Field masking**: this is also performed automatically. For example, the
  [CpfField](https://pub.dev/documentation/well_formed/latest/brazil/CpfField-class.html)
  widget displays the mask _###.###.###-##_ (each '#' is a digit [0–9]) as the
  user enters digits; therefore, if the user enters _12345678900_, the displayed
  text will be _123.456.789-00_.
- **Stripping**: is the removal of non-digit characters from masked fields. It
  is enabled by default. To disable it, simply set the `strip` property to
  `false`.
- **Smart trimming**: this is when trimming is also applied to callback functions.
  The affected callbacks are `onSaved`,`onChanged`, and `onFieldSubmitted`. To
  enable it, simply set the `trim` property to `true`.
- **Automatic keyboard type selection**: the most suitable keyboard type is
  selected according to the field type. For example,
  the [EmailField](https://pub.dev/documentation/well_formed/latest/net/EmailField-class.html)
  widget sets the keyboard type to `TextInputType.emailAddress`, which is optimized
  for entering email addresses.

### Form Field in Action

The code below demonstrates how to use the `EmailField` widget with the `trim`
property set to `true`. Thus, the entered email value is trimmed before
validation takes place. Furthermore, the example also illustrates some important
features:

- auto validation
- custom error messages
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

The complete list of form fields with detailed information about each one (constructors,
parameters, etc.):

- [well_formed](https://pub.dev/documentation/well_formed/latest/).

### Brazil

Form fields related to
[Brazil](https://pub.dev/documentation/well_formed/latest/brazil/brazil-library.html).

Most form fields in this library are masked fields; so whenever you see a '#'
character in the documentation, think of it as a placeholder for a single digit
[0-9].

#### BrMobileField

[BrMobileField](https://pub.dev/documentation/well_formed/latest/brazil/BrMobileField-class.html)
is a masked _(##) #####-####_ form field for Brazilian mobile numbers.

```dart
BrMobileField(
  strip: true, // remove non-digit characters when submitted/saved/changed.
  blank: 'Please enter the mobile number', // the error message if the field is left blank
  malformed: 'Invalid mobile number', // the error message if the number is malformed
  decoration: InputDecoration(labelText: 'Enter a mobile number'),
);
```

#### BrPhoneField

[BrPhoneField](https://pub.dev/documentation/well_formed/latest/brazil/BrPhoneField-class.html)
is a masked _(##) ####-####_ form field for Brazilian landline telephone
numbers.

```dart
BrPhoneField(
  strip: true, // remove non-digit characters when submitted/saved/changed.
  blank: 'Please enter the phone number', // the error message if the field is left blank
  malformed: 'Invalid phone number', // the error message if the number is invalid
  decoration: InputDecoration(labelText: 'Enter a phone number'),
);
```

#### CepField

[CepField](https://pub.dev/documentation/well_formed/latest/brazil/CepField-class.html)
is a masked _#####-###_ form field for CEP (Código de Endereçamento Postal —
Brazilian Postal Code).

```dart
CepField(
  strip: true, // remove non-digit characters when submitted/saved/changed.
  blank: 'Please enter the CEP', // the error message if the field is left blank
  malformed: 'Invalid CEP', // the error message if the CEP is invalid
  decoration: InputDecoration(labelText: 'Enter a CEP'),
);
```

#### CnpjField

[CnpjField](https://pub.dev/documentation/well_formed/latest/brazil/CnpjField-class.html)
is a masked _##.###.###/####-##_ form field for CNPJ (Cadastro Nacional da
Pessoa Jurídica — Brazilian Company's Registered Number).

```dart
CnpjField(
  strip: true, // remove non-digit characters when submitted/saved/changed.
  blank: 'Please enter the CNPJ', // the error message if the field is left blank
  malformed: 'Invalid CNPJ', // the error message if the CNPJ is invalid
  decoration: InputDecoration(labelText: 'Enter a CNPJ'),
);
```

#### CpfField

[CpfField](https://pub.dev/documentation/well_formed/latest/brazil/CnpjField-class.html)
is a masked _###.###.###-##_ form field for CPF (Cadastro da Pessoa Física; it
is a kind of social security number).

```dart
CnpjField(
  strip: true, // remove non-digit characters when submitted/saved/changed.
  blank: 'Please enter the CPF', // the error message if the field is left blank
  malformed: 'Invalid CPF', // the error message if the CPF is invalid
  decoration: InputDecoration(labelText: 'Enter a CPF'),
);
```

### Core

[Core](https://pub.dev/documentation/formdator/latest/core/core-library.html)
components.

#### BasicTextField

[BasicTextField](https://pub.dev/documentation/well_formed/latest/core/BasicTextField-class.html)
is a text form field that can be made required and/or have its input data
trimmed.

```dart
BasicTextField.max(
  50, // limits the length to 50 charactes
  trim: true, // trims the entered data when submitted/saved/changed.
  blank: 'Please enter your full name', // the error message if the field is left blank
  great: 'The name is too long', // the error message if the number of chars is greater than 50
  decoration: InputDecoration(labelText: 'Enter your full name (up to 50 chars)'),
);
```

#### WellFormed

[WellFormed](https://pub.dev/documentation/well_formed/latest/core/WellFormed-class.html)
is a convenient and well-formed form widget! It builds a
[Form](https://api.flutter.dev/flutter/widgets/Form-class.html) widget within a
structure consisting of the
[SafeArea](https://api.flutter.dev/flutter/widgets/SafeArea-class.html) and
[Column](https://api.flutter.dev/flutter/widgets/Column-class.html) widgets.

### Net

Inter[net](https://pub.dev/documentation/well_formed/latest/net/net-library.html)
related form fields.

#### EmailField

[EmailField](https://pub.dev/documentation/well_formed/latest/net/EmailField-class.html)
is a form field optimized for emails. You can limit the length of an email by
using the
[EmailField.len](https://pub.dev/documentation/well_formed/latest/net/EmailField/EmailField.len.html)
constructor.

```dart
EmailField.len(
  50, // limits the length to up to 50 characters
  trim: true, // trims the entered email
  blank: 'Inform the email', // error message if the field is left blank
  malformed: 'Invalid email', // error message if the email is malformed
  long: 'The email is too long', // error message for long emails
  decoration: InputDecoration(
    labelText: 'Enter an email with up to 50 characters',
  ),
),
```

### Numeric

[Numeric](https://pub.dev/documentation/formdator/latest/numeric/numeric-library.html)
form fields related to numbers or digits. A few examples of numeric entries are:
a three-digit code; a six-digit password; a hexadecimal value; the Minimum Order
Quantity of a product; and so on.

#### DigitField

[DigitField](https://pub.dev/documentation/well_formed/latest/numeric/DigitField-class.html)
is a digit-only form field. It is ideal for verification codes, PIN numbers,
etc. Here are some examples of valid entries: _0123_, _1111_, _090909_.

```dart
DigitField(
  blank: 'Please enter the verification code', // the error message if the field is left blank
  malformed:'non-digit character(s)' // the error message for malformed data.
  decoration: InputDecoration(labelText: 'Verification code'),
);
```

You can constrain the number of digits in several ways through constructors:

- [DigitField.len](https://pub.dev/documentation/well_formed/latest/numeric/DigitField/DigitField.len.html)
  for a fixed number of digits.
- [DigitField.min](https://pub.dev/documentation/well_formed/latest/numeric/DigitField/DigitField.max.html)
  for a minimum number of digits.
- [DigitField.max](https://pub.dev/documentation/well_formed/latest/numeric/DigitField/DigitField.max.html)
  for a maximum number of digits.
- [DigitField.range](https://pub.dev/documentation/well_formed/latest/numeric/DigitField/DigitField.range.html)
  for a range.

#### HexField

[HexField](https://pub.dev/documentation/well_formed/latest/numeric/HexField-class.html)
is a hexadecimal form field. It accepts the digits 0–9 and the letters
'AaBbCcDdEeFf'. Example of valid entries: _123_, _45fe_, _CafeBabe_.

```dart
HexField(
  blank: 'Please enter the device hex number', // the error message if the field is left blank
  malformed:'non-hex character(s)' // the error message for malformed data.
  decoration: InputDecoration(labelText: 'Enter a device hex number'),
);
```

You can constrain the number of hex digits in several ways through constructors:

- [HexField.len](https://pub.dev/documentation/well_formed/latest/numeric/HexField/HexField.len.html)
  for a fixed number of hex digits.
- [HexField.min](https://pub.dev/documentation/well_formed/latest/numeric/HexField/HexField.min.html)
  for a minimum number of hex digits.
- [HexField.max](https://pub.dev/documentation/well_formed/latest/numeric/HexField/HexField.max.html)
  for a maximum number of hex digits.
- [HexField.range](https://pub.dev/documentation/well_formed/latest/numeric/HexField/HexField.max.html)
  for a range.

#### IntField

[IntField](https://pub.dev/documentation/well_formed/latest/numeric/IntField-class.html)
is the form field for integers. It is ideal for entering the quantity of an
item, number of children, age, etc.

```dart
IntField(
  blank: 'Please enter the number of items to purchase', // the error message if the field is left blank
  malformed:'non-digit character(s)' // the error message for malformed data.
  decoration: InputDecoration(labelText: 'Number of items'),
);
```

You can constrain the allowed values in several ways through constructors:

- [IntField.pos](https://pub.dev/documentation/well_formed/latest/numeric/IntField/IntField.pos.html)
  for positive integers.
- [IntField.neg](https://pub.dev/documentation/well_formed/latest/numeric/IntField/IntField.neg.html)
  for negative integers.
- [IntField.min](https://pub.dev/documentation/well_formed/latest/numeric/IntField/IntField.min.html)
  for values greater than or equal to a minimum integer value
- [IntField.max](https://pub.dev/documentation/well_formed/latest/numeric/IntField/IntField.max.html)
  for values less than or equal to a maximum integer value.
- [IntField.range](https://pub.dev/documentation/well_formed/latest/numeric/IntField/IntField.range.html)
  for a range of integer values.

#### NumField

[NumField](https://pub.dev/documentation/well_formed/latest/numeric/NumField-class.html)
is the floating-point form field. It is ideal for displaying the total price of
a shopping cart, getting an auction bid, etc.

```dart
NumField(
  blank: 'Please enter your bid amount', // the error message if the field is left blank
  malformed:'non-numeric character(s)' // the error message for malformed data.
  decoration: InputDecoration(labelText: 'Enter your bid'),
);
```

You can constrain the allowed values in several ways:

- [NumField.pos](https://pub.dev/documentation/well_formed/latest/numeric/NumField/NumField.pos.html)
  for positive numbers.
- [NumField.neg](https://pub.dev/documentation/well_formed/latest/numeric/NumField/NumField.neg.html)
  for negative numbers.
- [NumField.min](https://pub.dev/documentation/well_formed/latest/numeric/NumField/NumField.min.html)
  for values greater than or equal to a minimum numbers
- [NumField.max](https://pub.dev/documentation/well_formed/latest/numeric/NumField/NumField.max.html)
  for values less than or equal to a maximum numbers.
- [NumField.range](https://pub.dev/documentation/well_formed/latest/numeric/NumField/NumField.range.html)
  for a range.

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
- the property has been considered too superfluous — it has little use in
  the context of form fields. This is the case for the following properties:

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
TextCapitalization textCapitalization,
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
