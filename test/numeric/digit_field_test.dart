import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formdator/formdator.dart';
import 'package:well_formed/src/core/well_formed.dart';
import 'package:well_formed/src/numeric/digit_field.dart';

Future<void> main() async {
  group('DigitField', () {
    const empty = ''; // zero-length text.
    const short = '123';
    const long = '012345678901234567890';
    const nonDigit = 'Error: non-digit character(s)';
    const blank = 'Error: this field is required';
    const diff = 'length error';
    const less = 'Error: the text is too short';
    const great = 'Error: the text is too long';
    const tenDigits = '0123456789';
    const tenDigitsX = '123456789X';
    const kDef = Key('()');
    const kLen = Key('len');
    const kMin = Key('min');
    const kMax = Key('max');
    const kRange = Key('range');
    const keys = <Key>[kDef, kLen, kMin, kMax, kRange];
    const init = '0000000000';
    const initLen = '1111111111';
    const initMin = '2222222222';
    const initMax = '3333333333';
    const initRange = '4444444444';
    const inits = [init, initLen, initMin, initMax, initRange];
    testWidgets('length constraint', (WidgetTester tester) async {
      await tester.pumpWidget(
        WellFormed.app([DigitField.len(10, malformed: nonDigit, diff: diff)]),
      );
      final elem = tester.widget(find.byType(TextFormField));
      final val = (elem as TextFormField).validator!;
      expect(val(null), null);
      expect(val(tenDigits), null);
      expect(val(empty), nonDigit);
      expect(val(tenDigitsX), nonDigit);
      expect(val(short), diff);
      expect(val(long), diff);
    });
    testWidgets('min length constraint', (WidgetTester tester) async {
      await tester.pumpWidget(
        WellFormed.app([DigitField.min(10, malformed: nonDigit, less: less)]),
      );
      final elem = tester.widget(find.byType(TextFormField));
      final val = (elem as TextFormField).validator!;
      expect(val(null), null);
      expect(val(tenDigits), null);
      expect(val(empty), nonDigit);
      expect(val(short), less);
      expect(val(long), null);
    });
    testWidgets('max length constraint', (WidgetTester tester) async {
      await tester.pumpWidget(
        WellFormed.app([DigitField.max(10, malformed: nonDigit, great: great)]),
      );
      final elem = tester.widget(find.byType(TextFormField));
      final val = (elem as TextFormField).validator!;
      expect(val(null), null);
      expect(val(empty), nonDigit);
      expect(val(tenDigits), null);
      expect(val(short), null);
      expect(val(long), great);
    });
    testWidgets('range length constraint', (WidgetTester tester) async {
      await tester.pumpWidget(
        WellFormed.app([
          DigitField.range(10, 20,
              malformed: nonDigit, less: less, great: great)
        ]),
      );
      final elem = tester.widget(find.byType(TextFormField));
      final val = (elem as TextFormField).validator!;
      expect(val(null), null);
      expect(val(tenDigitsX), nonDigit);
      expect(val(tenDigits), null);
      expect(val(short), less);
      expect(val(long), great);
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
      await tester.pumpWidget(
        WellFormed.app([
          DigitField(key: kDef, blank: blank, initialValue: '$kDef'),
          DigitField.len(5, key: kLen, blank: blank, initialValue: '$kLen'),
          DigitField.min(5, key: kMin, blank: blank, initialValue: '$kMin'),
          DigitField.max(5, key: kMax, blank: blank, initialValue: '$kMax'),
          DigitField.range(1, 5,
              key: kRange, blank: blank, initialValue: '$kRange'),
        ]),
      );
      for (final key in keys) {
        final elem = tester.widget(find.widgetWithText(TextFormField, '$key'));
        final val = (elem as TextFormField).validator!;
        expect(val(null), blank);
        expect(val('12345'), null);
      }
    });
    testWidgets('validator', (WidgetTester tester) async {
      const error = 'cannot have odd digits';

      /// Input values cannot have uppercase letters.
      String? noOddDigits(String? v) =>
          (v != null && v.contains(RegExp('[13579]+'))) ? error : null;

      final def = DigitField(validator: noOddDigits);
      final len = DigitField.len(3, validator: noOddDigits);
      final min = DigitField.min(3, validator: noOddDigits);
      final max = DigitField.max(3, validator: noOddDigits);
      final range = DigitField.range(3, 10, validator: noOddDigits);
      await tester.pumpWidget(WellFormed.app([def, len, min, max, range]));
      await tester.pump();
      final elems = tester.widgetList(find.byType(TextFormField));
      for (final elem in elems) {
        final val = (elem as TextFormField).validator!;
        expect(val(null), null);
        expect(val('246'), null);
        expect(val('247'), error);
        expect(val('111'), error);
        expect(val('138'), error);
      }
    });
    testWidgets('blank and validator', (WidgetTester tester) async {
      const error = 'it must always be invalid';
      const nok = Nok(error: error);
      await tester.pumpWidget(WellFormed.app([
        DigitField(blank: blank, validator: nok),
        DigitField.len(3, malformed: nonDigit, blank: blank, validator: nok),
        DigitField.min(3, malformed: nonDigit, blank: blank, validator: nok),
        DigitField.max(3, malformed: nonDigit, blank: blank, validator: nok),
        DigitField.range(3, 6,
            malformed: nonDigit, blank: blank, validator: nok),
      ]));
      await tester.pumpAndSettle();
      final elems = tester.widgetList(find.byType(TextFormField));
      for (final elem in elems) {
        final val = (elem as TextFormField).validator!;
        expect(val(null), blank);
        expect(val(empty), blank);
        expect(val('111'), error);
        expect(val('222'), error);
      }
    });
    testWidgets('malformed', (WidgetTester tester) async {
      Future<void> testDig(
          DigitField dig, List<String> good, List<String> bad) async {
        await tester.pumpWidget(WellFormed.app([dig]));
        final elem = tester.widget(find.byType(TextFormField));
        final validator = (elem as TextFormField).validator!;
        for (final ok in good) {
          expect(validator(ok), null);
        }
        for (final nok in bad) {
          expect(validator(nok), nonDigit);
        }
      }

      await testDig(
        DigitField(malformed: nonDigit),
        ['0', '12345', '00000000'],
        [empty, 'a', '0.0', '12345X', '?', '9!'],
      );
      await testDig(
        DigitField.len(3, malformed: nonDigit),
        ['999', '123', '000'],
        [empty, 'aaa', '0.0', '12X', '???', '9!9'],
      );
      await testDig(
        DigitField.min(1, malformed: nonDigit),
        ['0', '12345', '00000000'],
        [empty, 'a', '0.0', 'X2345', '&', '9A'],
      );
      await testDig(
        DigitField.max(10, malformed: nonDigit),
        ['0', '12345', '00000000'],
        [empty, 'a', '1.0', '12X456', '1,2', '9!'],
      );
      await testDig(
        DigitField.range(1, 10, malformed: nonDigit),
        ['0', '12345', '00000000'],
        [empty, 'a', '+1', '-1', '?', '9!'],
      );
    });
    testWidgets('trim and onChanged', (WidgetTester tester) async {
      const trimmed = '1234567890';
      const nonTrimmed = '\n $trimmed \t';
      var count = 0;
      void onChanged(String s) {
        if (s.contains(RegExp('^$trimmed\$'))) {
          ++count;
        }
      }

      await tester.pumpWidget(WellFormed.app([
        DigitField(key: kDef, trim: true, onChanged: onChanged),
        DigitField.len(10, key: kLen, trim: true, onChanged: onChanged),
        DigitField.min(10, key: kMin, trim: true, onChanged: onChanged),
        DigitField.max(10, key: kMax, trim: true, onChanged: onChanged),
        DigitField.range(10, 20, key: kRange, trim: true, onChanged: onChanged)
      ]));
      await tester.pumpAndSettle();
      for (final key in keys) {
        final before = count;
        await tester.enterText(find.byKey(key), nonTrimmed);
        await tester.pumpAndSettle();
        expect(count, before + 1);
      }
    });
    testWidgets('controller', (WidgetTester tester) async {
      await tester.pumpWidget(
        WellFormed.app([
          DigitField(controller: TextEditingController(text: init)),
          DigitField.len(23, controller: TextEditingController(text: initLen)),
          DigitField.min(23, controller: TextEditingController(text: initMin)),
          DigitField.max(23, controller: TextEditingController(text: initMax)),
          DigitField.range(
            15,
            25,
            controller: TextEditingController(text: initRange),
          ),
        ]),
      );
      await tester.pumpAndSettle();
      for (final init in inits) {
        expect(find.text(init), findsOneWidget);
      }
    });
    testWidgets('initialValue', (WidgetTester tester) async {
      await tester.pumpWidget(
        WellFormed.app([
          DigitField(initialValue: init),
          DigitField.len(23, initialValue: initLen),
          DigitField.min(23, initialValue: initMin),
          DigitField.max(23, initialValue: initMax),
          DigitField.range(15, 25, initialValue: initRange)
        ]),
      );
      await tester.pumpAndSettle();
      for (final init in inits) {
        expect(find.text(init), findsOneWidget);
      }
    });
    testWidgets('decoration', (WidgetTester tester) async {
      const label = 'default';
      const labelLen = 'len';
      const labelMin = 'min';
      const labelMax = 'max';
      const labelRange = 'range';
      const labels = [label, labelLen, labelMin, labelMax, labelRange];
      await tester.pumpWidget(
        WellFormed.app([
          DigitField(
            decoration: const InputDecoration(labelText: label),
          ),
          DigitField.len(
            23,
            decoration: const InputDecoration(labelText: labelLen),
          ),
          DigitField.min(
            23,
            decoration: const InputDecoration(labelText: labelMin),
          ),
          DigitField.max(
            23,
            decoration: const InputDecoration(labelText: labelMax),
          ),
          DigitField.range(
            20,
            30,
            decoration: const InputDecoration(labelText: labelRange),
          ),
        ]),
      );
      await tester.pumpAndSettle();
      for (final label in labels) {
        expect(find.text(label), findsOneWidget);
      }
    });
    testWidgets('textInputAction', (WidgetTester tester) async {
      const action = TextInputAction.send;
      const actionLen = TextInputAction.go;
      const actionMin = TextInputAction.join;
      const actionMax = TextInputAction.previous;
      const actionRange = TextInputAction.search;
      const actions = [action, actionLen, actionMin, actionMax, actionRange];
      await tester.pumpWidget(
        WellFormed.app([
          DigitField(textInputAction: action),
          DigitField.len(23, textInputAction: actionLen),
          DigitField.min(23, textInputAction: actionMin),
          DigitField.max(23, textInputAction: actionMax),
          DigitField.range(15, 25, textInputAction: actionRange),
        ]),
      );
      await tester.pumpAndSettle();
      final elems = tester.widgetList(find.byType(TextField));
      var i = 0;
      for (final elem in elems) {
        expect((elem as TextField).textInputAction, actions[i]);
        ++i;
      }
    });
    testWidgets('style', (WidgetTester tester) async {
      const style = TextStyle();
      await tester.pumpWidget(
        WellFormed.app([
          DigitField(style: style),
          DigitField.len(23, style: style),
          DigitField.min(23, style: style),
          DigitField.max(23, style: style),
          DigitField.range(15, 25, style: style),
        ]),
      );
      await tester.pumpAndSettle();
      final elems = tester.widgetList(find.byType(TextField));
      for (final elem in elems) {
        expect((elem as TextField).style, style);
      }
    });
    testWidgets('textDirection', (WidgetTester tester) async {
      const textDirection = TextDirection.rtl;
      await tester.pumpWidget(
        WellFormed.app([
          DigitField(textDirection: textDirection),
          DigitField.len(23, textDirection: textDirection),
          DigitField.min(23, textDirection: textDirection),
          DigitField.max(23, textDirection: textDirection),
          DigitField.range(15, 25, textDirection: textDirection),
        ]),
      );
      await tester.pumpAndSettle();
      final elems = tester.widgetList(find.byType(TextField));
      for (final elem in elems) {
        expect((elem as TextField).textDirection, textDirection);
      }
    });
    testWidgets('textAlign', (WidgetTester tester) async {
      const textAlign = TextAlign.justify;
      await tester.pumpWidget(
        WellFormed.app([
          DigitField(textAlign: textAlign),
          DigitField.len(23, textAlign: textAlign),
          DigitField.min(23, textAlign: textAlign),
          DigitField.max(23, textAlign: textAlign),
          DigitField.range(15, 25, textAlign: textAlign),
        ]),
      );
      await tester.pumpAndSettle();
      final elems = tester.widgetList(find.byType(TextField));
      for (final elem in elems) {
        expect((elem as TextField).textAlign, textAlign);
      }
    });
    testWidgets('readOnly', (WidgetTester tester) async {
      const readOnly = true;
      await tester.pumpWidget(
        WellFormed.app([
          DigitField(readOnly: readOnly),
          DigitField.len(23, readOnly: readOnly),
          DigitField.min(23, readOnly: readOnly),
          DigitField.max(23, readOnly: readOnly),
          DigitField.range(15, 25, readOnly: readOnly),
        ]),
      );
      await tester.pumpAndSettle();
      final elems = tester.widgetList(find.byType(TextField));
      for (final elem in elems) {
        expect((elem as TextField).readOnly, readOnly);
      }
    });
    testWidgets('obscureText', (WidgetTester tester) async {
      const obscureText = true;
      await tester.pumpWidget(
        WellFormed.app([
          DigitField(obscureText: obscureText),
          DigitField.len(23, obscureText: obscureText),
          DigitField.min(23, obscureText: obscureText),
          DigitField.max(23, obscureText: obscureText),
          DigitField.range(15, 25, obscureText: obscureText),
        ]),
      );
      await tester.pumpAndSettle();
      final elems = tester.widgetList(find.byType(TextField));
      for (final elem in elems) {
        expect((elem as TextField).obscureText, obscureText);
      }
    });
    testWidgets('autocorrect', (WidgetTester tester) async {
      const autocorrect = false;
      await tester.pumpWidget(
        WellFormed.app([
          DigitField(autocorrect: autocorrect),
          DigitField.len(23, autocorrect: autocorrect),
          DigitField.min(23, autocorrect: autocorrect),
          DigitField.max(23, autocorrect: autocorrect),
          DigitField.range(15, 25, autocorrect: autocorrect),
        ]),
      );
      await tester.pumpAndSettle();
      final elems = tester.widgetList(find.byType(TextField));
      for (final elem in elems) {
        expect((elem as TextField).autocorrect, autocorrect);
      }
    });
    testWidgets('obscuringCharacter', (WidgetTester tester) async {
      const obscuringCharacter = '*';
      await tester.pumpWidget(
        WellFormed.app([
          DigitField(obscuringCharacter: obscuringCharacter),
          DigitField.len(23, obscuringCharacter: obscuringCharacter),
          DigitField.min(23, obscuringCharacter: obscuringCharacter),
          DigitField.max(23, obscuringCharacter: obscuringCharacter),
          DigitField.range(15, 25, obscuringCharacter: obscuringCharacter),
        ]),
      );
      await tester.pumpAndSettle();
      final elems = tester.widgetList(find.byType(TextField));
      for (final elem in elems) {
        expect((elem as TextField).obscuringCharacter, obscuringCharacter);
      }
    });
    testWidgets('maxLength', (WidgetTester tester) async {
      const maxLength = 10;
      await tester.pumpWidget(
        WellFormed.app([
          DigitField(maxLength: maxLength),
          DigitField.len(23, maxLength: maxLength),
          DigitField.min(23, maxLength: maxLength),
          DigitField.max(23, maxLength: maxLength),
          DigitField.range(15, 25, maxLength: maxLength),
        ]),
      );
      await tester.pumpAndSettle();
      final elems = tester.widgetList(find.byType(TextField));
      for (final elem in elems) {
        expect((elem as TextField).maxLength, maxLength);
      }
    });
    testWidgets('default keyboardType', (WidgetTester tester) async {
      await tester.pumpWidget(
        WellFormed.app([
          DigitField(),
          DigitField.len(23),
          DigitField.min(23),
          DigitField.max(23),
          DigitField.range(15, 25),
        ]),
      );
      await tester.pumpAndSettle();
      final elems = tester.widgetList(find.byType(TextField));
      for (final elem in elems) {
        expect((elem as TextField).keyboardType, TextInputType.number);
      }
    });
    testWidgets('onEditingComplete', (WidgetTester tester) async {
      void onEdit() {}

      await tester.pumpWidget(
        WellFormed.app([
          DigitField(onEditingComplete: onEdit),
          DigitField.len(23, onEditingComplete: onEdit),
          DigitField.min(23, onEditingComplete: onEdit),
          DigitField.max(23, onEditingComplete: onEdit),
          DigitField.range(15, 25, onEditingComplete: onEdit),
        ]),
      );
      await tester.pumpAndSettle();
      final elems = tester.widgetList(find.byType(TextField));
      for (final elem in elems) {
        expect((elem as TextField).onEditingComplete, onEdit);
      }
    });
    testWidgets('onFieldSubmitted', (WidgetTester tester) async {
      void onSubmit(String s) {}
      await tester.pumpWidget(
        WellFormed.app([
          DigitField(onFieldSubmitted: onSubmit),
          DigitField.len(23, onFieldSubmitted: onSubmit),
          DigitField.min(23, onFieldSubmitted: onSubmit),
          DigitField.max(23, onFieldSubmitted: onSubmit),
          DigitField.range(15, 25, onFieldSubmitted: onSubmit),
        ]),
      );
      await tester.pumpAndSettle();
      final elems = tester.widgetList(find.byType(TextField));
      for (final elem in elems) {
        expect((elem as TextField).onSubmitted, onSubmit);
      }
    });
    testWidgets('onSaved', (WidgetTester tester) async {
      void onSaved(String? s) {}
      await tester.pumpWidget(
        WellFormed.app([
          DigitField(onSaved: onSaved),
          DigitField.len(23, onSaved: onSaved),
          DigitField.min(23, onSaved: onSaved),
          DigitField.max(23, onSaved: onSaved),
          DigitField.range(15, 25, onSaved: onSaved),
        ]),
      );
      await tester.pumpAndSettle();
      final elems = tester.widgetList(find.byType(TextFormField));
      for (final elem in elems) {
        expect((elem as TextFormField).onSaved, onSaved);
      }
    });

    /// non-digit characters must be filtered out by the input formatter so that
    /// they do not appear in the form field.
    testWidgets('default inputFormatters', (WidgetTester tester) async {
      await tester.pumpWidget(
        WellFormed.app([
          DigitField(key: kDef),
          DigitField.len(23, key: kLen),
          DigitField.min(23, key: kMin),
          DigitField.max(23, key: kMax),
          DigitField.range(15, 25, key: kRange),
        ]),
      );
      await tester.pumpAndSettle();
      for (var i = 0; i < keys.length; ++i) {
        final unmasked = '$i$i$i$i$i$i$i$i$i$i$i'; // E.g. 11111111111
        final masked = '$i$i$i.$i$i$i.$i$i$i-$i$i'; // E.g. 111.111.111-11
        await tester.enterText(find.byKey(keys[i]), masked);
        await tester.pumpAndSettle();
        final elem = tester.widget(find.widgetWithText(TextField, unmasked));
        expect(
          (elem as TextField).inputFormatters,
          [FilteringTextInputFormatter.digitsOnly],
        );
        expect(find.text(unmasked), findsOneWidget);
      }
    });
    testWidgets('enabled', (WidgetTester tester) async {
      const enabled = false;
      await tester.pumpWidget(
        WellFormed.app([
          DigitField(enabled: enabled),
          DigitField.len(23, enabled: enabled),
          DigitField.min(23, enabled: enabled),
          DigitField.max(23, enabled: enabled),
          DigitField.range(15, 25, enabled: enabled),
        ]),
      );
      await tester.pumpAndSettle();
      final elems = tester.widgetList(find.byType(TextField));
      for (final elem in elems) {
        expect((elem as TextField).enabled, enabled);
      }
    });
    testWidgets('scrollPadding', (WidgetTester tester) async {
      const scrollPadding = EdgeInsets.all(40.0);
      await tester.pumpWidget(
        WellFormed.app([
          DigitField(scrollPadding: scrollPadding),
          DigitField.len(23, scrollPadding: scrollPadding),
          DigitField.min(23, scrollPadding: scrollPadding),
          DigitField.max(23, scrollPadding: scrollPadding),
          DigitField.range(15, 25, scrollPadding: scrollPadding),
        ]),
      );
      await tester.pumpAndSettle();
      final elems = tester.widgetList(find.byType(TextField));
      for (final elem in elems) {
        expect((elem as TextField).scrollPadding, scrollPadding);
      }
    });
    testWidgets('enableInteraciveSelection', (WidgetTester tester) async {
      const enableInteractiveSelection = false;
      await tester.pumpWidget(
        WellFormed.app([
          DigitField(enableInteractiveSelection: enableInteractiveSelection),
          DigitField.len(23,
              enableInteractiveSelection: enableInteractiveSelection),
          DigitField.min(23,
              enableInteractiveSelection: enableInteractiveSelection),
          DigitField.max(23,
              enableInteractiveSelection: enableInteractiveSelection),
          DigitField.range(15, 25,
              enableInteractiveSelection: enableInteractiveSelection),
        ]),
      );
      await tester.pumpAndSettle();
      final elems = tester.widgetList(find.byType(TextField));
      for (final elem in elems) {
        expect((elem as TextField).enableInteractiveSelection,
            enableInteractiveSelection);
      }
    });
    testWidgets('autoValidateMode', (WidgetTester tester) async {
      const autovalidateMode = AutovalidateMode.onUserInteraction;
      await tester.pumpWidget(
        WellFormed.app([
          DigitField(autovalidateMode: autovalidateMode),
          DigitField.len(23, autovalidateMode: autovalidateMode),
          DigitField.min(23, autovalidateMode: autovalidateMode),
          DigitField.max(23, autovalidateMode: autovalidateMode),
          DigitField.range(15, 25, autovalidateMode: autovalidateMode),
        ]),
      );
      await tester.pumpAndSettle();
      final elems = tester.widgetList(find.byType(TextFormField));
      for (final elem in elems) {
        expect((elem as TextFormField).autovalidateMode, autovalidateMode);
      }
    });
  });
}
