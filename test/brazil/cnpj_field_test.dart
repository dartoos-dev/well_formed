import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formdator/formdator.dart';
import 'package:well_formed/src/brazil/cnpj_field.dart';
import 'package:well_formed/src/core/well_formed.dart';

import '../get_val.dart';

Future<void> main() async {
  group('CnpjField', () {
    const empty = ''; // zero-length text.
    const mal = 'Error: malformed cnpj';
    const blank = 'Error: a cnpj is required';
    const validCnpj =  '34.600.728/0001-76';
    const invalidCnpj = '40.76.91/0001-02';
    const init = '00.000.000/0000-00';
    const kDef = Key('()');
    group('key', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        await tester.pumpWidget(WellFormed.app([CnpjField(key: kDef)]));
        expect(find.byKey(kDef), findsOneWidget);
      });
    });
    group('blank', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(CnpjField(key: kDef, blank: blank));
        expect(val(null), blank);
        expect(val(empty), blank);
        expect(val(validCnpj), null);
      });
    });
    group('validator', () {
      const oddError = 'it cannot contain odd digits';

      /// Cnpjs cannot contain uppercase letters.
      String? noOddDigits(String? v) {
        return v != null && v.contains(RegExp('[13579]+')) ? oddError : null;
      }

      testWidgets('default ctor', (WidgetTester tester) async {
        const validCnpjWithOddDigit = '41831918000160';
        final getVal = GetVal(tester);
        final val =
            await getVal(CnpjField(malformed: mal, validator: noOddDigits));
        expect(val(null), null);
        expect(val(validCnpjWithOddDigit), oddError);
      });
    });
    group('blank and validator', () {
      const error = 'it must be a valid cnpj';
      const nok = Nok(error: error);

      testWidgets('default ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(
          CnpjField(blank: blank, malformed: mal, validator: nok),
        );
        expect(val(null), blank);
        expect(val(empty), blank);
        expect(val(invalidCnpj), mal);
        expect(val(validCnpj), error);
      });
    });
    group('trim and onChanged', () {
      testWidgets('unmasked', (WidgetTester tester) async {
        var count = 0;
        const trimmed = '41831918000160';
        const untrimmed = '\n $trimmed \t';
        void onChanged(String s) {
          if (s.contains(RegExp('^$trimmed\$'))) {
            ++count;
          }
        }

        await tester.pumpWidget(WellFormed.app([
          CnpjField(key: kDef, trim: true, onChanged: onChanged),
        ]));
        await tester.enterText(find.byKey(kDef), untrimmed);
        await tester.pumpAndSettle();
        expect(count, 1);
      });

      ///
      testWidgets('masked', (WidgetTester tester) async {
        const trimmed = '41.831.918/0001-60';
        const untrimmed = '\n $trimmed \t';
        var count = 0;
        void onChanged(String s) {
          if (s.contains(RegExp('^$trimmed\$'))) {
            ++count;
          }
        }

        await tester.pumpWidget(WellFormed.app([
          CnpjField(key: kDef, strip: false, trim: true, onChanged: onChanged),
        ]));
        await tester.enterText(find.byKey(kDef), untrimmed);
        await tester.pumpAndSettle();
        expect(count, 1);
      });
    });
    group('strip', () {
      testWidgets('defaul ctor', (WidgetTester tester) async {
        const unstripped = '41.831.918/0001-60';
        const stripped = '41831918000160';
        var count = 0;
        void shouldStrip(String s) {
          if (s.contains(RegExp('^$stripped\$'))) {
            ++count;
          }
        }

        final key = UniqueKey();
        await tester.pumpWidget(WellFormed.app([
          /// The default value of the strip flag is already true.
          CnpjField(key: key, onChanged: shouldStrip),
        ]));
        await tester.pumpAndSettle();
        await tester.enterText(find.byKey(key), unstripped);
        await tester.pumpAndSettle();
        expect(count, 1);
      });
    });
    group('controller', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        await tester.pumpWidget(
          WellFormed.app([
            CnpjField(controller: TextEditingController(text: init)),
          ]),
        );
        await tester.pumpAndSettle();
        expect(find.text(init), findsOneWidget);
      });
    });
    group('initialValue', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        await tester.pumpWidget(
          WellFormed.app([CnpjField(initialValue: init)]),
        );
        await tester.pumpAndSettle();
        expect(find.text(init), findsOneWidget);
      });
    });
    group('decoration', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        const label = 'Cnpj';
        await tester.pumpWidget(
          WellFormed.app([
            CnpjField(
              decoration: const InputDecoration(labelText: label),
            )
          ]),
        );
        await tester.pumpAndSettle();
        expect(find.text(label), findsOneWidget);
      });
    });
    group('textInputAction', () {
      testWidgets('textInputAction', (WidgetTester tester) async {
        const action = TextInputAction.send;
        await tester.pumpWidget(
          WellFormed.app([CnpjField(textInputAction: action)]),
        );
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).textInputAction, action);
      });
    });
    group('style', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        const style = TextStyle();
        await tester.pumpWidget(WellFormed.app([CnpjField(style: style)]));
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).style, style);
      });
    });
    group('textDirection', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        const textDirection = TextDirection.rtl;
        await tester.pumpWidget(
          WellFormed.app([CnpjField(textDirection: textDirection)]),
        );
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).textDirection, textDirection);
      });
    });
    group('textAlign', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        const textAlign = TextAlign.justify;
        await tester.pumpWidget(
          WellFormed.app([CnpjField(textAlign: textAlign)]),
        );
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).textAlign, textAlign);
      });
    });
    group('readOnly', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        const readOnly = true;
        await tester.pumpWidget(
          WellFormed.app([CnpjField(readOnly: readOnly)]),
        );
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).readOnly, readOnly);
      });
    });
    group('obscureText', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        const obscureText = true;
        await tester.pumpWidget(
          WellFormed.app([CnpjField(obscureText: obscureText)]),
        );
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).obscureText, obscureText);
      });
    });
    group('autocorrect', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        const autocorrect = false;
        await tester.pumpWidget(
          WellFormed.app([CnpjField(autocorrect: autocorrect)]),
        );
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).autocorrect, autocorrect);
      });
    });
    group('obscuringCharacter', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        const obscuringCharacter = '*';
        await tester.pumpWidget(
          WellFormed.app([CnpjField(obscuringCharacter: obscuringCharacter)]),
        );
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).obscuringCharacter, obscuringCharacter);
      });
    });
    group('maxLength', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        const maxLength = 10;
        await tester.pumpWidget(
          WellFormed.app([CnpjField(maxLength: maxLength)]),
        );
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).maxLength, maxLength);
      });
    });
    group('keyboardType', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        await tester.pumpWidget(
          WellFormed.app([CnpjField()]),
        );
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextField));

        /// CnpjField's keyboardType must always be [TextInputType.number].
        expect((elem as TextField).keyboardType, TextInputType.number);
      });
    });
    group('onEdigingComplete', () {
      void onEdit() {}
      testWidgets('default ctor', (WidgetTester tester) async {
        await tester.pumpWidget(
          WellFormed.app([CnpjField(onEditingComplete: onEdit)]),
        );
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).onEditingComplete, onEdit);
      });
    });
    group('onFieldSubmitted', () {
      var count = 0;
      void onSubmit(String s) => ++count;

      testWidgets('default ctor', (WidgetTester tester) async {
        await tester.pumpWidget(
          WellFormed.app([CnpjField(onFieldSubmitted: onSubmit)]),
        );
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextField));
        final callback = (elem as TextField).onSubmitted;
        expect(callback, isNotNull);
        final before = count;
        callback!('');
        expect(count, before + 1);
      });
    });
    group('onSaved', () {
      var count = 0;
      void onSaved(String? s) => ++count;

      testWidgets('default ctor', (WidgetTester tester) async {
        final key = UniqueKey();
        await tester.pumpWidget(
          WellFormed.app(
            [CnpjField(onSaved: onSaved, initialValue: validCnpj)],
            submitKey: key,
          ),
        );
        await tester.pumpAndSettle();
        await tester.press(find.byKey(key));
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextFormField));
        final callback = (elem as TextFormField).onSaved;
        expect(callback, isNotNull);
        final before = count;
        callback!('calling onSaved');
        expect(count, before + 1);
      });
    });
    group('enabled', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        const enabled = false;
        await tester.pumpWidget(WellFormed.app(
          [CnpjField(enabled: enabled)],
        ));
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).enabled, enabled);
      });
    });
    group('scrollPadding', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        const scrollPadding = EdgeInsets.all(40.0);
        await tester.pumpWidget(WellFormed.app([
          CnpjField(scrollPadding: scrollPadding),
        ]));
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).scrollPadding, scrollPadding);
      });
    });
    group('enableInteraciveSelection', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        await tester.pumpWidget(
          WellFormed.app([
            CnpjField(enableInteractiveSelection: false),
          ]),
        );
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).enableInteractiveSelection, false);
      });
    });
    group('autoValidateMode', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        const mode = AutovalidateMode.onUserInteraction;
        await tester.pumpWidget(WellFormed.app([
          CnpjField(autovalidateMode: mode),
        ]));
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextFormField));
        expect((elem as TextFormField).autovalidateMode, mode);
      });
    });
  });
}
