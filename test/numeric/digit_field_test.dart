import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formdator/formdator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:well_formed/well_formed.dart';

Future<void> main() async {
  group('DigitField', () {
    const kDef = Key('()');
    const kLen = Key('len');
    const kMin = Key('min');
    const kMax = Key('max');
    const kRange = Key('range');
    const keys = <Key>[kDef, kLen, kMin, kMax, kRange];
    testWidgets('length constraint', (WidgetTester tester) async {
      const diff = 'length error';
      const tenCharText = '0123456789';
      const short = '123';
      const long = '00112233445566778899';
      await tester.pumpWidget(
        WellFormed.app([DigitField.len(10, diff: diff)]),
      );
      final elem = tester.widget(find.byType(TextFormField));
      final val = (elem as TextFormField).validator!;
      expect(val(null), null);
      expect(val(tenCharText), null);
      expect(val(short), diff);
      expect(val(long), diff);
    });
    testWidgets('min length constraint', (WidgetTester tester) async {
      const less = 'too short text error';
      const tenChars = '0123456789';
      const tooShort = '999';
      const long = '99887766554433221100';
      await tester.pumpWidget(
        WellFormed.app([DigitField.min(10, less: less)]),
      );
      final elem = tester.widget(find.byType(TextFormField));
      final val = (elem as TextFormField).validator!;
      expect(val(null), null);
      expect(val(tenChars), null);
      expect(val(tooShort), less);
      expect(val(long), null);
    });
    testWidgets('max length constraint', (WidgetTester tester) async {
      const great = 'too long length error';
      const tenChars = '0123456789';
      const short = '777';
      const tooLong = '99999999999';
      await tester.pumpWidget(
        WellFormed.app([DigitField.max(10, great: great)]),
      );
      final elem = tester.widget(find.byType(TextFormField));
      final val = (elem as TextFormField).validator!;
      expect(val(null), null);
      expect(val(tenChars), null);
      expect(val(short), null);
      expect(val(tooLong), great);
    });
    testWidgets('range length constraint', (WidgetTester tester) async {
      const less = 'too short text error';
      const great = 'too long length error';
      const tenChars = '0123456789';
      const tooShort = '000';
      const tooLong = '000000000000000000000';
      await tester.pumpWidget(
        WellFormed.app([DigitField.range(10, 20, less: less, great: great)]),
      );
      final elem = tester.widget(find.byType(TextFormField));
      final val = (elem as TextFormField).validator!;
      expect(val(null), null);
      expect(val(tenChars), null);
      expect(val(tooShort), less);
      expect(val(tooLong), great);
    });
    testWidgets('key', (WidgetTester tester) async {
      await tester.pumpWidget(
        WellFormed.app([
          DigitField(key: kDef),
          DigitField.len(1, key: kLen),
          DigitField.min(1, key: kMin),
          DigitField.max(1, key: kMax),
          DigitField.range(1, 2, key: kRange),
        ]),
      );
      for (final key in keys) {
        expect(find.byKey(key), findsOneWidget);
      }
    });
    testWidgets('blank', (WidgetTester tester) async {
      const blankMsg = 'this field is required';
      await tester.pumpWidget(
        WellFormed.app([
          DigitField(key: kDef, blank: blankMsg, initialValue: '$kDef'),
          DigitField.len(5, key: kLen, blank: blankMsg, initialValue: '$kLen'),
          DigitField.min(5, key: kMin, blank: blankMsg, initialValue: '$kMin'),
          DigitField.max(5, key: kMax, blank: blankMsg, initialValue: '$kMax'),
          DigitField.range(1, 5,
              key: kRange, blank: blankMsg, initialValue: '$kRange'),
        ]),
      );
      for (final key in keys) {
        final elem = tester.widget(find.widgetWithText(TextFormField, '$key'));
        final val = (elem as TextFormField).validator!;
        expect(val(null), blankMsg);
        expect(val('12345'), null);
      }
    });
    testWidgets('validator', (WidgetTester tester) async {
      const error = 'cannot have odd digits';

      /// Input values cannot have uppercase letters.
      String? noOddDigits(String? v) =>
          (v != null && v.contains(RegExp('[13579]+'))) ? error : null;

      await tester.pumpWidget(
        WellFormed.app([DigitField(validator: noOddDigits)]),
      );
      final elem = tester.widget(find.byType(TextFormField));
      final val = (elem as TextFormField).validator!;
      expect(val(null), null);
      expect(val('0'), null);
      expect(val('246'), null);
      expect(val('2467'), error);
      expect(val('1'), error);
      expect(val('13'), error);
    });
    testWidgets('blank and validator', (WidgetTester tester) async {
      const error = 'it must always be invalid';
      await tester.pumpWidget(
        WellFormed.app([
          DigitField(blank: error, validator: const Nok(error: error)),
        ]),
      );
      final elem = tester.widget(find.byType(TextFormField));
      final val = (elem as TextFormField).validator!;
      expect(val(null), error);
      expect(val('0990'), error);
    });
    testWidgets('malformed', (WidgetTester tester) async {
      const malformedMsg = 'must contain only digits';
      await tester
          .pumpWidget(WellFormed.app([DigitField(malformed: malformedMsg)]));
      final elem = tester.widget(find.byType(TextFormField));
      final val = (elem as TextFormField).validator!;
      expect(val(null), null);
      expect(val('0'), null);
      expect(val('12345'), null);
      expect(val('12345X'), malformedMsg);
      expect(val('a'), malformedMsg);
      expect(val('!'), malformedMsg);
      expect(val('9!'), malformedMsg);
      expect(val(''), malformedMsg);
    });
    testWidgets('trim', (WidgetTester tester) async {
      final key = UniqueKey();
      const trimmed = '1234567890';
      const nonTrimmed = '\n $trimmed \t';
      var count = 0;
      await tester.pumpWidget(
        WellFormed.app([
          DigitField(
            key: key,
            trim: true,
            onChanged: (String s) {
              if (s.contains(RegExp('^$trimmed\$'))) {
                ++count;
              }
            },
          ),
        ]),
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
        WellFormed.app([DigitField(controller: controller)]),
      );
      final elem = tester.widget(find.byType(TextField));
      expect((elem as TextField).controller, controller);
      expect(find.text(init), findsOneWidget);
    });
    testWidgets('initialValue', (WidgetTester tester) async {
      const init = '1234567890';
      await tester.pumpWidget(
        WellFormed.app([DigitField(initialValue: init)]),
      );
      expect(find.text(init), findsOneWidget);
    });
    testWidgets('decoration', (WidgetTester tester) async {
      const label = 'Required';
      await tester.pumpWidget(
        WellFormed.app([
          DigitField(
            decoration: const InputDecoration(
              labelText: label,
              icon: Icon(Icons.code),
            ),
          ),
        ]),
      );
      expect(find.text(label), findsOneWidget);
    });
    testWidgets('textInputAction', (WidgetTester tester) async {
      await tester.pumpWidget(
        WellFormed.app([DigitField(textInputAction: TextInputAction.go)]),
      );
      final elem = tester.widget(find.byType(TextField));
      expect((elem as TextField).textInputAction, TextInputAction.go);
    });
    testWidgets('style', (WidgetTester tester) async {
      const style = TextStyle();
      await tester.pumpWidget(
        WellFormed.app([DigitField(style: style)]),
      );
      final elem = tester.widget(find.byType(TextField));
      expect((elem as TextField).style, style);
    });
    testWidgets('textDirection', (WidgetTester tester) async {
      const textDirection = TextDirection.rtl;
      await tester.pumpWidget(
        WellFormed.app([DigitField(textDirection: textDirection)]),
      );
      final elem = tester.widget(find.byType(TextField));
      expect((elem as TextField).textDirection, textDirection);
    });
    testWidgets('textAlign', (WidgetTester tester) async {
      const textAlign = TextAlign.justify;
      await tester.pumpWidget(
        WellFormed.app([DigitField(textAlign: textAlign)]),
      );
      final elem = tester.widget(find.byType(TextField));
      expect((elem as TextField).textAlign, textAlign);
    });
    testWidgets('readOnly', (WidgetTester tester) async {
      const readOnly = true;
      await tester.pumpWidget(
        WellFormed.app([DigitField(readOnly: readOnly)]),
      );
      final elem = tester.widget(find.byType(TextField));
      expect((elem as TextField).readOnly, readOnly);
    });
    testWidgets('obscureText', (WidgetTester tester) async {
      const obscureText = true;
      await tester.pumpWidget(
        WellFormed.app([DigitField(obscureText: obscureText)]),
      );
      final elem = tester.widget(find.byType(TextField));
      expect((elem as TextField).obscureText, obscureText);
    });
    testWidgets('autocorrect', (WidgetTester tester) async {
      const autocorrect = false;
      await tester.pumpWidget(
        WellFormed.app([DigitField(autocorrect: autocorrect)]),
      );
      final elem = tester.widget(find.byType(TextField));
      expect((elem as TextField).autocorrect, autocorrect);
    });
    testWidgets('obscuringCharacter', (WidgetTester tester) async {
      const obscuringCharacter = '*';
      await tester.pumpWidget(
        WellFormed.app([DigitField(obscuringCharacter: obscuringCharacter)]),
      );
      final elem = tester.widget(find.byType(TextField));
      expect((elem as TextField).obscuringCharacter, obscuringCharacter);
    });
    testWidgets('maxLength', (WidgetTester tester) async {
      const maxLength = 10;
      await tester.pumpWidget(
        WellFormed.app([DigitField(maxLength: maxLength)]),
      );
      final elem = tester.widget(find.byType(TextField));
      expect((elem as TextField).maxLength, maxLength);
    });
    testWidgets('keyboardType', (WidgetTester tester) async {
      const keyboardType = TextInputType.phone;
      await tester.pumpWidget(
        WellFormed.app([DigitField(keyboardType: keyboardType)]),
      );
      final elem = tester.widget(find.byType(TextField));
      expect((elem as TextField).keyboardType, keyboardType);
    });
    testWidgets('onChanged', (WidgetTester tester) async {
      final key = UniqueKey();
      var count = 0;
      await tester.pumpWidget(
        WellFormed.app(
            [DigitField(key: key, onChanged: (String s) => ++count)]),
      );
      await tester.enterText(find.byKey(key), '123');
      await tester.pumpAndSettle();
      // final elem = tester.widget(find.byType(TextField));
      expect(count, 1);
    });
    testWidgets('onEditingComplete', (WidgetTester tester) async {
      void onEdit() {}

      await tester.pumpWidget(
        WellFormed.app([DigitField(onEditingComplete: onEdit)]),
      );
      final elem = tester.widget(find.byType(TextField));
      expect((elem as TextField).onEditingComplete, onEdit);
    });
    testWidgets('onFieldSubmitted', (WidgetTester tester) async {
      final key = UniqueKey();
      void onSubmit(String s) {}
      await tester.pumpWidget(
        WellFormed.app([DigitField(key: key, onFieldSubmitted: onSubmit)]),
      );
      final elem = tester.widget(find.byType(TextField));
      expect((elem as TextField).onSubmitted, onSubmit);
    });
    testWidgets('onSaved', (WidgetTester tester) async {
      final key = UniqueKey();
      void onSaved(String? s) {}
      await tester.pumpWidget(
        WellFormed.app([DigitField(key: key, onSaved: onSaved)]),
      );
      final elem = tester.widget(find.byType(TextFormField));
      expect((elem as TextFormField).onSaved, onSaved);
    });
    testWidgets('inputFormatters', (WidgetTester tester) async {
      final key = UniqueKey();
      final formatters = [
        MaskTextInputFormatter(
          mask: '#####-###',
          filter: {"#": RegExp(r'\d')},
        ),
      ];
      await tester.pumpWidget(
        WellFormed.app([DigitField(key: key, inputFormatters: formatters)]),
      );
      await tester.enterText(find.byKey(key), '99999999');
      await tester.pumpAndSettle();
      final elem = tester.widget(find.byType(TextField));
      expect((elem as TextField).inputFormatters, formatters);
      expect(find.text('99999-999'), findsOneWidget);
    });
    testWidgets('enabled', (WidgetTester tester) async {
      const enabled = false;
      await tester.pumpWidget(
        WellFormed.app([DigitField(enabled: enabled)]),
      );
      final elem = tester.widget(find.byType(TextField));
      expect((elem as TextField).enabled, enabled);
    });
    testWidgets('scrollPadding', (WidgetTester tester) async {
      const scrollPadding = EdgeInsets.all(40.0);
      await tester.pumpWidget(
        WellFormed.app([DigitField(scrollPadding: scrollPadding)]),
      );
      final elem = tester.widget(find.byType(TextField));
      expect((elem as TextField).scrollPadding, scrollPadding);
    });
    testWidgets('enableInteractiveSelection', (WidgetTester tester) async {
      const enableInteractiveSelection = false;
      await tester.pumpWidget(
        WellFormed.app([
          DigitField(enableInteractiveSelection: enableInteractiveSelection),
        ]),
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
        WellFormed.app([DigitField(autovalidateMode: autoValidateMode)]),
      );
      final elem = tester.widget(find.byType(TextFormField));
      expect((elem as TextFormField).autovalidateMode, autoValidateMode);
    });
  });
}
