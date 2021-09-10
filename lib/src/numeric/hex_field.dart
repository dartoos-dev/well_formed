import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formdator/formdator.dart';
import 'package:well_formed/well_formed.dart';

/// Hexadecimal-only Form Field.
///
/// Hexadecimal: any one of the sixteen hexadecimal digits [0–9A–F]. Non-hex
/// characters must somehow be filtered out so that they do not appear in the
/// form field. To achieve this, this widget:
///
/// - sets up a validator to block non-hexadecimal characters;
/// - sets the [inputFormatters] to deny non-hexadecimal characters.
/// - sets the [keyboardType] to [TextInputType.text] — due to the need for the
///   letters 'AaBbCcDdEeFf'.
class HexField extends StatelessWidget {
  /// Hex-only Form Field.
  ///
  /// [trim] whether or not to trim the input value.
  /// [validator] an optional extra validation step.
  /// [blank] the error message in case of blank field; if omitted, the field
  /// will not be made required.
  /// [malformed] the error message in case of non-hex characters.
  HexField({
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
    bool? enabled,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    AutovalidateMode? autovalidateMode,
    Key? key,
  })  : _toHexField = ((context) {
          return BasicTextField(
            validator: Pair.str(Hex(mal: malformed), validator ?? _dummy),
            keyboardType: TextInputType.text,
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp('[^0-9a-fA-F]'))
            ],
            blank: blank,
            trim: trim,
            controller: controller,
            initialValue: initialValue,
            decoration: decoration ?? const InputDecoration(),
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
        }),
        super(key: key);

  /// Hex-only form field with length constraint.
  ///
  /// [len] the exact number of hex digits; it must be > 0.
  /// [trim] whether or not to trim the input value.
  /// [validator] an optional extra validation step.
  /// [blank] the error message in case of blank field; if omitted, the field
  /// will not be made required.
  /// [malformed] the error message in case of non-hex characters.
  /// [diff] the error message if the number of hexs is different from [len].
  HexField.len(
    int len, {
    bool trim = false,
    FormFieldValidator<String>? validator,
    String? malformed,
    String? blank,
    String? diff,
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
          enabled: enabled,
          scrollPadding: scrollPadding,
          enableInteractiveSelection: enableInteractiveSelection,
          autovalidateMode: autovalidateMode,
          key: key,
        );

  /// Hex-only form field with minimum length constraint.
  ///
  /// [min] the minimum number of hex digits; it must be > 0.
  /// [trim] whether or not to trim the input value.
  /// [validator] an optional extra validation step.
  /// [blank] the error message in case of blank field; if omitted, the field
  /// will not be made required.
  /// [malformed] the error message in case of non-hex characters.
  /// [short] the error message if the length of the input data is shorter than
  /// [min].
  HexField.min(
    int min, {
    bool trim = false,
    FormFieldValidator<String>? validator,
    String? blank,
    String? malformed,
    String? short,
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
    bool? enabled,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    AutovalidateMode? autovalidateMode,
    Key? key,
  }) : this(
          validator: Pair.str(Len.min(min, short: short), validator ?? _dummy),
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
          enabled: enabled,
          scrollPadding: scrollPadding,
          enableInteractiveSelection: enableInteractiveSelection,
          autovalidateMode: autovalidateMode,
          key: key,
        );

  /// Hex-only form field with maximum length constraint.
  ///
  /// [max] the maximum number of hex digits; it must be > 0.
  /// [trim] whether or not to trim the input value.
  /// [validator] an optional extra validation step.
  /// [blank] the error message in case of blank field; if omitted, the field
  /// will not be made required.
  /// [malformed] the error message in case of non-hex characters.
  /// [short] the error message if the length of the input data is shorter than
  /// [min].
  /// [long] the error message if the length of the input data is longer than
  /// [max].
  HexField.max(
    int max, {
    bool trim = false,
    FormFieldValidator<String>? validator,
    String? blank,
    String? malformed,
    String? long,
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
    bool? enabled,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    AutovalidateMode? autovalidateMode,
    Key? key,
  }) : this(
          validator: Pair.str(Len.max(max, long: long), validator ?? _dummy),
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
          enabled: enabled,
          scrollPadding: scrollPadding,
          enableInteractiveSelection: enableInteractiveSelection,
          autovalidateMode: autovalidateMode,
          key: key,
        );

  /// Hex-only form field with length range constraint.
  ///
  /// [min] the minimum number of hex digits; it must be > 0 and < [max].
  /// [max] the maximum number of hex digits; it must be > 0 and > [min].
  /// [trim] whether or not to trim the input value.
  /// [validator] an optional extra validation step.
  /// [blank] the error message in case of blank field; if omitted, the field
  /// will not be made required.
  /// [malformed] the error message in case of non-hex characters.
  /// [short] the error message if the length of the input data is shorter than
  /// [min].
  /// [long] the error message if the length of the input data is longer than
  /// [max].
  HexField.range(
    int min,
    int max, {
    bool trim = false,
    FormFieldValidator<String>? validator,
    String? blank,
    String? malformed,
    String? short,
    String? long,
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
    bool? enabled,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    AutovalidateMode? autovalidateMode,
    Key? key,
  }) : this(
          validator: Pair.str(
            Len.range(min, max, short: short, long: long),
            validator ?? _dummy,
          ),
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
          enabled: enabled,
          scrollPadding: scrollPadding,
          enableInteractiveSelection: enableInteractiveSelection,
          autovalidateMode: autovalidateMode,
          key: key,
        );

  final ToBasicTextField _toHexField;

  static String? _dummy(String? input) => null;

  /// Builds a [BasicTextField] suitable for hexadecimal values.
  @override
  BasicTextField build(BuildContext context) => _toHexField(context);
}
