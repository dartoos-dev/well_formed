import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formdator/formdator.dart';
import 'package:well_formed/well_formed.dart';

/// Integer Form Field.
///
/// The Integer field only accepts integer values. Letters and most symbols
/// cannot be entered into this type of field. However, the negative sign ('-')
/// and the positive sign ('+') are allowed.
///
/// Non-numeric characters must somehow be filtered out so that they do not
/// appear in the form field. This is accomplished by setting the following:
///
/// - [Int] as the validator to limit input data to integer values
/// - the [inputFormatters] to deny non-digt characters except the minus
///   '-' and plus '+' signs.
/// - [TextInputType.numberWithOptions] as the keyboardType.
class IntField extends StatelessWidget {
  /// Integer Numbers Form Field.
  ///
  /// [malformed] the error message in case of non-numeric characters.
  /// [blank] the error message in case of blank field; if omitted, the field
  /// will not be made required.
  /// [trim] whether or not to trim the input value.
  /// [validator] an optional extra validation step.
  IntField({
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
    List<TextInputFormatter>? inputFormatters,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    AutovalidateMode? autovalidateMode,
    Key? key,
  })  : _toIntField = ((context) {
          return BasicTextField(
            validator: Pair.str(Int(mal: malformed), validator ?? _dummy),
            keyboardType: const TextInputType.numberWithOptions(signed: true),
            inputFormatters: inputFormatters ??
                [FilteringTextInputFormatter.allow(RegExp('[0-9+-]'))],
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
        }),
        super(key: key);

  /// Constrains data to integer numbers greater than or equal to [min].
  ///
  /// [min] the smallest valid integer number.
  /// [trim] whether or not to trim the input value.
  /// [validator] an optional extra validation step.
  /// [blank] the error message in case of blank field; if omitted, the field
  /// will not be made required.
  /// [malformed] the error message for non-integer input values.
  /// [small] the error message if an input integer number is too small.
  IntField.min(
    int min, {
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
    bool? enabled,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    AutovalidateMode? autovalidateMode,
    Key? key,
  }) : this(
          validator: Pair.str(Int.min(min, small: small), validator ?? _dummy),
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

  /// Constrains data to positive integers.
  ///
  /// It sets the [inputFormatters] to deny non-digt characters except the plus
  /// '+' sign.
  ///
  /// [trim] whether or not to trim the input value.
  /// [validator] an optional extra validation step.
  /// [blank] the error message in case of blank field; if omitted, the field
  /// will not be made required.
  /// [malformed] the error message for non-integer input values.
  /// [neg] the error message in case a negative integer is entered.
  IntField.pos({
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
    bool? enabled,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    AutovalidateMode? autovalidateMode,
    Key? key,
  }) : this(
          validator: Pair.str(Int.pos(neg: neg), validator ?? _dummy),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[0-9+]')),
          ],
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

  /// Constrains data to integer values that are less than or equal to [max].
  ///
  /// [max] the largest valid integer number.
  /// [trim] whether or not to trim the input value.
  /// [validator] an optional extra validation step.
  /// [blank] the error message in case of blank field; if omitted, the field
  /// will not be made required.
  /// [malformed] the error message for non-integer input values.
  /// [large] the error message if an input interger number is too large.
  IntField.max(
    int max, {
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
    bool? enabled,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    AutovalidateMode? autovalidateMode,
    Key? key,
  }) : this(
          validator: Pair.str(Int.max(max, large: large), validator ?? _dummy),
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

  /// Constrains entered data to negative integers.
  ///
  /// It sets the [inputFormatters] to deny non-digt characters except the minus
  /// '-' sign.
  ///
  /// [trim] whether or not to trim the input value.
  /// [validator] an optional extra validation step.
  /// [blank] the error message in case of blank field; if omitted, the field
  /// will not be made required.
  /// [malformed] the error message for non-integer input values.
  /// [pos] the error message in case a positive integer is entered.
  IntField.neg({
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
    bool? enabled,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    AutovalidateMode? autovalidateMode,
    Key? key,
  }) : this(
          validator: Pair.str(Int.neg(pos: pos), validator ?? _dummy),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[0-9-]')),
          ],
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

  /// Constrains data to integer numbers within the range [min–max].
  ///
  /// [min] the smallest valid integer number; it must be < [max].
  /// [max] the largest valid integer number; it must be > [min].
  /// [trim] whether or not to trim the input value.
  /// [validator] an optional extra validation step.
  /// [blank] the error message in case of blank field; if omitted, the field
  /// [malformed] the error message for non-integer input values.
  /// [small] the error message if an input integer number is too small.
  /// [large] the error message if an input interger number is too large.
  IntField.range(
    int min,
    int max, {
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
    bool? enabled,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    AutovalidateMode? autovalidateMode,
    Key? key,
  }) : this(
          validator: Pair.str(
            Int.range(min, max, small: small, large: large),
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

  final ToBasicTextField _toIntField;

  static String? _dummy(String? input) => null;

  /// Builds a [BasicTextField] suitable for integer values.
  @override
  BasicTextField build(BuildContext context) => _toIntField(context);
}
