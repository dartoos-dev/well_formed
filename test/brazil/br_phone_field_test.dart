import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formdator/formdator.dart';
import 'package:well_formed/src/brazil/br_phone_field.dart';
import 'package:well_formed/src/core/well_formed.dart';

import '../get_val.dart';

// ignore_for_file: require_trailing_commas
Future<void> main() async {
  group('BrPhoneField', () {
    const empty = ''; // zero-length text.
    const mal = 'Error: malformed phone';
    const blank = 'Error: a phone is required';
    const validBrPhone = '(11) 8765-4321';
    const invalidBrPhone = '11) 8765-4321';
    const init = '(00) 0000-0000';
    const kDef = Key('()');
    group('key', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        await tester.pumpWidget(WellFormed.app([BrPhoneField(key: kDef)]));
        expect(find.byKey(kDef), findsOneWidget);
      });
    });
    group('blank', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(BrPhoneField(key: kDef, blank: blank));
        expect(val(null), blank);
        expect(val(empty), blank);
        expect(val(validBrPhone), null);
      });
    });
    group('validator', () {
      const oddError = 'it cannot contain odd digits';

      /// BrPhones cannot contain odd numbers.
      String? noOddDigits(String? v) {
        return v != null && v.contains(RegExp('[13579]+')) ? oddError : null;
      }

      testWidgets('default ctor', (WidgetTester tester) async {
        const validBrPhoneWithOddDigit = '(22) 4621-2244';
        final getVal = GetVal(tester);
        final val =
            await getVal(BrPhoneField(malformed: mal, validator: noOddDigits));
        expect(val(null), null);
        expect(val(validBrPhoneWithOddDigit), oddError);
      });
    });
    group('blank and validator', () {
      const error = 'it must be a valid phone';
      const nok = Nok(error: error);

      testWidgets('default ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(
          BrPhoneField(blank: blank, malformed: mal, validator: nok.call),
        );
        expect(val(null), blank);
        expect(val(empty), blank);
        expect(val(invalidBrPhone), mal);
        expect(val(validBrPhone), error);
      });
    });
    group('trim and onChanged', () {
      testWidgets('unmasked', (WidgetTester tester) async {
        var count = 0;
        const trimmed = '1167654322';
        const untrimmed = '\n $trimmed \t';
        void onChanged(String s) {
          if (s == trimmed) {
            ++count;
          }
        }

        await tester.pumpWidget(WellFormed.app([
          BrPhoneField(key: kDef, trim: true, onChanged: onChanged),
        ]));
        await tester.enterText(find.byKey(kDef), untrimmed);
        await tester.pumpAndSettle();
        expect(count, 1);
      });

      ///
      testWidgets('masked', (WidgetTester tester) async {
        const trimmed = '(11) 6765-4322';
        const untrimmed = '\n $trimmed \t';
        var count = 0;
        void onChanged(String s) {
          if (s == trimmed) {
            ++count;
          }
        }

        await tester.pumpWidget(WellFormed.app([
          BrPhoneField(
              key: kDef, strip: false, trim: true, onChanged: onChanged),
        ]));
        await tester.enterText(find.byKey(kDef), untrimmed);
        await tester.pumpAndSettle();
        expect(count, 1);
      });
    });
    group('strip', () {
      testWidgets('defaul ctor', (WidgetTester tester) async {
        const unstripped = '(12) 4567-8900';
        const stripped = '1245678900';
        var count = 0;
        void shouldStrip(String s) {
          if (s == stripped) {
            ++count;
          }
        }

        final key = UniqueKey();
        await tester.pumpWidget(WellFormed.app([
          /// The default value of the strip flag is already true.
          BrPhoneField(key: key, onChanged: shouldStrip),
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
            BrPhoneField(controller: TextEditingController(text: init)),
          ]),
        );
        await tester.pumpAndSettle();
        expect(find.text(init), findsOneWidget);
      });
    });
    group('initialValue', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        await tester.pumpWidget(
          WellFormed.app([BrPhoneField(initialValue: init)]),
        );
        await tester.pumpAndSettle();
        expect(find.text(init), findsOneWidget);
      });
    });
    group('decoration', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        const label = 'BrPhone';
        await tester.pumpWidget(
          WellFormed.app([
            BrPhoneField(
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
          WellFormed.app([BrPhoneField(textInputAction: action)]),
        );
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).textInputAction, action);
      });
    });
    group('style', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        const style = TextStyle();
        await tester.pumpWidget(WellFormed.app([BrPhoneField(style: style)]));
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).style, style);
      });
    });
    group('textDirection', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        const textDirection = TextDirection.rtl;
        await tester.pumpWidget(
          WellFormed.app([BrPhoneField(textDirection: textDirection)]),
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
          WellFormed.app([BrPhoneField(textAlign: textAlign)]),
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
          WellFormed.app([BrPhoneField(readOnly: readOnly)]),
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
          WellFormed.app([BrPhoneField(obscureText: obscureText)]),
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
          WellFormed.app([BrPhoneField(autocorrect: autocorrect)]),
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
          WellFormed.app(
              [BrPhoneField(obscuringCharacter: obscuringCharacter)]),
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
          WellFormed.app([BrPhoneField(maxLength: maxLength)]),
        );
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).maxLength, maxLength);
      });
    });
    group('keyboardType', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        await tester.pumpWidget(
          WellFormed.app([BrPhoneField()]),
        );
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextField));

        /// BrPhoneField's keyboardType must always be [TextInputType.number].
        expect((elem as TextField).keyboardType, TextInputType.number);
      });
    });
    group('onEdigingComplete', () {
      void onEdit() {}
      testWidgets('default ctor', (WidgetTester tester) async {
        await tester.pumpWidget(
          WellFormed.app([BrPhoneField(onEditingComplete: onEdit)]),
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
          WellFormed.app([BrPhoneField(onFieldSubmitted: onSubmit)]),
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
            [BrPhoneField(onSaved: onSaved, initialValue: validBrPhone)],
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
          [BrPhoneField(enabled: enabled)],
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
          BrPhoneField(scrollPadding: scrollPadding),
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
            BrPhoneField(enableInteractiveSelection: false),
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
          BrPhoneField(autovalidateMode: mode),
        ]));
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextFormField));
        expect((elem as TextFormField).autovalidateMode, mode);
      });
    });
  });
}
