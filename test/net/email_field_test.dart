import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formdator/formdator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:well_formed/src/core/well_formed.dart';
import 'package:well_formed/src/net/email_field.dart';

import '../get_val.dart';

// ignore_for_file: require_trailing_commas
Future<void> main() async {
  group('EmailField', () {
    const empty = ''; // zero-length text.
    const mal = 'Error: malformed email';
    const blank = 'Error: an email is required';
    const long = 'Error: the entered email is too long';
    const validEmail = 'a_user@provider.com';
    const invalidEmail = 'an_invalid_user.com.br';
    const emailLongerThan50 =
        'an_extremely_long_and_boring_to_read_email_address@provider.com';
    const init = validEmail;
    const kDef = Key('()');
    const kLen = Key('len');
    group('key', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        await tester.pumpWidget(WellFormed.app(
          [EmailField(key: kDef)],
        ));
        expect(find.byKey(kDef), findsOneWidget);
      });
      testWidgets('len ctor', (WidgetTester tester) async {
        await tester.pumpWidget(WellFormed.app(
          [EmailField.len(50, key: kLen)],
        ));
        expect(find.byKey(kLen), findsOneWidget);
      });
    });
    group('blank', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(EmailField(key: kDef, blank: blank));
        expect(val(null), blank);
        expect(val(empty), blank);
        expect(val(validEmail), null);
      });
      testWidgets('len ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(EmailField.len(50, key: kDef, blank: blank));
        expect(val(null), blank);
        expect(val(empty), blank);
        expect(val(validEmail), null);
      });
    });
    group('len', () {
      testWidgets('too long email', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(
          EmailField.len(50, long: long, blank: blank, malformed: mal),
        );
        expect(val(null), blank);
        expect(val(empty), blank);
        expect(val(invalidEmail), mal);
        expect(val(emailLongerThan50), long);
        expect(val(validEmail), null);
      });
    });
    group('validator', () {
      const error = 'it cannot contain uppercase letters';
      const single = 'a_single_Uppercase_letter_ruins_everything@email.com';

      /// Emails cannot contain uppercase letters.
      String? noUpperCase(String? v) {
        return v != null && v.contains(RegExp('[A-Z]+')) ? error : null;
      }

      testWidgets('default ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val =
            await getVal(EmailField(malformed: mal, validator: noUpperCase));
        expect(val(null), null);
        expect(val(validEmail), null);
        expect(val(invalidEmail), mal);
        expect(val(validEmail.toUpperCase()), error);
        expect(val(single), error);
      });

      testWidgets('len ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(EmailField.len(
          60,
          malformed: mal,
          validator: noUpperCase,
        ));
        expect(val(null), null);
        expect(val(validEmail), null);
        expect(val(invalidEmail), mal);
        expect(val(validEmail.toUpperCase()), error);
        expect(val(single), error);
      });
    });
    group('blank and validator', () {
      const error = 'it must be a valid email';
      const nok = Nok(error: error);

      testWidgets('default ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(
          EmailField(blank: blank, malformed: mal, validator: nok.call),
        );
        expect(val(null), blank);
        expect(val(empty), blank);
        expect(val(validEmail), error);
        expect(val(invalidEmail), mal);
      });

      testWidgets('len ctor', (WidgetTester tester) async {
        final getVal = GetVal(tester);
        final val = await getVal(
          EmailField.len(50, blank: blank, malformed: mal, validator: nok.call),
        );
        expect(val(null), blank);
        expect(val(empty), blank);
        expect(val(validEmail), error);
        expect(val(invalidEmail), mal);
      });
    });
    group('trim and onChanged', () {
      const trimmed = validEmail;
      const untrimmed = '\n $trimmed \t';
      var count = 0;
      void onChanged(String s) {
        if (s.contains(RegExp('^$trimmed\$'))) {
          ++count;
        }
      }

      testWidgets('default ctor', (WidgetTester tester) async {
        await tester.pumpWidget(WellFormed.app([
          EmailField(key: kDef, trim: true, onChanged: onChanged),
        ]));
        final before = count;
        await tester.enterText(find.byKey(kDef), untrimmed);
        await tester.pumpAndSettle();
        expect(count, before + 1);
      });
      testWidgets('len ctor', (WidgetTester tester) async {
        await tester.pumpWidget(WellFormed.app([
          EmailField.len(50, key: kLen, trim: true, onChanged: onChanged),
        ]));
        final before = count;
        await tester.enterText(find.byKey(kLen), untrimmed);
        await tester.pumpAndSettle();
        expect(count, before + 1);
      });
    });
    group('controller', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        await tester.pumpWidget(
          WellFormed.app([
            EmailField(controller: TextEditingController(text: init)),
          ]),
        );
        await tester.pumpAndSettle();
        expect(find.text(init), findsOneWidget);
      });
      testWidgets('len ctor', (WidgetTester tester) async {
        await tester.pumpWidget(
          WellFormed.app([
            EmailField(controller: TextEditingController(text: init)),
          ]),
        );
        await tester.pumpAndSettle();
        expect(find.text(init), findsOneWidget);
      });
    });
    group('initialValue', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        await tester.pumpWidget(
          WellFormed.app([EmailField(initialValue: init)]),
        );
        await tester.pumpAndSettle();
        expect(find.text(init), findsOneWidget);
      });
      testWidgets('len ctor', (WidgetTester tester) async {
        await tester.pumpWidget(
          WellFormed.app([EmailField.len(50, initialValue: init)]),
        );
        await tester.pumpAndSettle();
        expect(find.text(init), findsOneWidget);
      });
    });
    group('decoration', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        const label = 'Email';
        await tester.pumpWidget(
          WellFormed.app([
            EmailField(
              decoration: const InputDecoration(labelText: label),
            )
          ]),
        );
        await tester.pumpAndSettle();
        expect(find.text(label), findsOneWidget);
      });
      testWidgets('len ctor', (WidgetTester tester) async {
        const label = 'Email (max 50 chars)';
        await tester.pumpWidget(
          WellFormed.app([
            EmailField.len(
              50,
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
          WellFormed.app([EmailField(textInputAction: action)]),
        );
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).textInputAction, action);
      });
      testWidgets('len ctor', (WidgetTester tester) async {
        const action = TextInputAction.join;
        await tester.pumpWidget(
          WellFormed.app([EmailField.len(50, textInputAction: action)]),
        );
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).textInputAction, action);
      });
    });
    group('style', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        const style = TextStyle();
        await tester.pumpWidget(WellFormed.app([EmailField(style: style)]));
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).style, style);
      });
      testWidgets('len ctor', (WidgetTester tester) async {
        const style = TextStyle();
        await tester.pumpWidget(WellFormed.app(
          [EmailField.len(50, style: style)],
        ));
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).style, style);
      });
    });
    group('textDirection', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        const textDirection = TextDirection.rtl;
        await tester.pumpWidget(
          WellFormed.app([EmailField(textDirection: textDirection)]),
        );
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).textDirection, textDirection);
      });
      testWidgets('default ctor', (WidgetTester tester) async {
        const textDirection = TextDirection.rtl;
        await tester.pumpWidget(
          WellFormed.app([EmailField.len(50, textDirection: textDirection)]),
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
          WellFormed.app([EmailField(textAlign: textAlign)]),
        );
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).textAlign, textAlign);
      });
      testWidgets('len ctor', (WidgetTester tester) async {
        const textAlign = TextAlign.justify;
        await tester.pumpWidget(
          WellFormed.app([EmailField.len(50, textAlign: textAlign)]),
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
          WellFormed.app([EmailField(readOnly: readOnly)]),
        );
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).readOnly, readOnly);
      });
      testWidgets('len ctor', (WidgetTester tester) async {
        const readOnly = true;
        await tester.pumpWidget(
          WellFormed.app([EmailField.len(50, readOnly: readOnly)]),
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
          WellFormed.app([EmailField(obscureText: obscureText)]),
        );
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).obscureText, obscureText);
      });
      testWidgets('len ctor', (WidgetTester tester) async {
        const obscureText = true;
        await tester.pumpWidget(
          WellFormed.app([EmailField.len(50, obscureText: obscureText)]),
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
          WellFormed.app([EmailField(autocorrect: autocorrect)]),
        );
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).autocorrect, autocorrect);
      });
      testWidgets('len ctor', (WidgetTester tester) async {
        const autocorrect = false;
        await tester.pumpWidget(
          WellFormed.app([EmailField.len(50, autocorrect: autocorrect)]),
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
          WellFormed.app([EmailField(obscuringCharacter: obscuringCharacter)]),
        );
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).obscuringCharacter, obscuringCharacter);
      });
      testWidgets('len ctor', (WidgetTester tester) async {
        const obscuringCharacter = '*';
        await tester.pumpWidget(
          WellFormed.app(
            [EmailField.len(50, obscuringCharacter: obscuringCharacter)],
          ),
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
          WellFormed.app([EmailField(maxLength: maxLength)]),
        );
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).maxLength, maxLength);
      });
      testWidgets('len ctor', (WidgetTester tester) async {
        const maxLength = 50;
        await tester.pumpWidget(
          WellFormed.app([EmailField.len(50, maxLength: maxLength)]),
        );
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).maxLength, maxLength);
      });
    });
    group('keyboardType', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        await tester.pumpWidget(
          WellFormed.app([EmailField()]),
        );
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextField));

        /// EmailField's keyboardType must always be [TextInputType.emailAddress].
        expect((elem as TextField).keyboardType, TextInputType.emailAddress);
      });
      testWidgets('len ctor', (WidgetTester tester) async {
        await tester.pumpWidget(
          WellFormed.app([EmailField.len(50)]),
        );
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextField));

        /// EmailField's keyboardType must always be [TextInputType.emailAddress].
        expect((elem as TextField).keyboardType, TextInputType.emailAddress);
      });
    });
    group('onEdigingComplete', () {
      void onEdit() {}
      testWidgets('default ctor', (WidgetTester tester) async {
        await tester.pumpWidget(
          WellFormed.app([EmailField(onEditingComplete: onEdit)]),
        );
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).onEditingComplete, onEdit);
      });
      testWidgets('len ctor', (WidgetTester tester) async {
        await tester.pumpWidget(
          WellFormed.app([EmailField.len(50, onEditingComplete: onEdit)]),
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
          WellFormed.app([EmailField(onFieldSubmitted: onSubmit)]),
        );
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextField));
        final callback = (elem as TextField).onSubmitted;
        expect(callback, isNotNull);
        final before = count;
        callback!('');
        expect(count, before + 1);
      });
      testWidgets('len ctor', (WidgetTester tester) async {
        await tester.pumpWidget(
          WellFormed.app([EmailField.len(50, onFieldSubmitted: onSubmit)]),
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
            [EmailField(onSaved: onSaved, initialValue: validEmail)],
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
      testWidgets('len ctor', (WidgetTester tester) async {
        final key = UniqueKey();
        await tester.pumpWidget(
          WellFormed.app(
            [EmailField.len(50, onSaved: onSaved, initialValue: validEmail)],
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
    group('inputFormatters - mask', () {
      final formatters = [
        MaskTextInputFormatter(
          mask: '###.###.###-##',
          filter: {"#": RegExp(r'\d')},
        ),
      ];
      const unmasked = '11111111111';
      const masked = '111.111.111-11';
      testWidgets('default ctor', (WidgetTester tester) async {
        final key = UniqueKey();
        await tester.pumpWidget(WellFormed.app([
          EmailField(key: key, inputFormatters: formatters),
        ]));
        await tester.enterText(find.byKey(key), unmasked);
        await tester.pumpAndSettle();
        expect(find.text(masked), findsOneWidget);
      });
      testWidgets('len ctor', (WidgetTester tester) async {
        final key = UniqueKey();
        await tester.pumpWidget(
          WellFormed.app([
            EmailField.len(50, key: key, inputFormatters: formatters),
          ]),
        );
        await tester.enterText(find.byKey(key), unmasked);
        await tester.pumpAndSettle();
        expect(find.text(masked), findsOneWidget);
      });
    });
    group('enabled', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        const enabled = false;
        await tester.pumpWidget(WellFormed.app(
          [EmailField(enabled: enabled)],
        ));
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).enabled, enabled);
      });
      testWidgets('len ctor', (WidgetTester tester) async {
        const enabled = false;
        await tester.pumpWidget(WellFormed.app([
          EmailField.len(50, enabled: enabled),
        ]));
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).enabled, enabled);
      });
    });
    group('scrollPadding', () {
      testWidgets('default ctor', (WidgetTester tester) async {
        const scrollPadding = EdgeInsets.all(40.0);
        await tester.pumpWidget(WellFormed.app([
          EmailField(scrollPadding: scrollPadding),
        ]));
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).scrollPadding, scrollPadding);
      });
      testWidgets('len ctor', (WidgetTester tester) async {
        const scrollPadding = EdgeInsets.all(40.0);
        await tester.pumpWidget(WellFormed.app([
          EmailField.len(50, scrollPadding: scrollPadding),
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
            EmailField(enableInteractiveSelection: false),
          ]),
        );
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).enableInteractiveSelection, false);
      });
      testWidgets('len ctor', (WidgetTester tester) async {
        await tester.pumpWidget(
          WellFormed.app([
            EmailField(enableInteractiveSelection: false),
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
          EmailField(autovalidateMode: mode),
        ]));
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextFormField));
        expect((elem as TextFormField).autovalidateMode, mode);
      });
      testWidgets('autoValidateMode', (WidgetTester tester) async {
        const mode = AutovalidateMode.onUserInteraction;
        await tester.pumpWidget(WellFormed.app([
          EmailField.len(50, autovalidateMode: mode),
        ]));
        await tester.pumpAndSettle();
        final elem = tester.widget(find.byType(TextFormField));
        expect((elem as TextFormField).autovalidateMode, mode);
      });
    });
  });
}
