import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formdator/formdator.dart';
import 'package:well_formed/well_formed.dart';

/// A text form field that can be made required and/or have its input data
/// trimmed.
///
/// Furthermore, this field is intended to serve as a base field for more
/// specific text fields.
class BasicTextField extends StatelessWidget {
  /// Optionally required field.
  ///
  /// [trim] whether to trim or not the input data.
  /// [blank] the error message in case of blank field; if omitted, the field
  /// will not be required.
  /// [validator] an optional extra validation step.
  BasicTextField({
    bool trim = false,
    String? blank,
    Key? key,
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
  })  : _toBasicField = ((context) {
          ValStr val = validator ?? _ok;
          if (blank != null) {
            val = Pair.str2(Req(blank: blank), val);
            if (trim) {
              val = Trim(val);
            }
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

  final ToTextField _toBasicField;

  static String? _ok(String? input) => const Ok().call(input);

  /// Builds a [TextFormField] that is made required if the 'blank' parameter of
  /// the constructor is not omitted.
  @override
  Widget build(BuildContext context) => _toBasicField(context);
}
