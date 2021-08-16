import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formdator/formdator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:well_formed/well_formed.dart';

/// CPF - Cadastro da Pessoa Física.
///
/// Kind of Brazilian SSN - Social Security Number.
///
/// Valid inputs must match the pattern '###.###.###-##', where each '#' is a
/// digit [0-9].
class CpfField extends StatelessWidget {
  /// Cpf Form Field.
  ///
  /// [trim] whether or not to trim the input data.
  /// [strip] sets whether or not the dots '.' and the hyphen '-' of the cpf
  /// value will be removed from it. If set to true, which is the default value,
  /// the input value of the [onSaved], [onChanged] and [onFieldSubmitted]
  /// callbacks will always be an unmasked (simple) value.
  /// [malformed] the error message in case of a malformed CPF.
  /// [blank] the error message in case of blank field; if omitted, the field
  /// will not be required.
  /// [validator] an optional extra validation step.
  CpfField({
    bool trim = false,
    bool strip = true,
    String? malformed,
    String? blank,
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
    bool? enabled,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    AutovalidateMode? autovalidateMode,
    Key? key,
  })  : _toCpfField = ((context) {
          final FormFieldSetter<String>? onSavedStrip = onSaved == null
              ? null
              : !strip
                  ? onSaved
                  : (String? mask) {
                      if (mask == null) {
                        onSaved(mask);
                      } else {
                        onSaved(CpfStrip(mask).value);
                      }
                    };
          final ValueChanged<String>? onChangedStrip = onChanged == null
              ? null
              : !strip
                  ? onChanged
                  : (String mask) =>
                      onChanged(mask.replaceAll(RegExp('[-.]'), ''));

          final ValueChanged<String>? onFieldSubmittedStrip =
              onFieldSubmitted == null
                  ? null
                  : !strip
                      ? onFieldSubmitted
                      : (String mask) =>
                          onFieldSubmitted(mask.replaceAll(RegExp('[-.]'), ''));
          return BasicTextField(
            validator: Pair.str(Cpf(mal: malformed), validator ?? _dummy),
            blank: blank,
            trim: trim,
            keyboardType: TextInputType.number,
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
            onChanged: onChangedStrip,
            onEditingComplete: onEditingComplete,
            onFieldSubmitted: onFieldSubmittedStrip,
            onSaved: onSavedStrip,
            inputFormatters: [
              MaskTextInputFormatter(
                mask: '###.###.###-##',
                filter: {"#": RegExp(r'\d')},
              )
            ],
            enabled: enabled,
            scrollPadding: scrollPadding,
            enableInteractiveSelection: enableInteractiveSelection,
            autovalidateMode: autovalidateMode,
          );
        }),
        super(key: key);

  final ToBasicTextField _toCpfField;

  static String? _dummy(String? input) => null;

  /// Builds a [BasicTextField] suitable for CPF values.
  @override
  BasicTextField build(BuildContext context) => _toCpfField(context);
}
