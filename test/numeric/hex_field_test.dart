import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formdator/formdator.dart';
import 'package:well_formed/src/core/well_formed.dart';
import 'package:well_formed/src/numeric/hex_field.dart';

import '../get_val.dart';

// ignore_for_file: require_trailing_commas
Future<void> main() async {
  group('HexField', () {
    const empty = ''; // zero-length text.
    const shortText = 'ABC';
    const longText = 'cafeBabe012345689ABCDEF';
    const nonHex = 'Error: non-hex character(s)';
    const blank = 'Error: this field is required';
    const diff = 'length error';
    const short = 'Error: the text is too short';
    const long = 'Error: the text is too long';
    const tenHexDigits = '0123456789';
    const tenHexDigitsX = '123456789X';
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
            await getVal(HexField.len(10, malformed: nonHex, diff: diff));
        expect(val(null), null);
        expect(val(tenHexDigits), null);
        expect(val(empty), nonHex);
        expect(val(tenHexDigitsX), nonHex);
        expect(val(shortText), diff);
        expect(val(longText), diff);
      });
      testWidgets('mininum', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val =
            await getVal(HexField.min(10, malformed: nonHex, short: short));
        expect(val(null), null);
        expect(val(tenHexDigits), null);
        expect(val(empty), nonHex);
        expect(val(shortText), short);
        expect(val(longText), null);
      });
      testWidgets('maximum', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val =
            await getVal(HexField.max(10, malformed: nonHex, long: long));
        expect(val(null), null);
        expect(val(empty), nonHex);
        expect(val(tenHexDigits), null);
        expect(val(shortText), null);
        expect(val(longText), long);
      });
      testWidgets('range', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(HexField.range(
          10,
          20,
          malformed: nonHex,
          short: short,
          long: long,
        ));
        expect(val(null), null);
        expect(val(tenHexDigitsX), nonHex);
        expect(val(tenHexDigits), null);
        expect(val(shortText), short);
        expect(val(longText), long);
      });
    });
    group('key', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        await tester.pumpWidget(
          WellFormed.app([HexField(key: kDef)]),
        );
        expect(find.byKey(kDef), findsOneWidget);
      });
      testWidgets('len ctor', (WidgetTester tester) async {
        await tester.pumpWidget(
          WellFormed.app([HexField.len(1, key: kDef)]),
        );
        expect(find.byKey(kDef), findsOneWidget);
      });
      testWidgets('min ctor', (WidgetTester tester) async {
        await tester.pumpWidget(
          WellFormed.app([HexField.min(1, key: kMin)]),
        );
        expect(find.byKey(kMin), findsOneWidget);
      });
      testWidgets('max ctor', (WidgetTester tester) async {
        await tester.pumpWidget(
          WellFormed.app([HexField.max(1, key: kMax)]),
        );
        expect(find.byKey(kMax), findsOneWidget);
      });
      testWidgets('range ctor', (WidgetTester tester) async {
        await tester.pumpWidget(
          WellFormed.app([HexField.range(1, 5, key: kRange)]),
        );
        expect(find.byKey(kRange), findsOneWidget);
      });
    });
    group('blank', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(
          HexField(key: kDef, blank: blank, initialValue: '$kDef'),
        );
        expect(val(null), blank);
        expect(val('12345'), null);
      });
      testWidgets('len ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(
          HexField.len(5, key: kDef, blank: blank, initialValue: '$kDef'),
        );
        expect(val(null), blank);
        expect(val('12345'), null);
      });
      testWidgets('min ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(
          HexField.len(5, key: kDef, blank: blank, initialValue: '$kLen'),
        );
        expect(val(null), blank);
        expect(val('12345'), null);
      });
      testWidgets('max ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(
          HexField.min(5, key: kMin, blank: blank, initialValue: '$kMin'),
        );
        expect(val(null), blank);
        expect(val('12345'), null);
      });
      testWidgets('range ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(
          HexField.range(1, 5,
              key: kRange, blank: blank, initialValue: '$kRange'),
        );
        expect(val(null), blank);
        expect(val('12345'), null);
      });
    });
    group('validator', () {
      const error = 'cannot have odd hexs';

      /// Input values cannot have uppercase letters.
      String? noOddHexs(String? v) =>
          (v != null && v.contains(RegExp('[13579]+'))) ? error : null;
      testWidgets('default ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(HexField(validator: noOddHexs));
        expect(val(null), null);
        expect(val('0'), null);
        expect(val('246'), null);
        expect(val('1'), error);
        expect(val('247'), error);
      });
      testWidgets('len ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(HexField.len(3, validator: noOddHexs));
        expect(val(null), null);
        expect(val('000'), null);
        expect(val('246'), null);
        expect(val('111'), error);
        expect(val('247'), error);
      });
      testWidgets('min ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(HexField.min(1, validator: noOddHexs));
        expect(val(null), null);
        expect(val('0'), null);
        expect(val('246'), null);
        expect(val('1'), error);
        expect(val('247'), error);
      });
      testWidgets('max ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(HexField.max(5, validator: noOddHexs));
        expect(val(null), null);
        expect(val('0'), null);
        expect(val('246'), null);
        expect(val('1'), error);
        expect(val('247'), error);
        expect(val('24689'), error);
      });
      testWidgets('range ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(HexField.range(1, 5, validator: noOddHexs));
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
        final val = await getVal(HexField(
          blank: blank,
          malformed: nonHex,
          validator: nok.call,
        ));
        expect(val(null), blank);
        expect(val(empty), blank);
        expect(val('1X'), nonHex);
        expect(val('9'), error);
        expect(val('111'), error);
      });
      testWidgets('len ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(HexField.len(
          2,
          blank: blank,
          malformed: nonHex,
          validator: nok.call,
        ));
        expect(val(null), blank);
        expect(val(empty), blank);
        expect(val('G1'), nonHex);
        expect(val('11'), error);
        expect(val('99'), error);
      });
      testWidgets('min ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(HexField.min(
          3,
          blank: blank,
          malformed: nonHex,
          short: short,
          validator: nok.call,
        ));
        expect(val(null), blank);
        expect(val(empty), blank);
        expect(val('1.1'), nonHex);
        expect(val('55'), short);
        expect(val('123'), error);
        expect(val('222'), error);
      });
      testWidgets('max ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(HexField.max(
          3,
          blank: blank,
          malformed: nonHex,
          long: long,
          validator: nok.call,
        ));
        expect(val(null), blank);
        expect(val(empty), blank);
        expect(val('+55'), nonHex);
        expect(val('5555'), long);
        expect(val('9'), error);
        expect(val('11'), error);
        expect(val('246'), error);
      });
      testWidgets('range ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(HexField.range(
          2,
          4,
          blank: blank,
          malformed: nonHex,
          short: short,
          long: long,
          validator: nok.call,
        ));
        expect(val(null), blank);
        expect(val(empty), blank);
        expect(val('-55'), nonHex);
        expect(val('9'), short);
        expect(val('99999'), long);
        expect(val('111'), error);
      });
    });
    group('malformed', () {
      Future<void> testDig(WidgetTester tester, HexField dig, List<String> good,
          List<String> bad) async {
        final getVal = GetVal(tester);
        final val = await getVal(dig);
        for (final ok in good) {
          expect(val(ok), null);
        }
        for (final nok in bad) {
          expect(val(nok), nonHex);
        }
      }

      testWidgets('default ctor', (WidgetTester tester) async {
        await testDig(
          tester,
          HexField(malformed: nonHex),
          ['1F5', 'CAFEBABE', 'cafebabe'],
          [empty, 'x', '0.0', '12345X', '?', '9!'],
        );
      });
      testWidgets('len ctor', (WidgetTester tester) async {
        await testDig(
          tester,
          HexField.len(3, malformed: nonHex),
          ['999', '123', 'AAA'],
          [empty, '12H', '0.0', '12X', '???', '9!9'],
        );
      });
      testWidgets('min ctor', (WidgetTester tester) async {
        await testDig(
          tester,
          HexField.min(1, malformed: nonHex),
          ['a', '12345', 'F'],
          [empty, '-B', '0.0', '23X45', '&', '+9A'],
        );
      });
      testWidgets('max ctor', (WidgetTester tester) async {
        await testDig(
          tester,
          HexField.max(10, malformed: nonHex),
          ['FEFE', '12345', '00000000'],
          [empty, '-5', '1.0', '12X456', '1,2', '9!'],
        );
      });
      testWidgets('range ctor', (WidgetTester tester) async {
        await testDig(
          tester,
          HexField.range(1, 16, malformed: nonHex),
          ['0', '12345', '0123456789ABCDEF', 'abcedf'],
          [empty, 'W', '+1', '-1', '?', '9!'],
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
          HexField(key: kDef, trim: true, onChanged: onChanged),
        ]));
        await tester.pumpAndSettle();
        final before = count;
        await tester.enterText(find.byKey(kDef), untrimmed);
        await tester.pumpAndSettle();
        expect(count, before + 1);
      });
      testWidgets('len ctor', (WidgetTester tester) async {
        await tester.pumpWidget(WellFormed.app([
          HexField.len(10, key: kLen, trim: true, onChanged: onChanged),
        ]));
        await tester.pumpAndSettle();
        final before = count;
        await tester.enterText(find.byKey(kLen), untrimmed);
        await tester.pumpAndSettle();
        expect(count, before + 1);
      });
      testWidgets('min ctor', (WidgetTester tester) async {
        await tester.pumpWidget(WellFormed.app([
          HexField.min(10, key: kMin, trim: true, onChanged: onChanged),
        ]));
        await tester.pumpAndSettle();
        final before = count;
        await tester.enterText(find.byKey(kMin), untrimmed);
        await tester.pumpAndSettle();
        expect(count, before + 1);
      });
      testWidgets('max ctor', (WidgetTester tester) async {
        await tester.pumpWidget(WellFormed.app([
          HexField.max(10, key: kMax, trim: true, onChanged: onChanged),
        ]));
        await tester.pumpAndSettle();
        final before = count;
        await tester.enterText(find.byKey(kMax), untrimmed);
        await tester.pumpAndSettle();
        expect(count, before + 1);
      });
      testWidgets('range ctor', (WidgetTester tester) async {
        await tester.pumpWidget(WellFormed.app([
          HexField.range(8, 12, key: kRange, trim: true, onChanged: onChanged),
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
          WellFormed.app([HexField(onSaved: onSaved)]),
        );
        final elem = tester.widget(find.byType(TextFormField));
        expect((elem as TextFormField).onSaved, onSaved);
      });
      testWidgets('len ctor', (WidgetTester tester) async {
        await tester.pumpWidget(
          WellFormed.app([HexField.len(5, onSaved: onSaved)]),
        );
        final elem = tester.widget(find.byType(TextFormField));
        expect((elem as TextFormField).onSaved, onSaved);
      });
      testWidgets('min ctor', (WidgetTester tester) async {
        await tester.pumpWidget(
          WellFormed.app([HexField.min(5, onSaved: onSaved)]),
        );
        final elem = tester.widget(find.byType(TextFormField));
        expect((elem as TextFormField).onSaved, onSaved);
      });
      testWidgets('max ctor', (WidgetTester tester) async {
        await tester.pumpWidget(
          WellFormed.app([HexField.max(5, onSaved: onSaved)]),
        );
        final elem = tester.widget(find.byType(TextFormField));
        expect((elem as TextFormField).onSaved, onSaved);
      });
      testWidgets('range ctor', (WidgetTester tester) async {
        await tester.pumpWidget(
          WellFormed.app([HexField.range(5, 10, onSaved: onSaved)]),
        );
        final elem = tester.widget(find.byType(TextFormField));
        expect((elem as TextFormField).onSaved, onSaved);
      });
    });
    testWidgets('onEditingComplete', (WidgetTester tester) async {
      void onEdit() {}

      await tester.pumpWidget(
        WellFormed.app([
          HexField(onEditingComplete: onEdit),
          HexField.len(23, onEditingComplete: onEdit),
          HexField.min(23, onEditingComplete: onEdit),
          HexField.max(23, onEditingComplete: onEdit),
          HexField.range(15, 25, onEditingComplete: onEdit),
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
          HexField(onFieldSubmitted: onSubmit),
          HexField.len(23, onFieldSubmitted: onSubmit),
          HexField.min(23, onFieldSubmitted: onSubmit),
          HexField.max(23, onFieldSubmitted: onSubmit),
          HexField.range(15, 25, onFieldSubmitted: onSubmit),
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
          HexField(controller: TextEditingController(text: init)),
          HexField.len(23, controller: TextEditingController(text: initLen)),
          HexField.min(23, controller: TextEditingController(text: initMin)),
          HexField.max(23, controller: TextEditingController(text: initMax)),
          HexField.range(
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
          HexField(initialValue: init),
          HexField.len(23, initialValue: initLen),
          HexField.min(23, initialValue: initMin),
          HexField.max(23, initialValue: initMax),
          HexField.range(15, 25, initialValue: initRange)
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
          HexField(
            decoration: const InputDecoration(labelText: label),
          ),
          HexField.len(
            23,
            decoration: const InputDecoration(labelText: labelLen),
          ),
          HexField.min(
            23,
            decoration: const InputDecoration(labelText: labelMin),
          ),
          HexField.max(
            23,
            decoration: const InputDecoration(labelText: labelMax),
          ),
          HexField.range(
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
          HexField(textInputAction: action),
          HexField.len(23, textInputAction: actionLen),
          HexField.min(23, textInputAction: actionMin),
          HexField.max(23, textInputAction: actionMax),
          HexField.range(15, 25, textInputAction: actionRange),
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
          HexField(style: style),
          HexField.len(23, style: style),
          HexField.min(23, style: style),
          HexField.max(23, style: style),
          HexField.range(15, 25, style: style),
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
          HexField(textDirection: textDirection),
          HexField.len(23, textDirection: textDirection),
          HexField.min(23, textDirection: textDirection),
          HexField.max(23, textDirection: textDirection),
          HexField.range(15, 25, textDirection: textDirection),
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
          HexField(textAlign: textAlign),
          HexField.len(23, textAlign: textAlign),
          HexField.min(23, textAlign: textAlign),
          HexField.max(23, textAlign: textAlign),
          HexField.range(15, 25, textAlign: textAlign),
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
          HexField(readOnly: readOnly),
          HexField.len(23, readOnly: readOnly),
          HexField.min(23, readOnly: readOnly),
          HexField.max(23, readOnly: readOnly),
          HexField.range(15, 25, readOnly: readOnly),
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
          HexField(obscureText: obscureText),
          HexField.len(23, obscureText: obscureText),
          HexField.min(23, obscureText: obscureText),
          HexField.max(23, obscureText: obscureText),
          HexField.range(15, 25, obscureText: obscureText),
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
          HexField(autocorrect: autocorrect),
          HexField.len(23, autocorrect: autocorrect),
          HexField.min(23, autocorrect: autocorrect),
          HexField.max(23, autocorrect: autocorrect),
          HexField.range(15, 25, autocorrect: autocorrect),
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
          HexField(obscuringCharacter: obscuringCharacter),
          HexField.len(23, obscuringCharacter: obscuringCharacter),
          HexField.min(23, obscuringCharacter: obscuringCharacter),
          HexField.max(23, obscuringCharacter: obscuringCharacter),
          HexField.range(15, 25, obscuringCharacter: obscuringCharacter),
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
          HexField(maxLength: maxLength),
          HexField.len(23, maxLength: maxLength),
          HexField.min(23, maxLength: maxLength),
          HexField.max(23, maxLength: maxLength),
          HexField.range(15, 25, maxLength: maxLength),
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
          HexField(),
          HexField.len(23),
          HexField.min(23),
          HexField.max(23),
          HexField.range(15, 25),
        ]),
      );
      await tester.pumpAndSettle();
      final elems = tester.widgetList(find.byType(TextField));
      for (final elem in elems) {
        expect((elem as TextField).keyboardType, TextInputType.text);
      }
    });
    testWidgets('default inputFormatters', (WidgetTester tester) async {
      await tester.pumpWidget(
        WellFormed.app([
          HexField(key: kDef),
          HexField.len(23, key: kLen),
          HexField.min(23, key: kMin),
          HexField.max(23, key: kMax),
          HexField.range(15, 25, key: kRange),
        ]),
      );
      await tester.pumpAndSettle();
      for (var i = 0; i < keys.length; ++i) {
        final unmasked = '$i$i$i$i$i$i$i$i$i$i$i'; // E.g. 11111111111
        final masked = '$i$i$i.$i$i$i.$i$i$i-$i$i'; // E.g. 111.111.111-11
        await tester.enterText(find.byKey(keys[i]), masked);
        await tester.pumpAndSettle();
        expect(find.text(unmasked), findsOneWidget);
      }
    });
    testWidgets('enabled', (WidgetTester tester) async {
      const enabled = false;
      await tester.pumpWidget(
        WellFormed.app([
          HexField(enabled: enabled),
          HexField.len(23, enabled: enabled),
          HexField.min(23, enabled: enabled),
          HexField.max(23, enabled: enabled),
          HexField.range(15, 25, enabled: enabled),
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
          HexField(scrollPadding: scrollPadding),
          HexField.len(23, scrollPadding: scrollPadding),
          HexField.min(23, scrollPadding: scrollPadding),
          HexField.max(23, scrollPadding: scrollPadding),
          HexField.range(15, 25, scrollPadding: scrollPadding),
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
          HexField(enableInteractiveSelection: enableInteractiveSelection),
          HexField.len(23,
              enableInteractiveSelection: enableInteractiveSelection),
          HexField.min(23,
              enableInteractiveSelection: enableInteractiveSelection),
          HexField.max(23,
              enableInteractiveSelection: enableInteractiveSelection),
          HexField.range(15, 25,
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
          HexField(autovalidateMode: autovalidateMode),
          HexField.len(23, autovalidateMode: autovalidateMode),
          HexField.min(23, autovalidateMode: autovalidateMode),
          HexField.max(23, autovalidateMode: autovalidateMode),
          HexField.range(15, 25, autovalidateMode: autovalidateMode),
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
