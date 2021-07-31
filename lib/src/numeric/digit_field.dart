import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formdator/formdator.dart';
import 'package:well_formed/well_formed.dart';

/// Digit-only Form Field
class DigitField extends StatelessWidget {
  /// Digit-only Form Field
  ///
  /// [blank] the error message in case of blank field; if omitted, the field
  /// will not be required.
  /// [malformed] the error message in case of non-digit characters.
  /// [validator] an optional extra validation step.
  DigitField({
    String? blank,
    String? malformed,
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
          final vals = Rules<String>([
            if (blank == null)
              Digit(non: malformed)
            else
              ReqDigit(blank: blank, non: malformed),
            validator ?? const Ok().call,
          ]);
          return TextFormField(
            validator: vals,
            controller: controller,
            initialValue: initialValue,
            decoration: decoration,
            keyboardType: TextInputType.number,
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

  /// Digit-only form field in which the number of digits must equal to [len].
  ///
  /// [len] the exact number of digits; it must be > 0.
  /// [blank] the error message in case of blank field; if omitted, the field
  /// will not be required.
  /// [malformed] the error message in case of non-digit characters.
  /// [diff] the error message if the number of digits is different from [len].
  /// [validator] an optional extra validation step.
  DigitField.len(
    int len, {
    String? blank,
    String? diff,
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
          validator: Pair.str(
            Len(len, diff: diff),
            validator ?? const Ok().call,
          ),
          blank: blank,
          key: key,
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

  /// Digit-only Form Field in which the number of input digits must be greater
  /// than or equal to [min].
  ///
  /// [min] the minimum number of digits; it must be > 0.
  /// [blank] the error message in case of blank field; if omitted, the field
  /// will not be required.
  /// [malformed] the error message in case of non-digit characters.
  /// [less] the error message if the number of digits is less than [min].
  /// [validator] an optional extra validation step.
  DigitField.min(
    int min, {
    String? blank,
    String? less,
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
            Len.min(min, less: less),
            validator ?? const Ok().call,
          ),
          blank: blank,
          key: key,
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

  /// Digit-only form field in which the number of input digits must be less
  /// than or equal to [max].
  ///
  /// [max] the maximum number of digits; it must be > 0.
  /// [blank] the error message in case of blank field; if omitted, the field
  /// [malformed] the error message in case of non-digit characters.
  /// [great] the error message if the number of digits is greater than [max].
  /// [validator] an optional extra validation step.
  DigitField.max(
    int max, {
    String? blank,
    String? great,
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
            Len.max(max, great: great),
            validator ?? const Ok().call,
          ),
          blank: blank,
          key: key,
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

  /// Digit-only form field in which the number of input digits must be within
  /// the range [min–max].
  ///
  /// [min] the minimum number of digits; it must be > 0 and < [max].
  /// [max] the maximum number of digits; it must be > 0 and > [min].
  /// [blank] the error message in case of blank field; if omitted, the field
  /// [malformed] the error message in case of non-digit characters.
  /// [less] the error message if the number of digits is less than [min].
  /// [great] the error message if the number of digits is greater than [max].
  /// [validator] an optional extra validation step.
  DigitField.range(
    int min,
    int max, {
    String? blank,
    String? less,
    String? great,
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
            validator ?? const Ok().call,
          ),
          blank: blank,
          key: key,
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

  final ToTextField _toDigitField;

  /// Builds a [TextFormField] suitable for digit-only values.
  @override
  Widget build(BuildContext context) => _toDigitField(context);
}
/*
   @todo #8 document the reasons for leaving out several constructor parameters.
   FocusNode? focusNode,
   TextInputType? keyboardType,
   TextCapitalization textCapitalization = TextCapitalization.none,
   StrutStyle? strutStyle,
   TextAlignVertical? textAlignVertical,
   bool autofocus = false,
   ToolbarOptions? toolbarOptions,
   bool? showCursor,
   SmartDashesType? smartDashesType,
   SmartQuotesType? smartQuotesType,
   bool enableSuggestions = true,
   MaxLengthEnforcement? maxLengthEnforcement,
   int? maxLines = 1,
   int? minLines,
   bool expands = false,
   GestureTapCallback? onTap,
   double cursorWidth = 2.0,
   double? cursorHeight,
   Radius? cursorRadius,
   Color? cursorColor,
   Brightness? keyboardAppearance,
   TextSelectionControls? selectionControls,
   InputCounterWidgetBuilder? buildCounter,
   ScrollPhysics? scrollPhysics,
   Iterable<String>? autofillHints,
   ScrollController? scrollController,
   */
