import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formdator/formdator.dart';
import 'package:well_formed/src/core/well_formed.dart';
import 'package:well_formed/src/numeric/digit_field.dart';

import '../get_val.dart';

// ignore_for_file: require_trailing_commas
Future<void> main() async {
  group('DigitField', () {
    const empty = ''; // zero-length text.
    const shortText = '123';
    const longText = '012345678901234567890';
    const nonDigit = 'Error: non-digit character(s)';
    const blank = 'Error: this field is required';
    const diff = 'length error';
    const short = 'Error: the text is too short';
    const long = 'Error: the text is too long';
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
    group('length constraints', () {
      testWidgets('fixed', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val =
            await getVal(DigitField.len(10, malformed: nonDigit, diff: diff));
        expect(val(null), null);
        expect(val(tenDigits), null);
        expect(val(empty), nonDigit);
        expect(val(tenDigitsX), nonDigit);
        expect(val(shortText), diff);
        expect(val(longText), diff);
      });
      testWidgets('mininum', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val =
            await getVal(DigitField.min(10, malformed: nonDigit, short: short));
        expect(val(null), null);
        expect(val(tenDigits), null);
        expect(val(empty), nonDigit);
        expect(val(shortText), short);
        expect(val(longText), null);
      });
      testWidgets('maximum', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val =
            await getVal(DigitField.max(10, malformed: nonDigit, long: long));
        expect(val(null), null);
        expect(val(empty), nonDigit);
        expect(val(tenDigits), null);
        expect(val(shortText), null);
        expect(val(longText), long);
      });
      testWidgets('range', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(DigitField.range(
          10,
          20,
          malformed: nonDigit,
          short: short,
          long: long,
        ));
        expect(val(null), null);
        expect(val(tenDigitsX), nonDigit);
        expect(val(tenDigits), null);
        expect(val(shortText), short);
        expect(val(longText), long);
      });
    });
    group('key', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        await tester.pumpWidget(
          WellFormed.app([DigitField(key: kDef)]),
        );
        expect(find.byKey(kDef), findsOneWidget);
      });
      testWidgets('len ctor', (WidgetTester tester) async {
        await tester.pumpWidget(
          WellFormed.app([DigitField.len(1, key: kDef)]),
        );
        expect(find.byKey(kDef), findsOneWidget);
      });
      testWidgets('min ctor', (WidgetTester tester) async {
        await tester.pumpWidget(
          WellFormed.app([DigitField.min(1, key: kMin)]),
        );
        expect(find.byKey(kMin), findsOneWidget);
      });
      testWidgets('max ctor', (WidgetTester tester) async {
        await tester.pumpWidget(
          WellFormed.app([DigitField.max(1, key: kMax)]),
        );
        expect(find.byKey(kMax), findsOneWidget);
      });
      testWidgets('range ctor', (WidgetTester tester) async {
        await tester.pumpWidget(
          WellFormed.app([DigitField.range(1, 5, key: kRange)]),
        );
        expect(find.byKey(kRange), findsOneWidget);
      });
    });
    group('blank', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(
          DigitField(key: kDef, blank: blank, initialValue: '$kDef'),
        );
        expect(val(null), blank);
        expect(val('12345'), null);
      });
      testWidgets('len ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(
          DigitField.len(5, key: kDef, blank: blank, initialValue: '$kDef'),
        );
        expect(val(null), blank);
        expect(val('12345'), null);
      });
      testWidgets('min ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(
          DigitField.len(5, key: kDef, blank: blank, initialValue: '$kLen'),
        );
        expect(val(null), blank);
        expect(val('12345'), null);
      });
      testWidgets('max ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(
          DigitField.min(5, key: kMin, blank: blank, initialValue: '$kMin'),
        );
        expect(val(null), blank);
        expect(val('12345'), null);
      });
      testWidgets('range ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(
          DigitField.range(1, 5,
              key: kRange, blank: blank, initialValue: '$kRange'),
        );
        expect(val(null), blank);
        expect(val('12345'), null);
      });
    });
    group('validator', () {
      const error = 'cannot have odd digits';

      /// Input values cannot have uppercase letters.
      String? noOddDigits(String? v) =>
          (v != null && v.contains(RegExp('[13579]+'))) ? error : null;
      testWidgets('default ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(DigitField(validator: noOddDigits));
        expect(val(null), null);
        expect(val('0'), null);
        expect(val('246'), null);
        expect(val('1'), error);
        expect(val('247'), error);
      });
      testWidgets('len ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(DigitField.len(3, validator: noOddDigits));
        expect(val(null), null);
        expect(val('000'), null);
        expect(val('246'), null);
        expect(val('111'), error);
        expect(val('247'), error);
      });
      testWidgets('min ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(DigitField.min(1, validator: noOddDigits));
        expect(val(null), null);
        expect(val('0'), null);
        expect(val('246'), null);
        expect(val('1'), error);
        expect(val('247'), error);
      });
      testWidgets('max ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(DigitField.max(5, validator: noOddDigits));
        expect(val(null), null);
        expect(val('0'), null);
        expect(val('246'), null);
        expect(val('1'), error);
        expect(val('247'), error);
        expect(val('24689'), error);
      });
      testWidgets('range ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val =
            await getVal(DigitField.range(1, 5, validator: noOddDigits));
        expect(val(null), null);
        expect(val('0'), null);
        expect(val('246'), null);
        expect(val('1'), error);
        expect(val('247'), error);
      });
    });
    group('blank and validator', () {
      const error = 'it must always be invalid';
      const nok = Nok(error: error);

      testWidgets('default ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(DigitField(
          blank: blank,
          malformed: nonDigit,
          validator: nok,
        ));
        expect(val(null), blank);
        expect(val(empty), blank);
        expect(val('1X'), nonDigit);
        expect(val('9'), error);
        expect(val('111'), error);
      });
      testWidgets('len ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(DigitField.len(
          2,
          blank: blank,
          malformed: nonDigit,
          validator: nok,
        ));
        expect(val(null), blank);
        expect(val(empty), blank);
        expect(val('A1'), nonDigit);
        expect(val('11'), error);
        expect(val('99'), error);
      });
      testWidgets('min ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(DigitField.min(
          3,
          blank: blank,
          malformed: nonDigit,
          short: short,
          validator: nok,
        ));
        expect(val(null), blank);
        expect(val(empty), blank);
        expect(val('1.1'), nonDigit);
        expect(val('55'), short);
        expect(val('123'), error);
        expect(val('222'), error);
      });
      testWidgets('max ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(DigitField.max(
          3,
          blank: blank,
          malformed: nonDigit,
          long: long,
          validator: nok,
        ));
        expect(val(null), blank);
        expect(val(empty), blank);
        expect(val('+55'), nonDigit);
        expect(val('5555'), long);
        expect(val('9'), error);
        expect(val('11'), error);
        expect(val('246'), error);
      });
      testWidgets('range ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(DigitField.range(
          2,
          4,
          blank: blank,
          malformed: nonDigit,
          short: short,
          long: long,
          validator: nok,
        ));
        expect(val(null), blank);
        expect(val(empty), blank);
        expect(val('-55'), nonDigit);
        expect(val('9'), short);
        expect(val('99999'), long);
        expect(val('111'), error);
      });
    });
    group('malformed', () {
      Future<void> testDig(WidgetTester tester, DigitField dig,
          List<String> good, List<String> bad) async {
        final getVal = GetVal(tester);
        final val = await getVal(dig);
        for (final ok in good) {
          expect(val(ok), null);
        }
        for (final nok in bad) {
          expect(val(nok), nonDigit);
        }
      }

      testWidgets('default ctor', (WidgetTester tester) async {
        await testDig(
          tester,
          DigitField(malformed: nonDigit),
          ['0', '12345', '00000000'],
          [empty, 'a', '0.0', '12345X', '?', '9!'],
        );
      });
      testWidgets('len ctor', (WidgetTester tester) async {
        await testDig(
          tester,
          DigitField.len(3, malformed: nonDigit),
          ['999', '123', '000'],
          [empty, 'aaa', '0.0', '12X', '???', '9!9'],
        );
      });
      testWidgets('min ctor', (WidgetTester tester) async {
        await testDig(
          tester,
          DigitField.min(1, malformed: nonDigit),
          ['0', '12345', '00000000'],
          [empty, 'a', '0.0', 'X2345', '&', '9A'],
        );
      });
      testWidgets('max ctor', (WidgetTester tester) async {
        await testDig(
          tester,
          DigitField.max(10, malformed: nonDigit),
          ['0', '12345', '00000000'],
          [empty, 'a', '1.0', '12X456', '1,2', '9!'],
        );
      });
      testWidgets('range ctor', (WidgetTester tester) async {
        await testDig(
          tester,
          DigitField.range(1, 10, malformed: nonDigit),
          ['0', '12345', '00000000'],
          [empty, 'a', '+1', '-1', '?', '9!'],
        );
      });
    });
    group('trim and onChanged', () {
      const trimmed = '1234567890';
      const untrimmed = '\n $trimmed \t';
      var count = 0;
      void onChanged(String s) {
        if (s.contains(RegExp('^$trimmed\$'))) {
          ++count;
        }
      }

      testWidgets('main ctor', (WidgetTester tester) async {
        await tester.pumpWidget(WellFormed.app([
          DigitField(key: kDef, trim: true, onChanged: onChanged),
        ]));
        await tester.pumpAndSettle();
        final before = count;
        await tester.enterText(find.byKey(kDef), untrimmed);
        await tester.pumpAndSettle();
        expect(count, before + 1);
      });
      testWidgets('len ctor', (WidgetTester tester) async {
        await tester.pumpWidget(WellFormed.app([
          DigitField.len(10, key: kLen, trim: true, onChanged: onChanged),
        ]));
        await tester.pumpAndSettle();
        final before = count;
        await tester.enterText(find.byKey(kLen), untrimmed);
        await tester.pumpAndSettle();
        expect(count, before + 1);
      });
      testWidgets('min ctor', (WidgetTester tester) async {
        await tester.pumpWidget(WellFormed.app([
          DigitField.min(10, key: kMin, trim: true, onChanged: onChanged),
        ]));
        await tester.pumpAndSettle();
        final before = count;
        await tester.enterText(find.byKey(kMin), untrimmed);
        await tester.pumpAndSettle();
        expect(count, before + 1);
      });
      testWidgets('max ctor', (WidgetTester tester) async {
        await tester.pumpWidget(WellFormed.app([
          DigitField.max(10, key: kMax, trim: true, onChanged: onChanged),
        ]));
        await tester.pumpAndSettle();
        final before = count;
        await tester.enterText(find.byKey(kMax), untrimmed);
        await tester.pumpAndSettle();
        expect(count, before + 1);
      });
      testWidgets('range ctor', (WidgetTester tester) async {
        await tester.pumpWidget(WellFormed.app([
          DigitField.range(8, 12,
              key: kRange, trim: true, onChanged: onChanged),
        ]));
        await tester.pumpAndSettle();
        final before = count;
        await tester.enterText(find.byKey(kRange), untrimmed);
        await tester.pumpAndSettle();
        expect(count, before + 1);
      });
    });
    group('onSaved', () {
      void onSaved(String? s) {}

      testWidgets('default ctor', (WidgetTester tester) async {
        await tester.pumpWidget(
          WellFormed.app([DigitField(onSaved: onSaved)]),
        );
        final elem = tester.widget(find.byType(TextFormField));
        expect((elem as TextFormField).onSaved, onSaved);
      });
      testWidgets('len ctor', (WidgetTester tester) async {
        await tester.pumpWidget(
          WellFormed.app([DigitField.len(5, onSaved: onSaved)]),
        );
        final elem = tester.widget(find.byType(TextFormField));
        expect((elem as TextFormField).onSaved, onSaved);
      });
      testWidgets('min ctor', (WidgetTester tester) async {
        await tester.pumpWidget(
          WellFormed.app([DigitField.min(5, onSaved: onSaved)]),
        );
        final elem = tester.widget(find.byType(TextFormField));
        expect((elem as TextFormField).onSaved, onSaved);
      });
      testWidgets('max ctor', (WidgetTester tester) async {
        await tester.pumpWidget(
          WellFormed.app([DigitField.max(5, onSaved: onSaved)]),
        );
        final elem = tester.widget(find.byType(TextFormField));
        expect((elem as TextFormField).onSaved, onSaved);
      });
      testWidgets('range ctor', (WidgetTester tester) async {
        await tester.pumpWidget(
          WellFormed.app([DigitField.range(5, 10, onSaved: onSaved)]),
        );
        final elem = tester.widget(find.byType(TextFormField));
        expect((elem as TextFormField).onSaved, onSaved);
      });
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
