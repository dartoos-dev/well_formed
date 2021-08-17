import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formdator/formdator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:well_formed/well_formed.dart';

/// CNPJ — Cadastro Nacional de Pessoa Jurídica.
///
/// Kind of Brazilian Company's Registered Number or National Registry of Legal
/// Entities.
///
/// Valid inputs must match the pattern '##.###.###/####-##', where each '#' is
/// a digit [0-9].
class CnpjField extends StatelessWidget {
  /// Cnpj Form Field.
  ///
  /// [trim] whether or not to trim the input data.
  /// [strip] sets whether or not the CNPJ value will be stripped of its dot
  /// '.', slash '/', and hyphen '-' characters. If set to true, which is the
  /// default value, the input parameter of the [onSaved], [onChanged], and
  /// [onFieldSubmitted] functions will contain only digits.
  /// [malformed] the error message in case of a malformed CNPJ.
  /// [blank] the error message in case of blank field; if omitted, the field
  /// will not be required.
  /// [validator] an optional extra validation step.
  CnpjField({
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
  })  : _toCnpjField = ((context) {
          final FormFieldSetter<String>? onSavedStrip = onSaved == null
              ? null
              : !strip
                  ? onSaved
                  : (String? mask) {
                      if (mask == null) {
                        onSaved(mask);
                      } else {
                        onSaved(CnpjStrip(mask).value);
                      }
                    };
          final ValueChanged<String>? onChangedStrip = onChanged == null
              ? null
              : !strip
                  ? onChanged
                  : (String mask) =>
                      onChanged(mask.replaceAll(RegExp('[-/.]'), ''));

          final ValueChanged<String>? onFieldSubmittedStrip =
              onFieldSubmitted == null
                  ? null
                  : !strip
                      ? onFieldSubmitted
                      : (String mask) => onFieldSubmitted(
                          mask.replaceAll(RegExp('[-/.]'), ''));
          return BasicTextField(
            validator: Pair.str(Cnpj(mal: malformed), validator ?? _dummy),
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
                mask: '##.###.###/####-##',
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

  final ToBasicTextField _toCnpjField;

  static String? _dummy(String? input) => null;

  /// Builds a [BasicTextField] suitable for CNPJ values.
  @override
  BasicTextField build(BuildContext context) => _toCnpjField(context);
}
