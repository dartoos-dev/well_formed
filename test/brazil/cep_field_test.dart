import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formdator/formdator.dart';
import 'package:well_formed/src/brazil/cep_field.dart';
import 'package:well_formed/src/core/well_formed.dart';

import '../get_val.dart';

Future<void> main() async {
  group('CepField', () {
    const empty = ''; // zero-length text.
    const malformed = 'Error: non-digit character(s)';
    const blank = 'Error: this field is required';
    const validCep = '12345-678';
    const invalidCep = '12345-67X';
    const init = '00000-000';
    const kDef = Key('()');
    testWidgets('key', (WidgetTester tester) async {
      await tester.pumpWidget(
        WellFormed.app([CepField(key: kDef)]),
      );
      expect(find.byKey(kDef), findsOneWidget);
    });
    testWidgets('blank', (WidgetTester tester) async {
      final getVal = GetVal(tester);
      final val = await getVal(
          CepField(key: kDef, blank: blank, initialValue: validCep));
      expect(val(null), blank);
      expect(val(empty), blank);
      expect(val(validCep), null);
    });
    testWidgets('validator', (WidgetTester tester) async {
      const error = 'cannot have odd digits';

      /// Input values cannot have uppercase letters.
      String? noOddDigits(String? v) =>
          (v != null && v.contains(RegExp('[13579]+'))) ? error : null;

      final getVal = GetVal(tester);
      final val =
          await getVal(CepField(validator: noOddDigits, malformed: malformed));
      expect(val(null), null);
      expect(val(empty), malformed);
      expect(val('22222-468'), null);
      expect(val('22221-468'), error);
      expect(val('11133-444'), error);
    });
    testWidgets('blank and validator', (WidgetTester tester) async {
      const error = 'it must always be invalid';
      const nok = Nok(error: error);
      final getVal = GetVal(tester);
      final val = await getVal(
        CepField(blank: blank, malformed: malformed, validator: nok),
      );
      expect(val(null), blank);
      expect(val(empty), blank);
      expect(val(validCep), error);
      expect(val(invalidCep), malformed);
    });
    testWidgets('trim and onChanged', (WidgetTester tester) async {
      const trimmed = '11223445';
      const nonTrimmed = '\n $trimmed \t';
      var count = 0;
      void onChanged(String s) {
        if (s.contains(RegExp('^$trimmed\$'))) {
          ++count;
        }
      }

      await tester.pumpWidget(WellFormed.app([
        CepField(key: kDef, trim: true, onChanged: onChanged),
      ]));
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(kDef), nonTrimmed);
      await tester.pumpAndSettle();
      expect(count, 1);
    });
    testWidgets('strip', (WidgetTester tester) async {
      const masked = '11223-445';
      const unmasked = '11223445';
      var count = 0;
      void shouldStrip(String s) {
        if (s.contains(RegExp('^$unmasked\$'))) {
          ++count;
        }
      }

      final key = UniqueKey();
      await tester.pumpWidget(WellFormed.app([
        /// The default value of the strip flag is already true.
        CepField(key: key, onChanged: shouldStrip),
      ]));
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(key), masked);
      await tester.pumpAndSettle();
      expect(count, 1);
    });
    testWidgets('do not strip', (WidgetTester tester) async {
      const masked = '11223-445';
      var count = 0;
      void shouldNotStrip(String s) {
        if (s.contains(RegExp('^$masked\$'))) {
          ++count;
        }
      }

      final key = UniqueKey();
      await tester.pumpWidget(WellFormed.app([
        CepField(strip: false, key: key, onChanged: shouldNotStrip),
      ]));
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(key), masked);
      await tester.pumpAndSettle();
      expect(count, 1);
    });
    testWidgets('controller', (WidgetTester tester) async {
      await tester.pumpWidget(
        WellFormed.app([
          CepField(controller: TextEditingController(text: init)),
        ]),
      );
      await tester.pumpAndSettle();
      expect(find.text(init), findsOneWidget);
    });
    testWidgets('initialValue', (WidgetTester tester) async {
      await tester.pumpWidget(
        WellFormed.app([CepField(initialValue: init)]),
      );
      await tester.pumpAndSettle();
      expect(find.text(init), findsOneWidget);
    });
    testWidgets('decoration', (WidgetTester tester) async {
      const label = 'Cep';
      await tester.pumpWidget(
        WellFormed.app([
          CepField(
            decoration: const InputDecoration(labelText: label),
          )
        ]),
      );
      await tester.pumpAndSettle();
      expect(find.text(label), findsOneWidget);
    });
    testWidgets('textInputAction', (WidgetTester tester) async {
      const action = TextInputAction.send;
      await tester.pumpWidget(
        WellFormed.app([
          CepField(textInputAction: action),
        ]),
      );
      await tester.pumpAndSettle();
      final elem = tester.widget(find.byType(TextField));
      expect((elem as TextField).textInputAction, action);
    });
    testWidgets('style', (WidgetTester tester) async {
      const style = TextStyle();
      await tester.pumpWidget(WellFormed.app([CepField(style: style)]));
      await tester.pumpAndSettle();
      final elem = tester.widget(find.byType(TextField));
      expect((elem as TextField).style, style);
    });
    testWidgets('textDirection', (WidgetTester tester) async {
      const textDirection = TextDirection.rtl;
      await tester.pumpWidget(
        WellFormed.app([
          CepField(textDirection: textDirection),
        ]),
      );
      await tester.pumpAndSettle();
      final elem = tester.widget(find.byType(TextField));
      expect((elem as TextField).textDirection, textDirection);
    });
    testWidgets('textAlign', (WidgetTester tester) async {
      const textAlign = TextAlign.justify;
      await tester.pumpWidget(
        WellFormed.app([CepField(textAlign: textAlign)]),
      );
      await tester.pumpAndSettle();
      final elem = tester.widget(find.byType(TextField));
      expect((elem as TextField).textAlign, textAlign);
    });
    testWidgets('readOnly', (WidgetTester tester) async {
      const readOnly = true;
      await tester.pumpWidget(
        WellFormed.app([CepField(readOnly: readOnly)]),
      );
      await tester.pumpAndSettle();
      final elem = tester.widget(find.byType(TextField));
      expect((elem as TextField).readOnly, readOnly);
    });
    testWidgets('obscureText', (WidgetTester tester) async {
      const obscureText = true;
      await tester.pumpWidget(
        WellFormed.app([CepField(obscureText: obscureText)]),
      );
      await tester.pumpAndSettle();
      final elem = tester.widget(find.byType(TextField));
      expect((elem as TextField).obscureText, obscureText);
    });
    testWidgets('autocorrect', (WidgetTester tester) async {
      const autocorrect = false;
      await tester.pumpWidget(
        WellFormed.app([CepField(autocorrect: autocorrect)]),
      );
      await tester.pumpAndSettle();
      final elem = tester.widget(find.byType(TextField));
      expect((elem as TextField).autocorrect, autocorrect);
    });
    testWidgets('obscuringCharacter', (WidgetTester tester) async {
      const obscuringCharacter = '*';
      await tester.pumpWidget(
        WellFormed.app([CepField(obscuringCharacter: obscuringCharacter)]),
      );
      await tester.pumpAndSettle();
      final elem = tester.widget(find.byType(TextField));
      expect((elem as TextField).obscuringCharacter, obscuringCharacter);
    });
    testWidgets('maxLength', (WidgetTester tester) async {
      const maxLength = 10;
      await tester.pumpWidget(
        WellFormed.app([CepField(maxLength: maxLength)]),
      );
      await tester.pumpAndSettle();
      final elem = tester.widget(find.byType(TextField));
      expect((elem as TextField).maxLength, maxLength);
    });
    testWidgets('keyboardType', (WidgetTester tester) async {
      await tester.pumpWidget(
        WellFormed.app([CepField()]),
      );
      await tester.pumpAndSettle();
      final elem = tester.widget(find.byType(TextField));

      /// CepField's keyboardType must always be [TextInputType.number].
      expect((elem as TextField).keyboardType, TextInputType.number);
    });
    testWidgets('onEditingComplete', (WidgetTester tester) async {
      void onEdit() {}

      await tester
          .pumpWidget(WellFormed.app([CepField(onEditingComplete: onEdit)]));
      await tester.pumpAndSettle();
      final elem = tester.widget(find.byType(TextField));
      expect((elem as TextField).onEditingComplete, onEdit);
    });
    testWidgets('onFieldSubmitted', (WidgetTester tester) async {
      var count = 0;
      void onSubmit(String s) => ++count;
      await tester.pumpWidget(
        WellFormed.app([CepField(onFieldSubmitted: onSubmit)]),
      );
      await tester.pumpAndSettle();
      final elem = tester.widget(find.byType(TextField));
      final callback = (elem as TextField).onSubmitted;
      expect(callback, isNotNull);
      callback!('');
      expect(count, 1);
    });
    testWidgets('onSaved', (WidgetTester tester) async {
      var count = 0;
      final key = UniqueKey();
      void onSaved(String? s) => ++count;

      await tester.pumpWidget(
        WellFormed.app(
          [CepField(onSaved: onSaved, initialValue: validCep)],
          submitKey: key,
        ),
      );
      await tester.pumpAndSettle();
      await tester.press(find.byKey(key));
      await tester.pumpAndSettle();
      final elem = tester.widget(find.byType(TextFormField));
      // expect((elem as TextFormField).onSaved, onSaved);
      final callback = (elem as TextFormField).onSaved;
      expect(callback, isNotNull);
      callback!('calling onSaved');
      expect(count, 1);
    });
    testWidgets('inputFormatters - mask', (WidgetTester tester) async {
      for (var i = 0; i < 10; ++i) {
        final key = UniqueKey();
        await tester.pumpWidget(WellFormed.app([CepField(key: key)]));
        await tester.pumpAndSettle();
        final unmasked = '$i$i$i$i$i$i$i$i'; // E.g. 11111111
        final masked = '$i$i$i$i$i-$i$i$i'; // E.g. 11111-111
        await tester.enterText(find.byKey(key), unmasked);
        await tester.pumpAndSettle();
        expect(find.text(masked), findsOneWidget);
      }
    });
    testWidgets('enabled', (WidgetTester tester) async {
      const enabled = false;
      await tester.pumpWidget(WellFormed.app([CepField(enabled: enabled)]));
      await tester.pumpAndSettle();
      final elem = tester.widget(find.byType(TextField));
      expect((elem as TextField).enabled, enabled);
    });
    testWidgets('scrollPadding', (WidgetTester tester) async {
      const scrollPadding = EdgeInsets.all(40.0);
      await tester.pumpWidget(
        WellFormed.app([CepField(scrollPadding: scrollPadding)]),
      );
      await tester.pumpAndSettle();
      final elem = tester.widget(find.byType(TextField));
      expect((elem as TextField).scrollPadding, scrollPadding);
    });
    testWidgets('enableInteraciveSelection', (WidgetTester tester) async {
      const enableInteractiveSelection = false;
      await tester.pumpWidget(
        WellFormed.app([
          CepField(enableInteractiveSelection: enableInteractiveSelection),
        ]),
      );
      await tester.pumpAndSettle();
      final elem = tester.widget(find.byType(TextField));
      expect((elem as TextField).enableInteractiveSelection,
          enableInteractiveSelection);
    });
    testWidgets('autoValidateMode', (WidgetTester tester) async {
      const autovalidateMode = AutovalidateMode.onUserInteraction;
      await tester.pumpWidget(
        WellFormed.app([CepField(autovalidateMode: autovalidateMode)]),
      );
      await tester.pumpAndSettle();
      final elem = tester.widget(find.byType(TextFormField));
      expect((elem as TextFormField).autovalidateMode, autovalidateMode);
    });
  });
}
