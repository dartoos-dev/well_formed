import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formdator/formdator.dart';
import 'package:well_formed/well_formed.dart';

/// Email Form Field.
///
/// Valid inputs must be a valid email string.
///
/// Malformed emails must not be forwarded upon form submission. This is
/// accomplished by setting the following properties:
///
/// - [Email] as the validator to block forwarding of malformed emails
/// - [TextInputType.emailAddress] as the keyboardType.
class EmailField extends StatelessWidget {
  /// Email Form Field.
  ///
  /// [trim] whether or not to trim the entered email.
  /// [validator] an optional extra validation step.
  /// [blank] the error message in case of blank field; if omitted, the field
  /// will not be made required.
  /// [malformed] the error message in case of a malformed email.
  /// [long] the error message in case of an email address that is too long.
  EmailField({
    bool trim = false,
    FormFieldValidator<String>? validator,
    String? blank,
    String? malformed,
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
  })  : _toEmailField = ((context) {
          return BasicTextField(
            validator: Pair.str(Email(mal: malformed), validator ?? _dummy),
            keyboardType: TextInputType.emailAddress,
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
          );
        }),
        super(key: key);

  /// Email field that limits the length of the email to up to [len] characters.
  ///
  /// [len] the maximum length of an email address; it must be > 0.
  /// [trim] whether or not to trim the entered email.
  /// [validator] an optional extra validation step.
  /// [blank] the error message in case of blank field; if omitted, the field
  /// will not be made required.
  /// [malformed] the error message in case of a malformed email.
  EmailField.len(
    int len, {
    bool trim = false,
    FormFieldValidator<String>? validator,
    String? blank,
    String? malformed,
    String? long,
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
          validator: Pair.str2(Len.max(len, great: long), validator ?? _dummy),
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
  final ToBasicTextField _toEmailField;

  static String? _dummy(String? input) => null;

  /// Builds a [BasicTextField] suitable for CEP values.
  @override
  BasicTextField build(BuildContext context) => _toEmailField(context);
}
