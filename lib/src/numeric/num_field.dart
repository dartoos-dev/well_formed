import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formdator/formdator.dart';
import 'package:well_formed/well_formed.dart';

/// Numeric Form Field.
///
/// The Numeric field accepts integer and floating-point values. Letters and
/// most symbols cannot be entered into this type of field. However, the
/// negative sign ('-'), the positive sign ('+'), and '.' or ',' are allowed.
///
/// Non-numeric characters must somehow be filtered out so that they do not
/// appear in the form field. This is accomplished by setting the following:
///
/// - [Num] as the validator to limit data to numeric values.
/// - [TextInputType.numberWithOptions] as the keyboardType.
class NumField extends StatelessWidget {
  /// Numeric Form Field.
  ///
  /// [malformed] the error message in case of non-numeric characters.
  /// [blank] the error message in case of blank field; if omitted, the field
  /// will not be made required.
  /// [trim] whether or not to trim the input value.
  /// [validator] an optional extra validation step.
  NumField({
    bool trim = false,
    FormFieldValidator<String>? validator,
    String? blank,
    String? malformed,
    String? initialValue,
    TextEditingController? controller,
    InputDecoration? decoration,
    TextInputAction? textInputAction,
    TextStyle? style,
    TextDirection? textDirection,
    TextAlign textAlign = TextAlign.start,
    bool readOnly = false,
    String obscuringCharacter = '•',
    bool obscureText = false,
    bool autocorrect = true,
    int? maxLength,
    ValueChanged<String>? onChanged,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onFieldSubmitted,
    FormFieldSetter<String>? onSaved,
    List<TextInputFormatter>? inputFormatters,
    bool? enabled,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    AutovalidateMode? autovalidateMode,
    super.key,
  }) : _toNumField = ((context) {
          return BasicTextField(
            validator:
                Pair.str(Num(mal: malformed).call, validator ?? const Ok().call)
                    .call,
            keyboardType: const TextInputType.numberWithOptions(
              signed: true,
              decimal: true,
            ),
            inputFormatters: inputFormatters,
            blank: blank,
            trim: trim,
            decoration: decoration ?? const InputDecoration(),
            controller: controller,
            initialValue: initialValue,
            textInputAction: textInputAction,
            style: style,
            textDirection: textDirection,
            textAlign: textAlign,
            readOnly: readOnly,
            obscuringCharacter: obscuringCharacter,
            obscureText: obscureText,
            autocorrect: autocorrect,
            maxLength: maxLength,
            onChanged: onChanged,
            onEditingComplete: onEditingComplete,
            onFieldSubmitted: onFieldSubmitted,
            onSaved: onSaved,
            enabled: enabled,
            scrollPadding: scrollPadding,
            enableInteractiveSelection: enableInteractiveSelection,
            autovalidateMode: autovalidateMode,
          );
        });

  /// Constrains data to numbers greater than or equal to [min].
  ///
  /// [min] the smallest valid number.
  /// [trim] whether or not to trim the input value.
  /// [validator] an optional extra validation step.
  /// [blank] the error message in case of blank field; if omitted, the field
  /// will not be made required.
  /// [malformed] the error message for non-numeric input values.
  /// [small] the error message if a number is too small.
  NumField.min(
    num min, {
    bool trim = false,
    FormFieldValidator<String>? validator,
    String? blank,
    String? malformed,
    String? small,
    String? initialValue,
    TextEditingController? controller,
    InputDecoration? decoration,
    TextInputAction? textInputAction,
    TextStyle? style,
    TextDirection? textDirection,
    TextAlign textAlign = TextAlign.start,
    bool readOnly = false,
    String obscuringCharacter = '•',
    bool obscureText = false,
    bool autocorrect = true,
    int? maxLength,
    ValueChanged<String>? onChanged,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onFieldSubmitted,
    FormFieldSetter<String>? onSaved,
    List<TextInputFormatter>? inputFormatters,
    bool? enabled,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    AutovalidateMode? autovalidateMode,
    Key? key,
  }) : this(
          validator: Pair.str(
            Num.min(min, small: small).call,
            validator ?? const Ok().call,
          ).call,
          malformed: malformed,
          blank: blank,
          trim: trim,
          controller: controller,
          initialValue: initialValue,
          decoration: decoration,
          textInputAction: textInputAction,
          style: style,
          textDirection: textDirection,
          textAlign: textAlign,
          readOnly: readOnly,
          obscuringCharacter: obscuringCharacter,
          obscureText: obscureText,
          autocorrect: autocorrect,
          maxLength: maxLength,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          onFieldSubmitted: onFieldSubmitted,
          onSaved: onSaved,
          inputFormatters: inputFormatters,
          enabled: enabled,
          scrollPadding: scrollPadding,
          enableInteractiveSelection: enableInteractiveSelection,
          autovalidateMode: autovalidateMode,
          key: key,
        );

  /// Constrains entered data to positive numbers.
  ///
  /// [trim] whether or not to trim the input value.
  /// [validator] an optional extra validation step.
  /// [blank] the error message in case of blank field; if omitted, the field
  /// will not be made required.
  /// [malformed] the error message for non-numeric input values.
  /// [neg] the error message in case a negative number is entered.
  NumField.pos({
    bool trim = false,
    FormFieldValidator<String>? validator,
    String? blank,
    String? malformed,
    String? neg,
    String? initialValue,
    TextEditingController? controller,
    InputDecoration? decoration,
    TextInputAction? textInputAction,
    TextStyle? style,
    TextDirection? textDirection,
    TextAlign textAlign = TextAlign.start,
    bool readOnly = false,
    String obscuringCharacter = '•',
    bool obscureText = false,
    bool autocorrect = true,
    int? maxLength,
    ValueChanged<String>? onChanged,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onFieldSubmitted,
    FormFieldSetter<String>? onSaved,
    List<TextInputFormatter>? inputFormatters,
    bool? enabled,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    AutovalidateMode? autovalidateMode,
    Key? key,
  }) : this(
          validator:
              Pair.str(Num.pos(neg: neg).call, validator ?? const Ok().call)
                  .call,
          malformed: malformed,
          blank: blank,
          trim: trim,
          controller: controller,
          initialValue: initialValue,
          decoration: decoration,
          textInputAction: textInputAction,
          style: style,
          textDirection: textDirection,
          textAlign: textAlign,
          readOnly: readOnly,
          obscuringCharacter: obscuringCharacter,
          obscureText: obscureText,
          autocorrect: autocorrect,
          maxLength: maxLength,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          onFieldSubmitted: onFieldSubmitted,
          onSaved: onSaved,
          inputFormatters: inputFormatters,
          enabled: enabled,
          scrollPadding: scrollPadding,
          enableInteractiveSelection: enableInteractiveSelection,
          autovalidateMode: autovalidateMode,
          key: key,
        );

  /// Constrains data to numeric values that are less than or equal to [max].
  ///
  /// [max] the largest valid number.
  /// [trim] whether or not to trim the input value.
  /// [validator] an optional extra validation step.
  /// [blank] the error message in case of blank field; if omitted, the field
  /// will not be made required.
  /// [malformed] the error message for non-numeric input values.
  /// [large] the error message if a number is too large.
  NumField.max(
    num max, {
    bool trim = false,
    FormFieldValidator<String>? validator,
    String? blank,
    String? malformed,
    String? large,
    String? initialValue,
    TextEditingController? controller,
    InputDecoration? decoration = const InputDecoration(),
    TextInputAction? textInputAction,
    TextStyle? style,
    TextDirection? textDirection,
    TextAlign textAlign = TextAlign.start,
    bool readOnly = false,
    String obscuringCharacter = '•',
    bool obscureText = false,
    bool autocorrect = true,
    int? maxLength,
    ValueChanged<String>? onChanged,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onFieldSubmitted,
    FormFieldSetter<String>? onSaved,
    List<TextInputFormatter>? inputFormatters,
    bool? enabled,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    AutovalidateMode? autovalidateMode,
    Key? key,
  }) : this(
          validator: Pair.str(
            Num.max(max, large: large).call,
            validator ?? const Ok().call,
          ).call,
          malformed: malformed,
          blank: blank,
          trim: trim,
          controller: controller,
          initialValue: initialValue,
          decoration: decoration,
          textInputAction: textInputAction,
          style: style,
          textDirection: textDirection,
          textAlign: textAlign,
          readOnly: readOnly,
          obscuringCharacter: obscuringCharacter,
          obscureText: obscureText,
          autocorrect: autocorrect,
          maxLength: maxLength,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          onFieldSubmitted: onFieldSubmitted,
          onSaved: onSaved,
          inputFormatters: inputFormatters,
          enabled: enabled,
          scrollPadding: scrollPadding,
          enableInteractiveSelection: enableInteractiveSelection,
          autovalidateMode: autovalidateMode,
          key: key,
        );

  /// Constrains entered data to negative numbers.
  ///
  /// [trim] whether or not to trim the input value.
  /// [validator] an optional extra validation step.
  /// [blank] the error message in case of blank field; if omitted, the field
  /// will not be made required.
  /// [malformed] the error message for non-numeric input values.
  /// [pos] the error message in case a positive number is entered.
  NumField.neg({
    bool trim = false,
    FormFieldValidator<String>? validator,
    String? blank,
    String? malformed,
    String? pos,
    String? initialValue,
    TextEditingController? controller,
    InputDecoration? decoration,
    TextInputAction? textInputAction,
    TextStyle? style,
    TextDirection? textDirection,
    TextAlign textAlign = TextAlign.start,
    bool readOnly = false,
    String obscuringCharacter = '•',
    bool obscureText = false,
    bool autocorrect = true,
    int? maxLength,
    ValueChanged<String>? onChanged,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onFieldSubmitted,
    FormFieldSetter<String>? onSaved,
    List<TextInputFormatter>? inputFormatters,
    bool? enabled,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    AutovalidateMode? autovalidateMode,
    Key? key,
  }) : this(
          validator:
              Pair.str(Num.neg(pos: pos).call, validator ?? const Ok().call)
                  .call,
          malformed: malformed,
          blank: blank,
          trim: trim,
          controller: controller,
          initialValue: initialValue,
          decoration: decoration,
          textInputAction: textInputAction,
          style: style,
          textDirection: textDirection,
          textAlign: textAlign,
          readOnly: readOnly,
          obscuringCharacter: obscuringCharacter,
          obscureText: obscureText,
          autocorrect: autocorrect,
          maxLength: maxLength,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          onFieldSubmitted: onFieldSubmitted,
          onSaved: onSaved,
          inputFormatters: inputFormatters,
          enabled: enabled,
          scrollPadding: scrollPadding,
          enableInteractiveSelection: enableInteractiveSelection,
          autovalidateMode: autovalidateMode,
          key: key,
        );

  /// Constrains data to numbers within the range [min–max].
  ///
  /// [min] the smallest valid number; it must be < [max].
  /// [max] the largest valid number; it must be > [min].
  /// [trim] whether or not to trim the input value.
  /// [validator] an optional extra validation step.
  /// [blank] the error message in case of blank field; if omitted, the field
  /// [malformed] the error message for non-integer input values.
  /// [small] the error message if a number is too small.
  /// [large] the error message if a number is too large.
  NumField.range(
    num min,
    num max, {
    bool trim = false,
    FormFieldValidator<String>? validator,
    String? blank,
    String? malformed,
    String? small,
    String? large,
    String? initialValue,
    TextEditingController? controller,
    InputDecoration? decoration,
    TextInputAction? textInputAction,
    TextStyle? style,
    TextDirection? textDirection,
    TextAlign textAlign = TextAlign.start,
    bool readOnly = false,
    String obscuringCharacter = '•',
    bool obscureText = false,
    bool autocorrect = true,
    int? maxLength,
    ValueChanged<String>? onChanged,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onFieldSubmitted,
    FormFieldSetter<String>? onSaved,
    List<TextInputFormatter>? inputFormatters,
    bool? enabled,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    AutovalidateMode? autovalidateMode,
    Key? key,
  }) : this(
          validator: Pair.str(
            Num.range(min, max, small: small, large: large).call,
            validator ?? const Ok().call,
          ).call,
          malformed: malformed,
          blank: blank,
          trim: trim,
          controller: controller,
          initialValue: initialValue,
          decoration: decoration,
          textInputAction: textInputAction,
          style: style,
          textDirection: textDirection,
          textAlign: textAlign,
          readOnly: readOnly,
          obscuringCharacter: obscuringCharacter,
          obscureText: obscureText,
          autocorrect: autocorrect,
          maxLength: maxLength,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          onFieldSubmitted: onFieldSubmitted,
          onSaved: onSaved,
          inputFormatters: inputFormatters,
          enabled: enabled,
          scrollPadding: scrollPadding,
          enableInteractiveSelection: enableInteractiveSelection,
          autovalidateMode: autovalidateMode,
          key: key,
        );

  final ToBasicTextField _toNumField;

  /// Builds a [BasicTextField] suitable for numeric values.
  @override
  BasicTextField build(BuildContext context) => _toNumField(context);
}
