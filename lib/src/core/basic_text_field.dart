import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formdator/formdator.dart';
import 'package:well_formed/well_formed.dart';

/// A basic text form field that can be made required and/or have its input data
/// trimmed.
///
/// Furthermore, this field is intended to serve as a base field for more
/// specific text fields.
class BasicTextField extends StatelessWidget {
  /// Text form field that can be made required (mandatory).
  ///
  /// [trim] whether or not to trim the input data.
  /// [blank] the error message in case of blank field; if omitted, the field
  /// will not be made required.
  /// [validator] an optional extra validation step.
  BasicTextField({
    bool trim = false,
    String? blank,
    TextEditingController? controller,
    String? initialValue,
    InputDecoration? decoration = const InputDecoration(),
    TextInputAction? textInputAction,
    TextStyle? style,
    TextDirection? textDirection,
    TextAlign textAlign = TextAlign.start,
    bool readOnly = false,
    bool obscureText = false,
    bool autocorrect = true,
    String obscuringCharacter = '•',
    int? maxLength,
    TextInputType? keyboardType,
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
  })  : _toBasicField = ((context) {
          ValStr val = validator ?? _ok;
          if (blank != null) {
            val = Pair.str2(Req(blank: blank), val);
          }
          if (trim) {
            val = Trim(val);
          }
          final ValueChanged<String>? maybeTrimOnChanged = onChanged == null
              ? null
              : trim
                  ? (String v) => onChanged(v.trim())
                  : onChanged;
          final ValueChanged<String>? maybeTrimOnFieldSub =
              onFieldSubmitted == null
                  ? null
                  : trim
                      ? (String v) => onFieldSubmitted(v.trim())
                      : onFieldSubmitted;
          final FormFieldSetter<String>? maybeTrimOnSaved = onSaved == null
              ? null
              : trim
                  ? (String? v) => onSaved(v?.trim())
                  : onSaved;
          return TextFormField(
            validator: val,
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
            onChanged: maybeTrimOnChanged,
            onEditingComplete: onEditingComplete,
            onFieldSubmitted: maybeTrimOnFieldSub,
            onSaved: maybeTrimOnSaved,
            inputFormatters: inputFormatters,
            enabled: enabled,
            scrollPadding: scrollPadding,
            enableInteractiveSelection: enableInteractiveSelection,
            autovalidateMode: autovalidateMode,
          );
        }),
        super(key: key);

  /// Text form field  whose number of characters (length) must be equal to
  /// [len] characters.
  ///
  /// [len] the exact length of the input data; it must be > 0.
  /// [diff] the error message in case the length of the input data is different
  /// from [len]; that is, the entered text contains fewer or more characters
  /// than [len].
  /// [trim] whether to trim or not the input data.
  /// [blank] the error message in case of blank field; if omitted, the field
  /// will not be made required.
  /// [validator] an optional extra validation step.
  BasicTextField.len(
    int len, {
    String? diff,
    bool trim = false,
    String? blank,
    TextEditingController? controller,
    String? initialValue,
    InputDecoration? decoration = const InputDecoration(),
    TextInputAction? textInputAction,
    TextStyle? style,
    TextDirection? textDirection,
    TextAlign textAlign = TextAlign.start,
    bool readOnly = false,
    bool obscureText = false,
    bool autocorrect = true,
    String obscuringCharacter = '•',
    int? maxLength,
    TextInputType? keyboardType,
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
          validator: Pair.str2(Len(len, diff: diff), validator ?? _ok),
          trim: trim,
          blank: blank,
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

  /// Text form field whose number of characters (length) must be at least [min]
  /// characters.
  ///
  /// [min] the minimum length of the input data; it must be > 0.
  /// [less] the error message in case the length of the input data is less than
  /// [min]; that is, the entered text contains fewer characters than [min].
  /// [trim] whether to trim or not the input data.
  /// [blank] the error message in case of blank field; if omitted, the field
  /// will not be made required.
  /// [validator] an optional extra validation step.
  BasicTextField.min(
    int min, {
    String? less,
    bool trim = false,
    String? blank,
    TextEditingController? controller,
    String? initialValue,
    InputDecoration? decoration = const InputDecoration(),
    TextInputAction? textInputAction,
    TextStyle? style,
    TextDirection? textDirection,
    TextAlign textAlign = TextAlign.start,
    bool readOnly = false,
    bool obscureText = false,
    bool autocorrect = true,
    String obscuringCharacter = '•',
    int? maxLength,
    TextInputType? keyboardType,
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
          validator: Pair.str2(Len.min(min, less: less), validator ?? _ok),
          trim: trim,
          blank: blank,
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

  /// Text form field  whose number of characters (length) must be at most [max]
  /// characters.
  ///
  /// [max] the maximum length of the input data; it must be > 0.
  /// [great] the error message in case the length of the input data is greater
  /// than [max]; that is, the entered text contains more characters than [max].
  /// [trim] whether to trim or not the input data.
  /// [blank] the error message in case of blank field; if omitted, the field
  /// will not be made required.
  /// [validator] an optional extra validation step.
  BasicTextField.max(
    int max, {
    String? great,
    bool trim = false,
    String? blank,
    TextEditingController? controller,
    String? initialValue,
    InputDecoration? decoration = const InputDecoration(),
    TextInputAction? textInputAction,
    TextStyle? style,
    TextDirection? textDirection,
    TextAlign textAlign = TextAlign.start,
    bool readOnly = false,
    bool obscureText = false,
    bool autocorrect = true,
    String obscuringCharacter = '•',
    int? maxLength,
    TextInputType? keyboardType,
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
          validator: Pair.str2(Len.max(max, great: great), validator ?? _ok),
          trim: trim,
          blank: blank,
          controller: controller,
          initialValue: initialValue,
          decoration: decoration,
          keyboardType: keyboardType,
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

  /// Text form field  whose number of characters (length) must within the range
  /// [min–max].
  ///
  /// [min] the minimum length of the input data; it must be > 0 and < [max].
  /// [max] the maximum length of the input data; it must be > 0 and > [min].
  /// [less] the error message in case the length of the input data is less than
  /// [min]; that is, the entered text contains fewer characters than [min].
  /// [great] the error message in case the length of the input data is greater
  /// than [max]; that is, the entered text contains more characters than [max].
  /// [trim] whether to trim or not the input data.
  /// [blank] the error message in case of blank field; if omitted, the field
  /// will not be made required.
  /// [validator] an optional extra validation step.
  BasicTextField.range(
    int min,
    int max, {
    String? less,
    String? great,
    bool trim = false,
    String? blank,
    TextEditingController? controller,
    String? initialValue,
    InputDecoration? decoration = const InputDecoration(),
    TextInputAction? textInputAction,
    TextStyle? style,
    TextDirection? textDirection,
    TextAlign textAlign = TextAlign.start,
    bool readOnly = false,
    bool obscureText = false,
    bool autocorrect = true,
    String obscuringCharacter = '•',
    int? maxLength,
    TextInputType? keyboardType,
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
          validator: Pair.str2(
            Len.range(min, max, less: less, great: great),
            validator ?? _ok,
          ),
          trim: trim,
          blank: blank,
          controller: controller,
          initialValue: initialValue,
          decoration: decoration,
          keyboardType: keyboardType,
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

  final ToTextField _toBasicField;

  static String? _ok(String? input) => const Ok().call(input);

  /// Builds a [TextFormField] that is made required if the 'blank' parameter of
  /// the constructor is not omitted.
  @override
  Widget build(BuildContext context) => _toBasicField(context);
}
