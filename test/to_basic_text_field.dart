import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:well_formed/core.dart';

/// Builds a [BasicTextField] instance with all properties set.
class ToBasicTextField {
  /// Returns a [BasicTextField] instance.
  BasicTextField call({
    Key? key,
    TextEditingController? controller,
    String? initialValue,
    InputDecoration? decoration,
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
  }) {
    return BasicTextField(
      key: key,
      controller: controller,
      initialValue: initialValue,
      decoration: decoration,
      textInputAction: textInputAction,
      style: style,
      textDirection: textDirection,
      textAlign: textAlign,
      readOnly: readOnly,
      obscureText: obscureText,
      autocorrect: autocorrect,
      obscuringCharacter: obscuringCharacter,
      maxLength: maxLength,
      keyboardType: keyboardType,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      onSaved: onSaved,
      validator: validator,
      inputFormatters: inputFormatters,
      enabled: enabled,
      scrollPadding: scrollPadding,
      enableInteractiveSelection: enableInteractiveSelection,
      autovalidateMode: autovalidateMode,
    );
  }
}
