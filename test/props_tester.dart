import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formdator/formdator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:well_formed/well_formed.dart';
import 'basic_text_field_builder.dart';
import 'digit_field_builder.dart';

/// The minimum amount of properties that a form field must support.
typedef ToField = Widget Function({
  String? blank,
  bool trim,
  TextInputType? keyboardType,
  TextEditingController? controller,
  String? initialValue,
  InputDecoration? decoration,
  TextInputAction? textInputAction,
  TextStyle? style,
  TextDirection? textDirection,
  TextAlign textAlign,
  bool readOnly,
  bool obscureText,
  bool autocorrect,
  String obscuringCharacter,
  int? maxLength,
  ValueChanged<String>? onChanged,
  VoidCallback? onEditingComplete,
  ValueChanged<String>? onFieldSubmitted,
  FormFieldSetter<String>? onSaved,
  FormFieldValidator<String>? validator,
  List<TextInputFormatter>? inputFormatters,
  bool? enabled,
  EdgeInsets scrollPadding,
  bool enableInteractiveSelection,
  AutovalidateMode? autovalidateMode,
  Key? key,
});

/// Basic Properties Tester — Checks 26 properties of a text form field.
///
/// These properties are:
///
/// - String? blank, bool trim, TextInputType? keyboardType;
/// - TextEditingController? controller, String? initialValue;
/// - InputDecoration? decoration, TextInputAction? textInputAction;
/// - TextStyle? style, TextDirection? textDirection, TextAlign textAlign;
/// - bool readOnly, bool obscureText, bool autocorrect, String obscuringCharacter;
/// - int? maxLength, TextInputType? keyboardType, ValueChanged<String>? onChanged;
/// - VoidCallback? onEditingComplete, ValueChanged<String>? onFieldSubmitted;
/// - FormFieldSetter<String>? onSaved, FormFieldValidator<String>? validator;
/// - List<TextInputFormatter>? inputFormatters, bool? enabled, EdgeInsets scrollPadding;
/// - bool enableInteractiveSelection, AutovalidateMode?  autovalidateMode; Key? key.
class PropsTester {
  /// [BasicTextField] test cases.
  ///
  /// [def] the description of the default constructor test cases.
  /// [len] the description of the len constructor test cases.
  /// [min] the description of the min constructor test cases.
  /// [max] the description of the max constructor test cases.
  /// [range] the description of the range constructor test cases.
  PropsTester.basic({
    String def = 'BasicTextField',
    String len = 'BasicTextField.len',
    String min = 'BasicTextField.min',
    String max = 'BasicTextField.max',
    String range = 'BasicTextField.range',
  }) : _toFields = {
          def: BasicTextFieldBuilder(),
          len: BasicTextFieldBuilder.len(),
          min: BasicTextFieldBuilder.min(),
          max: BasicTextFieldBuilder.max(),
          range: BasicTextFieldBuilder.range(),
        };

  /// [DigitField] test cases.
  ///
  /// [def] the description of the default constructor test cases.
  /// [len] the description of the len constructor test cases.
  /// [min] the description of the min constructor test cases.
  /// [max] the description of the max constructor test cases.
  /// [range] the description of the range constructor test cases.
  PropsTester.digit({
    String def = 'DigitField',
    String len = 'DigitField.len',
    String min = 'DigitField.min',
    String max = 'DigitField.max',
    String range = 'DigitField.range',
  }) : _toFields = {
          def: DigitFieldBuilder(),
          len: DigitFieldBuilder.len(),
          min: DigitFieldBuilder.min(),
          max: DigitFieldBuilder.max(),
          range: DigitFieldBuilder.range(),
        };

  /// Field widgets by test case description.
  final Map<String, ToField> _toFields;

  /// Run the entire test suite at once.
  Future<void> run() async {
    const thirteenChars = '13 characters';
    for (final testCase in _toFields.entries) {
      final title = testCase.key;
      final toField = testCase.value;
      group(title, () {
        testWidgets('key', (WidgetTester tester) async {
          const testKey = Key('K');
          await tester.pumpWidget(FormFieldTester(toField(key: testKey)));
          expect(find.byKey(testKey), findsOneWidget);
        });
        testWidgets('blank', (WidgetTester tester) async {
          const blankMsg = 'this field is required';
          await tester.pumpWidget(FormFieldTester(toField(blank: blankMsg)));
          final elem = tester.widget(find.byType(TextFormField));
          final val = (elem as TextFormField).validator!;
          expect(val(null), blankMsg);
          expect(val(''), blankMsg);
          expect(val(thirteenChars), null);
        });
        testWidgets('validator', (WidgetTester tester) async {
          const error = 'cannot have uppercase letters [A-Z]';

          /// Input values cannot have uppercase letters.
          String? noUppercase(String? v) =>
              (v != null && v.contains(RegExp('[A-Z]+'))) ? error : null;

          await tester.pumpWidget(
            FormFieldTester(toField(validator: noUppercase)),
          );
          final elem = tester.widget(find.byType(TextFormField));
          final val = (elem as TextFormField).validator!;
          expect(val(null), null);
          expect(val(thirteenChars), null);
          expect(val('13 Characters'), error);
        });
        testWidgets('blank and validator', (WidgetTester tester) async {
          const error = 'it must always be invalid';
          await tester.pumpWidget(
            FormFieldTester(
              toField(blank: error, validator: const Nok(error: error)),
            ),
          );
          final elem = tester.widget(find.byType(TextFormField));
          final val = (elem as TextFormField).validator!;
          expect(val(null), error);
          expect(val(''), error);
          expect(val(thirteenChars), error);
        });
        testWidgets('trim', (WidgetTester tester) async {
          final key = UniqueKey();
          const trimmed = 'abcdefghijklm';
          const nonTrimmed = '\n $trimmed \t';
          var count = 0;
          await tester.pumpWidget(
            FormFieldTester(
              toField(
                key: key,
                trim: true,
                onChanged: (String s) {
                  if (s.contains(RegExp('^$trimmed\$'))) {
                    ++count;
                  }
                },
              ),
            ),
          );
          await tester.enterText(find.byKey(key), nonTrimmed);
          await tester.pumpAndSettle();
          // final elem = tester.widget(find.byType(TextField));
          expect(count, 1);
        });
        testWidgets('controller', (WidgetTester tester) async {
          const init = 'Initial Text';
          final controller = TextEditingController(text: init);
          await tester.pumpWidget(
            FormFieldTester(toField(controller: controller)),
          );
          final elem = tester.widget(find.byType(TextField));
          expect((elem as TextField).controller, controller);
          expect(find.text(init), findsOneWidget);
        });
        testWidgets('initialValue', (WidgetTester tester) async {
          const init = '1234567890-ABCDEFGHIJKLMNOPQRSTUVXWYZ';
          await tester.pumpWidget(
            FormFieldTester(toField(initialValue: init)),
          );
          expect(find.text(init), findsOneWidget);
        });
        testWidgets('decoration', (WidgetTester tester) async {
          const label = 'Required';
          await tester.pumpWidget(
            FormFieldTester(
              toField(
                decoration: const InputDecoration(
                  labelText: label,
                  icon: Icon(Icons.code),
                ),
              ),
            ),
          );
          expect(find.text(label), findsOneWidget);
        });
        testWidgets('textInputAction', (WidgetTester tester) async {
          await tester.pumpWidget(
            FormFieldTester(toField(textInputAction: TextInputAction.go)),
          );
          final elem = tester.widget(find.byType(TextField));
          expect((elem as TextField).textInputAction, TextInputAction.go);
        });
        testWidgets('style', (WidgetTester tester) async {
          const style = TextStyle();
          await tester.pumpWidget(
            FormFieldTester(toField(style: style)),
          );
          final elem = tester.widget(find.byType(TextField));
          expect((elem as TextField).style, style);
        });
        testWidgets('textDirection', (WidgetTester tester) async {
          const textDirection = TextDirection.rtl;
          await tester.pumpWidget(
            FormFieldTester(toField(textDirection: textDirection)),
          );
          final elem = tester.widget(find.byType(TextField));
          expect((elem as TextField).textDirection, textDirection);
        });
        testWidgets('textAlign', (WidgetTester tester) async {
          const textAlign = TextAlign.justify;
          await tester.pumpWidget(
            FormFieldTester(toField(textAlign: textAlign)),
          );
          final elem = tester.widget(find.byType(TextField));
          expect((elem as TextField).textAlign, textAlign);
        });
        testWidgets('readOnly', (WidgetTester tester) async {
          const readOnly = true;
          await tester.pumpWidget(
            FormFieldTester(toField(readOnly: readOnly)),
          );
          final elem = tester.widget(find.byType(TextField));
          expect((elem as TextField).readOnly, readOnly);
        });
        testWidgets('obscureText', (WidgetTester tester) async {
          const obscureText = true;
          await tester.pumpWidget(
            FormFieldTester(toField(obscureText: obscureText)),
          );
          final elem = tester.widget(find.byType(TextField));
          expect((elem as TextField).obscureText, obscureText);
        });
        testWidgets('autocorrect', (WidgetTester tester) async {
          const autocorrect = false;
          await tester.pumpWidget(
            FormFieldTester(toField(autocorrect: autocorrect)),
          );
          final elem = tester.widget(find.byType(TextField));
          expect((elem as TextField).autocorrect, autocorrect);
        });
        testWidgets('obscuringCharacter', (WidgetTester tester) async {
          const obscuringCharacter = '*';
          await tester.pumpWidget(
            FormFieldTester(toField(obscuringCharacter: obscuringCharacter)),
          );
          final elem = tester.widget(find.byType(TextField));
          expect((elem as TextField).obscuringCharacter, obscuringCharacter);
        });
        testWidgets('maxLength', (WidgetTester tester) async {
          const maxLength = 10;
          await tester.pumpWidget(
            FormFieldTester(toField(maxLength: maxLength)),
          );
          final elem = tester.widget(find.byType(TextField));
          expect((elem as TextField).maxLength, maxLength);
        });
        testWidgets('keyboardType', (WidgetTester tester) async {
          const keyboardType = TextInputType.phone;
          await tester.pumpWidget(
            FormFieldTester(toField(keyboardType: keyboardType)),
          );
          final elem = tester.widget(find.byType(TextField));
          expect((elem as TextField).keyboardType, keyboardType);
        });
        testWidgets('onChanged', (WidgetTester tester) async {
          final key = UniqueKey();
          var count = 0;
          await tester.pumpWidget(
            FormFieldTester(
                toField(key: key, onChanged: (String s) => ++count)),
          );
          await tester.enterText(find.byKey(key), 'abc');
          await tester.pumpAndSettle();
          // final elem = tester.widget(find.byType(TextField));
          expect(count, 1);
        });
        testWidgets('onEditingComplete', (WidgetTester tester) async {
          void onEdit() {}

          await tester.pumpWidget(
            FormFieldTester(toField(onEditingComplete: onEdit)),
          );
          final elem = tester.widget(find.byType(TextField));
          expect((elem as TextField).onEditingComplete, onEdit);
        });
        testWidgets('onFieldSubmitted', (WidgetTester tester) async {
          final key = UniqueKey();
          void onSubmit(String s) {}
          await tester.pumpWidget(
            FormFieldTester(toField(key: key, onFieldSubmitted: onSubmit)),
          );
          final elem = tester.widget(find.byType(TextField));
          expect((elem as TextField).onSubmitted, onSubmit);
        });
        testWidgets('onSaved', (WidgetTester tester) async {
          final key = UniqueKey();
          void onSaved(String? s) {}
          await tester.pumpWidget(
            FormFieldTester(toField(key: key, onSaved: onSaved)),
          );
          final elem = tester.widget(find.byType(TextFormField));
          expect((elem as TextFormField).onSaved, onSaved);
        });
        testWidgets('inputFormatters', (WidgetTester tester) async {
          final key = UniqueKey();
          final formatters = [
            MaskTextInputFormatter(
              mask: '###.###.###-##',
              filter: {"#": RegExp(r'\d')},
            ),
          ];
          await tester.pumpWidget(
            FormFieldTester(toField(key: key, inputFormatters: formatters)),
          );
          await tester.enterText(find.byKey(key), '99999999999');
          await tester.pumpAndSettle();
          final elem = tester.widget(find.byType(TextField));
          expect((elem as TextField).inputFormatters, formatters);
          expect(find.text('999.999.999-99'), findsOneWidget);
        });
        testWidgets('enabled', (WidgetTester tester) async {
          const enabled = false;
          await tester.pumpWidget(
            FormFieldTester(toField(enabled: enabled)),
          );
          final elem = tester.widget(find.byType(TextField));
          expect((elem as TextField).enabled, enabled);
        });
        testWidgets('scrollPadding', (WidgetTester tester) async {
          const scrollPadding = EdgeInsets.all(40.0);
          await tester.pumpWidget(
            FormFieldTester(toField(scrollPadding: scrollPadding)),
          );
          final elem = tester.widget(find.byType(TextField));
          expect((elem as TextField).scrollPadding, scrollPadding);
        });
        testWidgets('enableInteractiveSelection', (WidgetTester tester) async {
          const enableInteractiveSelection = false;
          await tester.pumpWidget(
            FormFieldTester(
              toField(enableInteractiveSelection: enableInteractiveSelection),
            ),
          );
          final elem = tester.widget(find.byType(TextField));
          expect(
            (elem as TextField).enableInteractiveSelection,
            enableInteractiveSelection,
          );
        });
        testWidgets('autoValidateMode', (WidgetTester tester) async {
          const autoValidateMode = AutovalidateMode.onUserInteraction;
          await tester.pumpWidget(
            FormFieldTester(toField(autovalidateMode: autoValidateMode)),
          );
          final elem = tester.widget(find.byType(TextFormField));
          expect((elem as TextFormField).autovalidateMode, autoValidateMode);
        });
      });
    }
  }
}
