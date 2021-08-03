import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formdator/formdator.dart';
import 'package:well_formed/well_formed.dart';

/// Digit-only Form Field.
///
/// It sets both a validator for blocking non-digit characters and the
/// keyboardType to [TextInputType.number].
class DigitField extends StatelessWidget {
  /// Digit-only Form Field.
  ///
  /// [malformed] the error message in case of non-digit characters.
  /// [blank] the error message in case of blank field; if omitted, the field
  /// will not be required.
  /// [validator] an optional extra validation step.
  DigitField({
    String? malformed,
    String? blank,
    bool trim = false,
    TextInputType? keyboardType = TextInputType.number,
    TextEditingController? controller,
    String? initialValue,
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
    FormFieldValidator<String>? validator,
    List<TextInputFormatter>? inputFormatters,
    bool? enabled,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    AutovalidateMode? autovalidateMode,
    Key? key,
  })  : _toDigitField = ((context) {
          return BasicTextField(
            validator: Pair.str(Digit(non: malformed), validator ?? _dummy),
            blank: blank,
            trim: trim,
            keyboardType: keyboardType,
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
        }),
        super(key: key);

  /// Digit-only form field with length constraint.
  ///
  /// [len] the exact number of digits; it must be > 0.
  /// [malformed] the error message in case of non-digit characters.
  /// [diff] the error message if the number of digits is different from [len].
  /// [blank] the error message in case of blank field; if omitted, the field
  /// will not be required.
  /// [validator] an optional extra validation step.
  DigitField.len(
    int len, {
    String? malformed,
    String? diff,
    String? blank,
    bool trim = false,
    TextInputType? keyboardType = TextInputType.number,
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
    FormFieldValidator<String>? validator,
    List<TextInputFormatter>? inputFormatters,
    bool? enabled,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    AutovalidateMode? autovalidateMode,
    Key? key,
  }) : this(
          validator: Pair.str(Len(len, diff: diff), validator ?? _dummy),
          malformed: malformed,
          blank: blank,
          trim: trim,
          keyboardType: keyboardType,
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

  /// Digit-only form field with minimum length constraint.
  ///
  /// [min] the minimum number of digits; it must be > 0.
  /// [malformed] the error message in case of non-digit characters.
  /// [less] the error message if the number of digits is less than [min].
  /// [blank] the error message in case of blank field; if omitted, the field
  /// will not be required.
  /// [validator] an optional extra validation step.
  DigitField.min(
    int min, {
    String? malformed,
    String? less,
    String? blank,
    bool trim = false,
    TextInputType? keyboardType = TextInputType.number,
    FormFieldValidator<String>? validator,
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
          validator: Pair.str(Len.min(min, less: less), validator ?? _dummy),
          malformed: malformed,
          blank: blank,
          trim: trim,
          keyboardType: keyboardType,
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

  /// Digit-only form field with maximum length constraint.
  ///
  /// [max] the maximum number of digits; it must be > 0.
  /// [malformed] the error message in case of non-digit characters.
  /// [great] the error message if the number of digits is greater than [max].
  /// [blank] the error message in case of blank field; if omitted, the field
  /// will not be required.
  /// [validator] an optional extra validation step.
  DigitField.max(
    int max, {
    String? malformed,
    String? great,
    String? blank,
    bool trim = false,
    TextInputType? keyboardType = TextInputType.number,
    FormFieldValidator<String>? validator,
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
          validator: Pair.str(Len.max(max, great: great), validator ?? _dummy),
          malformed: malformed,
          blank: blank,
          trim: trim,
          keyboardType: keyboardType,
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

  /// Digit-only form field with length range constraint.
  ///
  /// [min] the minimum number of digits; it must be > 0 and < [max].
  /// [max] the maximum number of digits; it must be > 0 and > [min].
  /// [malformed] the error message in case of non-digit characters.
  /// [less] the error message if the number of digits is less than [min].
  /// [great] the error message if the number of digits is greater than [max].
  /// [blank] the error message in case of blank field; if omitted, the field
  /// will not be required.
  /// [validator] an optional extra validation step.
  DigitField.range(
    int min,
    int max, {
    String? malformed,
    String? less,
    String? great,
    String? blank,
    bool trim = false,
    TextInputType? keyboardType = TextInputType.number,
    FormFieldValidator<String>? validator,
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
            Len.range(min, max, less: less, great: great),
            validator ?? _dummy,
          ),
          malformed: malformed,
          blank: blank,
          trim: trim,
          keyboardType: keyboardType,
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

  final ToBasicTextField _toDigitField;

  static String? _dummy(String? input) => null;

  /// Builds a [BasicTextField] suitable for digit-only values.
  @override
  BasicTextField build(BuildContext context) => _toDigitField(context);
}
