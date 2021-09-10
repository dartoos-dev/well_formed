import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formdator/formdator.dart';
import 'package:well_formed/src/core/well_formed.dart';
import 'package:well_formed/src/numeric/int_field.dart';

import '../get_val.dart';

// ignore_for_file: require_trailing_commas
Future<void> main() async {
  group('IntField', () {
    const empty = ''; // zero-length text.
    const zero = '0';
    const one = '1';
    const ten = '10';
    const oneBillion = '1000000000';
    const minusOne = '-1';
    const minusTen = '-10';
    const minusOneBillion = '-1000000000';
    const nonDigit = 'Error: non-digit character(s)';
    const blank = 'Error: this field is required';
    const small = 'Error: the number is too small';
    const large = 'Error: the number is too long';
    const kDef = Key('()');
    const kMin = Key('min');
    const kPos = Key('pos');
    const kMax = Key('max');
    const kNeg = Key('neg');
    const kRange = Key('range');
    const keys = <Key>[kDef, kMin, kPos, kMax, kNeg, kRange];
    const init = '0';
    const initMin = '1';
    const initPos = '2';
    const initMax = '5';
    const initNeg = '-1';
    const initRange = '10';
    const inits = [init, initMin, initPos, initMax, initNeg, initRange];
    group('value constraints', () {
      testWidgets('minimum', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(
          IntField.min(10, malformed: nonDigit, small: small),
        );
        expect(val(null), null);
        expect(val(empty), nonDigit);
        expect(val(minusOneBillion), small);
        expect(val(minusTen), small);
        expect(val(minusOne), small);
        expect(val(zero), small);
        expect(val(one), small);
        expect(val(ten), null);
        expect(val(oneBillion), null);
      });
      testWidgets('positive', (WidgetTester tester) async {
        const neg = 'positive numbers only';
        final getVal = GetVal(tester);
        final val = await getVal(
          IntField.pos(malformed: nonDigit, neg: neg),
        );
        expect(val(null), null);
        expect(val(empty), nonDigit);
        expect(val(minusOneBillion), neg);
        expect(val(minusTen), neg);
        expect(val(minusOne), neg);
        expect(val(zero), null);
        expect(val(one), null);
        expect(val(ten), null);
        expect(val(oneBillion), null);
      });
      testWidgets('maximum', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(
          IntField.max(10, malformed: nonDigit, large: large),
        );
        expect(val(null), null);
        expect(val(empty), nonDigit);
        expect(val(minusOneBillion), null);
        expect(val(minusTen), null);
        expect(val(minusOne), null);
        expect(val(zero), null);
        expect(val(one), null);
        expect(val(ten), null);
        expect(val(oneBillion), large);
      });
      testWidgets('negative', (WidgetTester tester) async {
        const pos = 'negative numbers only';
        final getVal = GetVal(tester);
        final val = await getVal(
          IntField.neg(malformed: nonDigit, pos: pos),
        );
        expect(val(null), null);
        expect(val(empty), nonDigit);
        expect(val(minusOneBillion), null);
        expect(val(minusTen), null);
        expect(val(minusOne), null);
        expect(val(zero), pos);
        expect(val(one), pos);
        expect(val(ten), pos);
        expect(val(oneBillion), pos);
      });
      testWidgets('range', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(
          IntField.range(-5, 5,
              malformed: nonDigit, small: small, large: large),
        );
        expect(val(null), null);
        expect(val(empty), nonDigit);
        expect(val(minusOneBillion), small);
        expect(val(minusTen), small);
        expect(val(minusOne), null);
        expect(val(zero), null);
        expect(val(one), null);
        expect(val(ten), large);
        expect(val(oneBillion), large);
      });
    });
    group('key', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        await tester.pumpWidget(WellFormed.app([IntField(key: kDef)]));
        expect(find.byKey(kDef), findsOneWidget);
      });
      testWidgets('min ctor', (WidgetTester tester) async {
        await tester.pumpWidget(WellFormed.app([IntField.min(1, key: kMin)]));
        expect(find.byKey(kMin), findsOneWidget);
      });
      testWidgets('pos ctor', (WidgetTester tester) async {
        await tester.pumpWidget(WellFormed.app([IntField.pos(key: kPos)]));
        expect(find.byKey(kPos), findsOneWidget);
      });
      testWidgets('max ctor', (WidgetTester tester) async {
        await tester.pumpWidget(WellFormed.app([IntField.max(1, key: kMax)]));
        expect(find.byKey(kMax), findsOneWidget);
      });
      testWidgets('neg ctor', (WidgetTester tester) async {
        await tester.pumpWidget(WellFormed.app([IntField.neg(key: kNeg)]));
        expect(find.byKey(kNeg), findsOneWidget);
      });
      testWidgets('range ctor', (WidgetTester tester) async {
        await tester.pumpWidget(
          WellFormed.app([IntField.range(1, 2, key: kRange)]),
        );
        expect(find.byKey(kRange), findsOneWidget);
      });
    });
    group('blank', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(IntField(blank: blank));
        expect(val(null), blank);
        expect(val(init), null);
      });
      testWidgets('min ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(IntField.min(0, blank: blank));
        expect(val(null), blank);
        expect(val('0'), null);
      });
      testWidgets('pos ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(IntField.pos(blank: blank));
        expect(val(null), blank);
        expect(val('0'), null);
      });
      testWidgets('max ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(IntField.max(15, blank: blank));
        expect(val(null), blank);
        expect(val('10'), null);
      });
      testWidgets('neg ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(IntField.neg(blank: blank));
        expect(val(null), blank);
        expect(val('-1'), null);
      });
      testWidgets('range ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(IntField.range(1, 15, blank: blank));
        expect(val(null), blank);
        expect(val('10'), null);
      });
    });
    group('validator', () {
      const error = 'cannot have odd digits';

      /// Input value cannot be an odd number.
      String? noOddDigits(String? v) =>
          (v != null && v.contains(RegExp('[-+]?[13579]+'))) ? error : null;

      testWidgets('default ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(IntField(validator: noOddDigits));
        expect(val(null), null);
        expect(val('246'), null);
        expect(val('+2'), null);
        expect(val('-2'), null);
        expect(val('7'), error);
        expect(val('111'), error);
        expect(val('13888'), error);
        expect(val('23889'), error);
      });

      testWidgets('min ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(IntField.min(-100, validator: noOddDigits));
        expect(val(null), null);
        expect(val('-88'), null);
        expect(val('-46'), null);
        expect(val('-2'), null);
        expect(val('+2'), null);
        expect(val('24680'), null);
        expect(val('-7'), error);
        expect(val('7'), error);
        expect(val('111'), error);
        expect(val('13888'), error);
        expect(val('23889'), error);
      });
      testWidgets('pos ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(IntField.pos(validator: noOddDigits));
        expect(val(null), null);
        expect(val('0'), null);
        expect(val('+2'), null);
        expect(val('24680'), null);
        expect(val('111'), error);
        expect(val('13888'), error);
        expect(val('23889'), error);
      });
      testWidgets('max ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(IntField.max(1000000, validator: noOddDigits));
        expect(val(null), null);
        expect(val('-88'), null);
        expect(val('-46'), null);
        expect(val('-2'), null);
        expect(val('+2'), null);
        expect(val('66'), null);
        expect(val('-7'), error);
        expect(val('7'), error);
        expect(val('111'), error);
        expect(val('13888'), error);
        expect(val('23889'), error);
      });
      testWidgets('neg ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(IntField.neg(validator: noOddDigits));
        expect(val(null), null);
        expect(val('-88'), null);
        expect(val('-46'), null);
        expect(val('-2'), null);
        expect(val('-7'), error);
        expect(val('-111'), error);
        expect(val('-13888'), error);
        expect(val('-23889'), error);
      });
      testWidgets('range ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val =
            await getVal(IntField.range(-200, 200, validator: noOddDigits));
        expect(val(null), null);
        expect(val('-88'), null);
        expect(val('-46'), null);
        expect(val('-2'), null);
        expect(val('+2'), null);
        expect(val('0'), null);
        expect(val('200'), null);
        expect(val('1'), error);
        expect(val('-7'), error);
        expect(val('7'), error);
        expect(val('11'), error);
        expect(val('99'), error);
      });
    });
    group('blank and validator', () {
      const error = 'it must always be invalid';
      const nok = Nok(error: error);

      testWidgets('default ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(IntField(blank: blank, validator: nok));
        expect(val(null), blank);
        expect(val(empty), blank);
        expect(val(zero), error);
        expect(val(ten), error);
        expect(val(oneBillion), error);
      });

      testWidgets('min ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(IntField.min(1, blank: blank, validator: nok));
        expect(val(null), blank);
        expect(val(empty), blank);
        expect(val(ten), error);
        expect(val(oneBillion), error);
      });

      testWidgets('pos ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(IntField.pos(blank: blank, validator: nok));
        expect(val(null), blank);
        expect(val(empty), blank);
        expect(val(zero), error);
        expect(val(ten), error);
        expect(val(oneBillion), error);
      });

      testWidgets('max ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val =
            await getVal(IntField.max(100, blank: blank, validator: nok));
        expect(val(null), blank);
        expect(val(empty), blank);
        expect(val(minusTen), error);
        expect(val(zero), error);
        expect(val(ten), error);
      });

      testWidgets('neg ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(IntField.neg(blank: blank, validator: nok));
        expect(val(null), blank);
        expect(val(empty), blank);
        expect(val(minusOneBillion), error);
        expect(val(minusTen), error);
        expect(val(minusOne), error);
      });

      testWidgets('range ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(
            IntField.range(-100, 100, blank: blank, validator: nok));
        expect(val(null), blank);
        expect(val(empty), blank);
        expect(val(minusTen), error);
        expect(val(minusOne), error);
        expect(val(one), error);
        expect(val(ten), error);
      });
    });
    testWidgets('malformed', (WidgetTester tester) async {
      Future<void> testIntField(
        IntField intField,
        List<String> good,
        List<String> bad,
      ) async {
        await tester.pumpWidget(WellFormed.app([intField]));
        final getVal = GetVal(tester);
        final val = await getVal(intField);
        for (final ok in good) {
          expect(val(ok), null);
        }
        for (final nok in bad) {
          expect(val(nok), nonDigit);
        }
      }

      await testIntField(
        IntField(malformed: nonDigit),
        [minusOneBillion, minusTen, minusOne, zero, one, ten, oneBillion],
        [empty, 'a', '0.0', '0.9999', '1.0001', '1,1', '12345X', '?', '9!'],
      );
      await testIntField(
        IntField.min(-100, malformed: nonDigit),
        [one, ten, oneBillion],
        [empty, 'a', '0.0', 'X2345', '&', '9A'],
      );
      await testIntField(
        IntField.pos(malformed: nonDigit),
        [one, ten, oneBillion],
        [empty, 'aaa', '0.0', '12X', '???', '9!9'],
      );
      await testIntField(
        IntField.max(100, malformed: nonDigit),
        [zero, one, ten],
        [empty, 'a', '1.0', '12X456', '1,2', '9!'],
      );
      await testIntField(
        IntField.neg(malformed: nonDigit),
        [minusOne, minusTen, minusOneBillion],
        [empty, 'aaa', '-1.0', '12X', '???', '9!9'],
      );
      await testIntField(
        IntField.range(-100, 100, malformed: nonDigit),
        [minusTen, minusOne, zero, one, ten],
        [empty, 'a', '+1.0', '-1,0', '?', '9!'],
      );
    });
    testWidgets('trim and onChanged', (WidgetTester tester) async {
      const trimmed = '55';
      const untrimmed = '\n $trimmed \t';
      var count = 0;
      void onChanged(String s) {
        if (s.contains(RegExp('^$trimmed\$'))) {
          ++count;
        }
      }

      await tester.pumpWidget(WellFormed.app([
        IntField(key: kDef, trim: true, onChanged: onChanged),
        IntField.min(1, key: kMin, trim: true, onChanged: onChanged),
        IntField.pos(key: kPos, trim: true, onChanged: onChanged),
        IntField.max(100, key: kMax, trim: true, onChanged: onChanged),
        IntField.neg(key: kNeg, trim: true, onChanged: onChanged),
        IntField.range(1, 100, key: kRange, trim: true, onChanged: onChanged)
      ]));
      for (final key in keys) {
        final before = count;
        await tester.enterText(find.byKey(key), untrimmed);
        await tester.pumpAndSettle();
        expect(count, before + 1);
      }
    });
    testWidgets('controller', (WidgetTester tester) async {
      await tester.pumpWidget(
        WellFormed.app([
          IntField(controller: TextEditingController(text: init)),
          IntField.min(1, controller: TextEditingController(text: initMin)),
          IntField.pos(controller: TextEditingController(text: initPos)),
          IntField.max(100, controller: TextEditingController(text: initMax)),
          IntField.neg(controller: TextEditingController(text: initNeg)),
          IntField.range(
            5,
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
          IntField(initialValue: init),
          IntField.min(1, initialValue: initMin),
          IntField.pos(initialValue: initPos),
          IntField.max(100, initialValue: initMax),
          IntField.neg(initialValue: initNeg),
          IntField.range(5, 25, initialValue: initRange)
        ]),
      );
      await tester.pumpAndSettle();
      for (final init in inits) {
        expect(find.text(init), findsOneWidget);
      }
    });
    testWidgets('decoration', (WidgetTester tester) async {
      const l = 'default';
      const lMin = 'min';
      const lPos = 'pos';
      const lMax = 'max';
      const lNeg = 'neg';
      const lRange = 'range';
      const labels = <String>[l, lMin, lPos, lMax, lNeg, lRange];
      await tester.pumpWidget(
        WellFormed.app([
          IntField(decoration: const InputDecoration(labelText: l)),
          IntField.min(1, decoration: const InputDecoration(labelText: lMin)),
          IntField.pos(decoration: const InputDecoration(labelText: lPos)),
          IntField.max(10, decoration: const InputDecoration(labelText: lMax)),
          IntField.neg(decoration: const InputDecoration(labelText: lNeg)),
          IntField.range(
            5,
            25,
            decoration: const InputDecoration(labelText: lRange),
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
      const actionMin = TextInputAction.join;
      const actionPos = TextInputAction.go;
      const actionMax = TextInputAction.previous;
      const actionNeg = TextInputAction.done;
      const actionRange = TextInputAction.search;
      const actions = [
        action,
        actionMin,
        actionPos,
        actionMax,
        actionNeg,
        actionRange
      ];
      await tester.pumpWidget(
        WellFormed.app([
          IntField(textInputAction: action),
          IntField.min(1, textInputAction: actionMin),
          IntField.pos(textInputAction: actionPos),
          IntField.max(10, textInputAction: actionMax),
          IntField.neg(textInputAction: actionNeg),
          IntField.range(5, 25, textInputAction: actionRange),
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
          IntField(style: style),
          IntField.min(1, style: style),
          IntField.pos(style: style),
          IntField.max(10, style: style),
          IntField.neg(style: style),
          IntField.range(5, 25, style: style),
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
          IntField(textDirection: textDirection),
          IntField.min(1, textDirection: textDirection),
          IntField.pos(textDirection: textDirection),
          IntField.max(10, textDirection: textDirection),
          IntField.neg(textDirection: textDirection),
          IntField.range(5, 25, textDirection: textDirection),
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
          IntField(textAlign: textAlign),
          IntField.min(1, textAlign: textAlign),
          IntField.pos(textAlign: textAlign),
          IntField.max(10, textAlign: textAlign),
          IntField.neg(textAlign: textAlign),
          IntField.range(5, 25, textAlign: textAlign),
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
          IntField(readOnly: readOnly),
          IntField.min(1, readOnly: readOnly),
          IntField.pos(readOnly: readOnly),
          IntField.max(10, readOnly: readOnly),
          IntField.neg(readOnly: readOnly),
          IntField.range(5, 25, readOnly: readOnly),
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
          IntField(obscureText: obscureText),
          IntField.min(1, obscureText: obscureText),
          IntField.pos(obscureText: obscureText),
          IntField.max(10, obscureText: obscureText),
          IntField.neg(obscureText: obscureText),
          IntField.range(5, 25, obscureText: obscureText),
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
          IntField(autocorrect: autocorrect),
          IntField.min(1, autocorrect: autocorrect),
          IntField.pos(autocorrect: autocorrect),
          IntField.max(10, autocorrect: autocorrect),
          IntField.neg(autocorrect: autocorrect),
          IntField.range(5, 25, autocorrect: autocorrect),
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
          IntField(obscuringCharacter: obscuringCharacter),
          IntField.min(1, obscuringCharacter: obscuringCharacter),
          IntField.pos(obscuringCharacter: obscuringCharacter),
          IntField.max(10, obscuringCharacter: obscuringCharacter),
          IntField.neg(obscuringCharacter: obscuringCharacter),
          IntField.range(5, 25, obscuringCharacter: obscuringCharacter),
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
          IntField(maxLength: maxLength),
          IntField.min(1, maxLength: maxLength),
          IntField.pos(maxLength: maxLength),
          IntField.max(10, maxLength: maxLength),
          IntField.neg(maxLength: maxLength),
          IntField.range(15, 25, maxLength: maxLength),
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
          IntField(),
          IntField.min(1),
          IntField.pos(),
          IntField.max(10),
          IntField.pos(),
          IntField.range(5, 25),
        ]),
      );
      await tester.pumpAndSettle();
      final elems = tester.widgetList(find.byType(TextField));
      for (final elem in elems) {
        expect(
          (elem as TextField).keyboardType,
          const TextInputType.numberWithOptions(signed: true),
        );
      }
    });
    testWidgets('onEditingComplete', (WidgetTester tester) async {
      void onEdit() {}

      await tester.pumpWidget(
        WellFormed.app([
          IntField(onEditingComplete: onEdit),
          IntField.min(1, onEditingComplete: onEdit),
          IntField.pos(onEditingComplete: onEdit),
          IntField.max(10, onEditingComplete: onEdit),
          IntField.neg(onEditingComplete: onEdit),
          IntField.range(5, 25, onEditingComplete: onEdit),
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
          IntField(onFieldSubmitted: onSubmit),
          IntField.min(1, onFieldSubmitted: onSubmit),
          IntField.pos(onFieldSubmitted: onSubmit),
          IntField.max(10, onFieldSubmitted: onSubmit),
          IntField.neg(onFieldSubmitted: onSubmit),
          IntField.range(15, 25, onFieldSubmitted: onSubmit),
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
          IntField(onSaved: onSaved),
          IntField.min(1, onSaved: onSaved),
          IntField.pos(onSaved: onSaved),
          IntField.max(10, onSaved: onSaved),
          IntField.pos(onSaved: onSaved),
          IntField.range(5, 25, onSaved: onSaved),
        ]),
      );
      await tester.pumpAndSettle();
      final elems = tester.widgetList(find.byType(TextFormField));
      for (final elem in elems) {
        expect((elem as TextFormField).onSaved, onSaved);
      }
    });

    /// The minus '-' and plus '+' signs must be accepted along with the digits
    /// 0–9.
    group('inputFormatters', () {
      group('no prefix', () {
        const masked = '12.34/5';
        const unmasked = '12345';
        testWidgets('default ctor', (WidgetTester tester) async {
          await tester.pumpWidget(WellFormed.app([IntField(key: kDef)]));
          await tester.enterText(find.byKey(kDef), masked);
          await tester.pumpAndSettle();
          expect(find.widgetWithText(TextFormField, unmasked), findsOneWidget);
        });
        testWidgets('min ctor', (WidgetTester tester) async {
          await tester.pumpWidget(WellFormed.app([IntField.min(1, key: kMin)]));
          await tester.enterText(find.byKey(kMin), masked);
          await tester.pumpAndSettle();
          expect(find.widgetWithText(TextFormField, unmasked), findsOneWidget);
        });
        testWidgets('pos ctor', (WidgetTester tester) async {
          await tester.pumpWidget(WellFormed.app([IntField.pos(key: kMin)]));
          await tester.enterText(find.byKey(kMin), masked);
          await tester.pumpAndSettle();
          expect(find.widgetWithText(TextFormField, unmasked), findsOneWidget);
        });
        testWidgets('max ctor', (WidgetTester tester) async {
          await tester
              .pumpWidget(WellFormed.app([IntField.max(99999, key: kMax)]));
          await tester.enterText(find.byKey(kMax), masked);
          await tester.pumpAndSettle();
          expect(find.widgetWithText(TextFormField, unmasked), findsOneWidget);
        });
        testWidgets('neg ctor', (WidgetTester tester) async {
          await tester.pumpWidget(WellFormed.app([IntField.neg(key: kMax)]));
          await tester.enterText(find.byKey(kMax), masked);
          await tester.pumpAndSettle();
          expect(find.widgetWithText(TextFormField, unmasked), findsOneWidget);
        });
        testWidgets('range ctor', (WidgetTester tester) async {
          await tester.pumpWidget(
            WellFormed.app([IntField.range(1, 99999, key: kRange)]),
          );
          await tester.enterText(find.byKey(kRange), masked);
          await tester.pumpAndSettle();
          expect(find.widgetWithText(TextFormField, unmasked), findsOneWidget);
        });
      });
      group('plus sign prefix', () {
        const masked = '+12.34/5';
        const unmasked = '+12345';
        const mod = '12345'; // modulus: no sign.

        testWidgets('default ctor', (WidgetTester tester) async {
          await tester.pumpWidget(WellFormed.app([IntField(key: kDef)]));
          await tester.enterText(find.byKey(kDef), masked);
          await tester.pumpAndSettle();
          expect(find.widgetWithText(TextFormField, unmasked), findsOneWidget);
        });
        testWidgets('min ctor', (WidgetTester tester) async {
          await tester.pumpWidget(WellFormed.app([IntField.min(1, key: kMin)]));
          await tester.enterText(find.byKey(kMin), masked);
          await tester.pumpAndSettle();
          expect(find.widgetWithText(TextFormField, unmasked), findsOneWidget);
        });
        testWidgets('pos ctor', (WidgetTester tester) async {
          await tester.pumpWidget(WellFormed.app([IntField.pos(key: kMin)]));
          await tester.enterText(find.byKey(kMin), masked);
          await tester.pumpAndSettle();
          expect(find.widgetWithText(TextFormField, unmasked), findsOneWidget);
        });
        testWidgets('max ctor', (WidgetTester tester) async {
          await tester
              .pumpWidget(WellFormed.app([IntField.max(99999, key: kMax)]));
          await tester.enterText(find.byKey(kMax), masked);
          await tester.pumpAndSettle();
          expect(find.widgetWithText(TextFormField, unmasked), findsOneWidget);
        });
        testWidgets('neg ctor', (WidgetTester tester) async {
          await tester.pumpWidget(WellFormed.app([IntField.neg(key: kMin)]));
          await tester.enterText(find.byKey(kMin), masked);
          await tester.pumpAndSettle();
          expect(find.widgetWithText(TextFormField, mod), findsOneWidget);
        });
        testWidgets('range ctor', (WidgetTester tester) async {
          await tester.pumpWidget(
            WellFormed.app([IntField.range(1, 99999, key: kRange)]),
          );
          await tester.enterText(find.byKey(kRange), masked);
          await tester.pumpAndSettle();
          expect(find.widgetWithText(TextFormField, unmasked), findsOneWidget);
        });
      });
      group('minus sign prefix', () {
        const masked = '-12.34/5';
        const unmasked = '-12345';
        const mod = '12345';

        testWidgets('default ctor', (WidgetTester tester) async {
          await tester.pumpWidget(WellFormed.app([IntField(key: kDef)]));
          await tester.enterText(find.byKey(kDef), masked);
          await tester.pumpAndSettle();
          expect(find.widgetWithText(TextFormField, unmasked), findsOneWidget);
        });
        testWidgets('min ctor', (WidgetTester tester) async {
          await tester
              .pumpWidget(WellFormed.app([IntField.min(-99999, key: kMin)]));
          await tester.enterText(find.byKey(kMin), masked);
          await tester.pumpAndSettle();
          expect(find.widgetWithText(TextFormField, unmasked), findsOneWidget);
        });

        /// Must get rid of the minus '-' sign.
        testWidgets('pos ctor', (WidgetTester tester) async {
          await tester.pumpWidget(WellFormed.app([IntField.pos(key: kMin)]));
          await tester.enterText(find.byKey(kMin), masked);
          await tester.pumpAndSettle();
          expect(find.widgetWithText(TextFormField, mod), findsOneWidget);
        });
        testWidgets('max ctor', (WidgetTester tester) async {
          await tester
              .pumpWidget(WellFormed.app([IntField.max(99999, key: kMax)]));
          await tester.enterText(find.byKey(kMax), masked);
          await tester.pumpAndSettle();
          expect(find.widgetWithText(TextFormField, unmasked), findsOneWidget);
        });
        testWidgets('range ctor', (WidgetTester tester) async {
          await tester.pumpWidget(
            WellFormed.app([IntField.range(1, 99999, key: kRange)]),
          );
          await tester.enterText(find.byKey(kRange), masked);
          await tester.pumpAndSettle();
          expect(find.widgetWithText(TextFormField, unmasked), findsOneWidget);
        });
      });
    });
    testWidgets('enabled', (WidgetTester tester) async {
      const enabled = false;
      await tester.pumpWidget(
        WellFormed.app([
          IntField(enabled: enabled),
          IntField.min(1, enabled: enabled),
          IntField.pos(enabled: enabled),
          IntField.max(10, enabled: enabled),
          IntField.neg(enabled: enabled),
          IntField.range(5, 25, enabled: enabled),
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
          IntField(scrollPadding: scrollPadding),
          IntField.min(1, scrollPadding: scrollPadding),
          IntField.pos(scrollPadding: scrollPadding),
          IntField.max(10, scrollPadding: scrollPadding),
          IntField.neg(scrollPadding: scrollPadding),
          IntField.range(5, 25, scrollPadding: scrollPadding),
        ]),
      );
      await tester.pumpAndSettle();
      final elems = tester.widgetList(find.byType(TextField));
      for (final elem in elems) {
        expect((elem as TextField).scrollPadding, scrollPadding);
      }
    });
    testWidgets('enableInteraciveSelection', (WidgetTester tester) async {
      const enable = false;
      await tester.pumpWidget(
        WellFormed.app([
          IntField(enableInteractiveSelection: enable),
          IntField.min(1, enableInteractiveSelection: enable),
          IntField.pos(enableInteractiveSelection: enable),
          IntField.max(10, enableInteractiveSelection: enable),
          IntField.neg(enableInteractiveSelection: enable),
          IntField.range(15, 25, enableInteractiveSelection: enable),
        ]),
      );
      await tester.pumpAndSettle();
      final elems = tester.widgetList(find.byType(TextField));
      for (final elem in elems) {
        expect((elem as TextField).enableInteractiveSelection, enable);
      }
    });
    testWidgets('autoValidateMode', (WidgetTester tester) async {
      const autovalidateMode = AutovalidateMode.onUserInteraction;
      await tester.pumpWidget(
        WellFormed.app([
          IntField(autovalidateMode: autovalidateMode),
          IntField.min(1, autovalidateMode: autovalidateMode),
          IntField.pos(autovalidateMode: autovalidateMode),
          IntField.max(10, autovalidateMode: autovalidateMode),
          IntField.neg(autovalidateMode: autovalidateMode),
          IntField.range(5, 25, autovalidateMode: autovalidateMode),
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
