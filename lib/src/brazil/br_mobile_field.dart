import 'package:flutter/material.dart';
import 'package:formdator/formdator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:well_formed/well_formed.dart';

/// Plano Brasileiro de Numeração Móvel — Brazilian Mobile Numbering Plan.
///
/// Brazil's mobile numbering plan uses a two-digit area code plus nine-digit
/// local numbers. Typically, a number is masked as (AA) NNNNN-NNNN, where AA =
/// area code and N = digit [0–9]. For example:
///
/// - unmasked (plain) number: "11987654321".
/// - unmasked with country code prefix: "+5511987654321".
/// - masked number: "(11) 98765-4321".
///
/// References:
///
/// - [br numbering plan](https://en.wikipedia.org/wiki/Telephone_numbers_in_Brazil)
/// - [br form masks](http://opensource.locaweb.com.br/locawebstyle-v2/manual/formularios/mascaras-forms/)
class BrMobileField extends StatelessWidget {
  /// Brazilian Mobile Numbers Form Field.
  ///
  /// [trim] whether or not to trim the input data.
  /// [strip] sets whether or not the mobile number value will be stripped of
  /// its parenthesis '(' and ')', hyphen '-' and space ' ' characters. If set
  /// to true, which is the default value, the input parameter of the [onSaved],
  /// [onChanged], and [onFieldSubmitted] functions will contain only digits.
  /// [malformed] the error message in case of a malformed mobile number.
  /// [blank] the error message in case of blank field; if omitted, the field
  /// will not be required.
  /// [validator] an optional extra validation step.
  BrMobileField({
    bool trim = false,
    bool strip = true,
    String? malformed,
    String? blank,
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
    bool? enabled,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    AutovalidateMode? autovalidateMode,
    super.key,
  }) : _toBrMobileField = ((context) {
          final FormFieldSetter<String>? onSavedStrip = onSaved == null
              ? null
              : !strip
                  ? onSaved
                  : (String? mask) => onSaved(BrMobileStrip(mask ?? '').value);
          final ValueChanged<String>? onChangedStrip = onChanged == null
              ? null
              : !strip
                  ? onChanged
                  : (String mask) =>
                      onChanged(mask.replaceAll(RegExp(r'[-()\s]'), ''));

          final ValueChanged<String>? onFieldSubmittedStrip =
              onFieldSubmitted == null
                  ? null
                  : !strip
                      ? onFieldSubmitted
                      : (String mask) => onFieldSubmitted(
                            mask.replaceAll(RegExp(r'[-()\s]'), ''),
                          );
          return BasicTextField(
            validator: Pair.str(
              BrMobile(mal: malformed).call,
              validator ?? const Ok().call,
            ).call,
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
                mask: '(##) #####-####',
                filter: {"#": RegExp(r'\d')},
              ),
            ],
            enabled: enabled,
            scrollPadding: scrollPadding,
            enableInteractiveSelection: enableInteractiveSelection,
            autovalidateMode: autovalidateMode,
          );
        });

  final ToBasicTextField _toBrMobileField;

  /// Builds a [BasicTextField] suitable for Brazilian mobile numbers.
  @override
  BasicTextField build(BuildContext context) => _toBrMobileField(context);
}
