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
- [Demo application](#demo-application)
- [References](#references)

## Overview

Well-**Form**ed Widget Fields — Well-Formed is a form field package designed to
relieve developers of much of the form-related coding. This is achieved by
providing out-of-the-box field masking, validation, smart trimming, and more.

In addition, this package aims to:

- improve source code readability by providing form fields with "semantic" names
  — names that convey their purpose at first glance — such as "EmailField",
  "DigitField", "IntField", "Ipv4Field", and so on.
- automate the selection of the keyboard type according to the field's purpose.
- **not to end up being yet another buggy Flutter form package!**.

In order to be a reliable package, every class is well-documented and fully unit
tested by a CI/CD pipeline with rigorous quality gates.

## Getting Started

Most of the form fields in this package are built on top of a `TextFormField`
widget so they remain **fully compatible** with the `Form` widget. This is quite
important to avoid buggy behavior such as when a field does not get reset when
its parent form gets reset.

<!-- @todo #2 add a form field example as soon as possible -->

## Demo application

The demo application provides a fully working example, focused on demonstrating
exactly three widgets in action — _WellFormed_, _BasicTextField_ and
_DigitField_. You can take the code in this demo and experiment with it.

To run the demo application:

```shell
git clone https://github.com/dartoos-dev/well_formed.git
cd well_formed/example/
flutter run -d chrome
```

This should launch the demo application on Chrome in debug mode.

## References

- [TextFormField](https://api.flutter.dev/flutter/material/TextFormField-class.html)
- [build a Flutter form](https://flutter.dev/docs/cookbook/forms/validation)
- [Mozilla input types](https://developer.mozilla.org/en-US/docs/Learn/Forms/HTML5_input_types)
