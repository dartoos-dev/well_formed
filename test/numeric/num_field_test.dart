import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formdator/formdator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:well_formed/src/core/well_formed.dart';
import 'package:well_formed/src/numeric/num_field.dart';

import '../get_val.dart';

// ignore_for_file: require_trailing_commas
Future<void> main() async {
  group('NumField', () {
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
    const initMin = '1.01';
    const initPos = '1.99';
    const initMax = '5.1';
    const initNeg = '-1.11';
    const initRange = '10';
    const inits = [init, initMin, initPos, initMax, initNeg, initRange];
    group('number constraints', () {
      testWidgets('mininum', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(
            NumField.min(9.9999, malformed: nonDigit, small: small));
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
        final val = await getVal(NumField.pos(malformed: nonDigit, neg: neg));
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
        final val =
            await getVal(NumField.max(10.1, malformed: nonDigit, large: large));
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
        final val = await getVal(NumField.neg(malformed: nonDigit, pos: pos));
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
          NumField.range(-5, 5,
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
        await tester.pumpWidget(WellFormed.app([NumField(key: kDef)]));
        expect(find.byKey(kDef), findsOneWidget);
      });
      testWidgets('min ctor', (WidgetTester tester) async {
        await tester.pumpWidget(WellFormed.app([NumField.min(1, key: kMin)]));
        expect(find.byKey(kMin), findsOneWidget);
      });
      testWidgets('pos ctor', (WidgetTester tester) async {
        await tester.pumpWidget(WellFormed.app([NumField.pos(key: kPos)]));
        expect(find.byKey(kPos), findsOneWidget);
      });
      testWidgets('max ctor', (WidgetTester tester) async {
        await tester.pumpWidget(WellFormed.app([NumField(key: kMax)]));
        expect(find.byKey(kMax), findsOneWidget);
      });
      testWidgets('neg ctor', (WidgetTester tester) async {
        await tester.pumpWidget(WellFormed.app([NumField.neg(key: kNeg)]));
        expect(find.byKey(kNeg), findsOneWidget);
      });
      testWidgets('range ctor', (WidgetTester tester) async {
        await tester
            .pumpWidget(WellFormed.app([NumField.range(1, 5, key: kRange)]));
        expect(find.byKey(kRange), findsOneWidget);
      });
    });
    group('blank', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(NumField(blank: blank));
        expect(val(null), blank);
        expect(val('0.0'), null);
      });
      testWidgets('min ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(NumField.min(1.0, blank: blank));
        expect(val(null), blank);
        expect(val('1.1'), null);
      });
      testWidgets('pos ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(NumField.pos(blank: blank));
        expect(val(null), blank);
        expect(val('0.0'), null);
      });
      testWidgets('max ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(NumField.max(1.0, blank: blank));
        expect(val(null), blank);
        expect(val('0.99'), null);
      });
      testWidgets('neg ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(NumField(key: kDef, blank: blank));
        expect(val(null), blank);
        expect(val('-0.001'), null);
      });
      testWidgets('range ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val =
            await getVal(NumField.range(-5, 5, key: kDef, blank: blank));
        expect(val(null), blank);
        expect(val('-4.99'), null);
        expect(val('+4.99'), null);
      });
    });
    group('validator', () {
      const error = 'cannot have odd digits';

      /// Input value cannot be an odd number.
      String? noOddDigits(String? v) =>
          (v != null && v.contains(RegExp('[-+]?[13579]+'))) ? error : null;

      testWidgets('default ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(NumField(validator: noOddDigits));
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
        final val = await getVal(NumField.min(-100, validator: noOddDigits));
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
        final val = await getVal(NumField.pos(validator: noOddDigits));
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
        final val = await getVal(NumField.max(1000000, validator: noOddDigits));
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
        final val = await getVal(NumField.neg(validator: noOddDigits));
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
            await getVal(NumField.range(-200, 200, validator: noOddDigits));
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
        final val = await getVal(NumField(blank: blank, validator: nok));
        expect(val(null), blank);
        expect(val(empty), blank);
        expect(val(zero), error);
        expect(val(ten), error);
        expect(val(oneBillion), error);
      });

      testWidgets('min ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(NumField.min(1, blank: blank, validator: nok));
        expect(val(null), blank);
        expect(val(empty), blank);
        expect(val(ten), error);
        expect(val(oneBillion), error);
      });

      testWidgets('pos ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(NumField.pos(blank: blank, validator: nok));
        expect(val(null), blank);
        expect(val(empty), blank);
        expect(val(zero), error);
        expect(val(ten), error);
        expect(val(oneBillion), error);
      });

      testWidgets('max ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val =
            await getVal(NumField.max(100, blank: blank, validator: nok));
        expect(val(null), blank);
        expect(val(empty), blank);
        expect(val(minusTen), error);
        expect(val(zero), error);
        expect(val(ten), error);
      });

      testWidgets('neg ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(NumField.neg(blank: blank, validator: nok));
        expect(val(null), blank);
        expect(val(empty), blank);
        expect(val(minusOneBillion), error);
        expect(val(minusTen), error);
        expect(val(minusOne), error);
      });

      testWidgets('range ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(
            NumField.range(-100, 100, blank: blank, validator: nok));
        expect(val(null), blank);
        expect(val(empty), blank);
        expect(val(minusTen), error);
        expect(val(minusOne), error);
        expect(val(one), error);
        expect(val(ten), error);
      });
    });
    testWidgets('malformed', (WidgetTester tester) async {
      Future<void> testNumField(
        NumField intField,
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

      await testNumField(
        NumField(malformed: nonDigit),
        [minusOneBillion, minusTen, minusOne, zero, one, ten, oneBillion],
        [empty, 'a', '00x', '0*9999', '1-0001', '1,1', '12345X', '?', '9!'],
      );
      await testNumField(
        NumField.min(-100, malformed: nonDigit),
        [one, ten, oneBillion],
        [empty, 'a', '0,0', 'X2345', '&', '9A'],
      );
      await testNumField(
        NumField.pos(malformed: nonDigit),
        [one, ten, oneBillion],
        [empty, 'aaa', '0+0', '12X', '???', '9!9'],
      );
      await testNumField(
        NumField.max(100, malformed: nonDigit),
        [zero, one, ten],
        [empty, 'a', '1a0', '12X456', '1,2', '9!'],
      );
      await testNumField(
        NumField.neg(malformed: nonDigit),
        [minusOne, minusTen, minusOneBillion],
        [empty, 'aaa', '1x0', '12X', '???', '9!9'],
      );
      await testNumField(
        NumField.range(-100, 100, malformed: nonDigit),
        [minusTen, minusOne, zero, one, ten],
        [empty, 'a', '+10+', '-1,0', '?', '9!'],
      );
    });
    testWidgets('trim and onChanged', (WidgetTester tester) async {
      const trimmed = '55.55';
      const untrimmed = '\n $trimmed \t';
      var count = 0;
      void onChanged(String s) {
        if (s.contains(RegExp('^$trimmed\$'))) {
          ++count;
        }
      }

      await tester.pumpWidget(WellFormed.app([
        NumField(key: kDef, trim: true, onChanged: onChanged),
        NumField.min(1, key: kMin, trim: true, onChanged: onChanged),
        NumField.pos(key: kPos, trim: true, onChanged: onChanged),
        NumField.max(100, key: kMax, trim: true, onChanged: onChanged),
        NumField.neg(key: kNeg, trim: true, onChanged: onChanged),
        NumField.range(1, 100, key: kRange, trim: true, onChanged: onChanged)
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
          NumField(controller: TextEditingController(text: init)),
          NumField.min(1, controller: TextEditingController(text: initMin)),
          NumField.pos(controller: TextEditingController(text: initPos)),
          NumField.max(100, controller: TextEditingController(text: initMax)),
          NumField.neg(controller: TextEditingController(text: initNeg)),
          NumField.range(
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
          NumField(initialValue: init),
          NumField.min(1, initialValue: initMin),
          NumField.pos(initialValue: initPos),
          NumField.max(100, initialValue: initMax),
          NumField.neg(initialValue: initNeg),
          NumField.range(5, 25, initialValue: initRange)
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
          NumField(decoration: const InputDecoration(labelText: l)),
          NumField.min(1, decoration: const InputDecoration(labelText: lMin)),
          NumField.pos(decoration: const InputDecoration(labelText: lPos)),
          NumField.max(10, decoration: const InputDecoration(labelText: lMax)),
          NumField.neg(decoration: const InputDecoration(labelText: lNeg)),
          NumField.range(
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
          NumField(textInputAction: action),
          NumField.min(1, textInputAction: actionMin),
          NumField.pos(textInputAction: actionPos),
          NumField.max(10, textInputAction: actionMax),
          NumField.neg(textInputAction: actionNeg),
          NumField.range(5, 25, textInputAction: actionRange),
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
          NumField(style: style),
          NumField.min(1, style: style),
          NumField.pos(style: style),
          NumField.max(10, style: style),
          NumField.neg(style: style),
          NumField.range(5, 25, style: style),
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
          NumField(textDirection: textDirection),
          NumField.min(1, textDirection: textDirection),
          NumField.pos(textDirection: textDirection),
          NumField.max(10, textDirection: textDirection),
          NumField.neg(textDirection: textDirection),
          NumField.range(5, 25, textDirection: textDirection),
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
          NumField(textAlign: textAlign),
          NumField.min(1, textAlign: textAlign),
          NumField.pos(textAlign: textAlign),
          NumField.max(10, textAlign: textAlign),
          NumField.neg(textAlign: textAlign),
          NumField.range(5, 25, textAlign: textAlign),
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
          NumField(readOnly: readOnly),
          NumField.min(1, readOnly: readOnly),
          NumField.pos(readOnly: readOnly),
          NumField.max(10, readOnly: readOnly),
          NumField.neg(readOnly: readOnly),
          NumField.range(5, 25, readOnly: readOnly),
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
          NumField(obscureText: obscureText),
          NumField.min(1, obscureText: obscureText),
          NumField.pos(obscureText: obscureText),
          NumField.max(10, obscureText: obscureText),
          NumField.neg(obscureText: obscureText),
          NumField.range(5, 25, obscureText: obscureText),
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
          NumField(autocorrect: autocorrect),
          NumField.min(1, autocorrect: autocorrect),
          NumField.pos(autocorrect: autocorrect),
          NumField.max(10, autocorrect: autocorrect),
          NumField.neg(autocorrect: autocorrect),
          NumField.range(5, 25, autocorrect: autocorrect),
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
          NumField(obscuringCharacter: obscuringCharacter),
          NumField.min(1, obscuringCharacter: obscuringCharacter),
          NumField.pos(obscuringCharacter: obscuringCharacter),
          NumField.max(10, obscuringCharacter: obscuringCharacter),
          NumField.neg(obscuringCharacter: obscuringCharacter),
          NumField.range(5, 25, obscuringCharacter: obscuringCharacter),
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
          NumField(maxLength: maxLength),
          NumField.min(1, maxLength: maxLength),
          NumField.pos(maxLength: maxLength),
          NumField.max(10, maxLength: maxLength),
          NumField.neg(maxLength: maxLength),
          NumField.range(15, 25, maxLength: maxLength),
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
          NumField(),
          NumField.min(1),
          NumField.pos(),
          NumField.max(10),
          NumField.pos(),
          NumField.range(5, 25),
        ]),
      );
      await tester.pumpAndSettle();
      final elems = tester.widgetList(find.byType(TextField));
      for (final elem in elems) {
        expect(
          (elem as TextField).keyboardType,
          const TextInputType.numberWithOptions(signed: true, decimal: true),
        );
      }
    });
    testWidgets('onEditingComplete', (WidgetTester tester) async {
      void onEdit() {}

      await tester.pumpWidget(
        WellFormed.app([
          NumField(onEditingComplete: onEdit),
          NumField.min(1, onEditingComplete: onEdit),
          NumField.pos(onEditingComplete: onEdit),
          NumField.max(10, onEditingComplete: onEdit),
          NumField.neg(onEditingComplete: onEdit),
          NumField.range(5, 25, onEditingComplete: onEdit),
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
          NumField(onFieldSubmitted: onSubmit),
          NumField.min(1, onFieldSubmitted: onSubmit),
          NumField.pos(onFieldSubmitted: onSubmit),
          NumField.max(10, onFieldSubmitted: onSubmit),
          NumField.neg(onFieldSubmitted: onSubmit),
          NumField.range(15, 25, onFieldSubmitted: onSubmit),
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
          NumField(onSaved: onSaved),
          NumField.min(1, onSaved: onSaved),
          NumField.pos(onSaved: onSaved),
          NumField.max(10, onSaved: onSaved),
          NumField.pos(onSaved: onSaved),
          NumField.range(5, 25, onSaved: onSaved),
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
    testWidgets('inputFormatters', (WidgetTester tester) async {
      final formatters = [
        MaskTextInputFormatter(
          mask: '###.###.###-##',
          filter: {"#": RegExp(r'\d')},
        ),
      ];
      await tester.pumpWidget(
        WellFormed.app([
          NumField(key: kDef, inputFormatters: formatters),
          NumField.min(1, key: kMin, inputFormatters: formatters),
          NumField.pos(key: kPos, inputFormatters: formatters),
          NumField.max(10, key: kMax, inputFormatters: formatters),
          NumField.neg(key: kNeg, inputFormatters: formatters),
          NumField.range(15, 25, key: kRange, inputFormatters: formatters),
        ]),
      );
      await tester.pumpAndSettle();
      for (var i = 0; i < keys.length; ++i) {
        final unmasked = '$i$i$i$i$i$i$i$i$i$i$i'; // E.g. 11111111111
        final masked = '$i$i$i.$i$i$i.$i$i$i-$i$i'; // E.g. 111.111.111-11
        await tester.enterText(find.byKey(keys[i]), unmasked);
        await tester.pumpAndSettle();
        final elem = tester.widget(find.widgetWithText(TextField, masked));
        expect((elem as TextField).inputFormatters, formatters);
        expect(find.text(masked), findsOneWidget);
      }
    });
    testWidgets('enabled', (WidgetTester tester) async {
      const enabled = false;
      await tester.pumpWidget(
        WellFormed.app([
          NumField(enabled: enabled),
          NumField.min(1, enabled: enabled),
          NumField.pos(enabled: enabled),
          NumField.max(10, enabled: enabled),
          NumField.neg(enabled: enabled),
          NumField.range(5, 25, enabled: enabled),
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
          NumField(scrollPadding: scrollPadding),
          NumField.min(1, scrollPadding: scrollPadding),
          NumField.pos(scrollPadding: scrollPadding),
          NumField.max(10, scrollPadding: scrollPadding),
          NumField.neg(scrollPadding: scrollPadding),
          NumField.range(5, 25, scrollPadding: scrollPadding),
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
          NumField(enableInteractiveSelection: enable),
          NumField.min(1, enableInteractiveSelection: enable),
          NumField.pos(enableInteractiveSelection: enable),
          NumField.max(10, enableInteractiveSelection: enable),
          NumField.neg(enableInteractiveSelection: enable),
          NumField.range(15, 25, enableInteractiveSelection: enable),
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
          NumField(autovalidateMode: autovalidateMode),
          NumField.min(1, autovalidateMode: autovalidateMode),
          NumField.pos(autovalidateMode: autovalidateMode),
          NumField.max(10, autovalidateMode: autovalidateMode),
          NumField.neg(autovalidateMode: autovalidateMode),
          NumField.range(5, 25, autovalidateMode: autovalidateMode),
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
