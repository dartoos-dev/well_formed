import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formdator/logic.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:well_formed/well_formed.dart';

Future<void> main() async {
  // await PropsTester.basic().run();
  group('BasicTextField', () {
    const empty = ''; // zero-length text.
    const blank = 'this field is required';
    const short = 'few';
    const long = 'There are certainly more than ten chars in this sentence.';
    const less = 'the text is too short';
    const great = 'the text is too long';
    const tenCharText = 'ten chars.';
    const kDef = Key('()');
    const kLen = Key('len');
    const kMin = Key('min');
    const kMax = Key('max');
    const kRange = Key('range');
    const keys = <Key>[kDef, kLen, kMin, kMax, kRange];
    const init = 'The initial text of ()';
    const initLen = 'The initial text of len';
    const initMin = 'The initial text of min';
    const initMax = 'The initial text of max';
    const initRange = 'The initial text of range';
    const inits = [init, initLen, initMin, initMax, initRange];
    testWidgets('length constraint', (WidgetTester tester) async {
      const diff = 'length error';
      await tester.pumpWidget(
        WellFormed.app([BasicTextField.len(10, diff: diff)]),
      );
      final elem = tester.widget(find.byType(TextFormField));
      final val = (elem as TextFormField).validator!;
      expect(val(null), null);
      expect(val(empty), diff);
      expect(val(tenCharText), null);
      expect(val(short), diff);
      expect(val(long), diff);
    });
    testWidgets('min length constraint', (WidgetTester tester) async {
      await tester.pumpWidget(
        WellFormed.app([BasicTextField.min(10, less: less)]),
      );
      final elem = tester.widget(find.byType(TextFormField));
      final val = (elem as TextFormField).validator!;
      expect(val(null), null);
      expect(val(empty), less);
      expect(val(tenCharText), null);
      expect(val(short), less);
      expect(val(long), null);
    });
    testWidgets('max length constraint', (WidgetTester tester) async {
      await tester.pumpWidget(
        WellFormed.app([BasicTextField.max(10, great: great)]),
      );
      final elem = tester.widget(find.byType(TextFormField));
      final val = (elem as TextFormField).validator!;
      expect(val(null), null);
      expect(val(empty), null);
      expect(val(tenCharText), null);
      expect(val(short), null);
      expect(val(long), great);
    });
    testWidgets('range length constraint', (WidgetTester tester) async {
      await tester.pumpWidget(
        WellFormed.app(
            [BasicTextField.range(10, 20, less: less, great: great)]),
      );
      final elem = tester.widget(find.byType(TextFormField));
      final val = (elem as TextFormField).validator!;
      expect(val(null), null);
      expect(val(empty), less);
      expect(val(tenCharText), null);
      expect(val(short), less);
      expect(val(long), great);
    });
    testWidgets('key', (WidgetTester tester) async {
      await tester.pumpWidget(WellFormed.app([
        BasicTextField(key: kDef),
        BasicTextField.len(10, key: kLen),
        BasicTextField.min(10, key: kMin),
        BasicTextField.max(10, key: kMax),
        BasicTextField.range(10, 20, key: kRange)
      ]));
      await tester.pumpAndSettle();
      for (final key in keys) {
        expect(find.byKey(key), findsOneWidget);
      }
    });
    testWidgets('blank', (WidgetTester tester) async {
      await tester.pumpWidget(WellFormed.app([
        BasicTextField(blank: blank),
        BasicTextField.len(10, blank: blank),
        BasicTextField.min(10, blank: blank),
        BasicTextField.max(10, blank: blank),
        BasicTextField.range(10, 20, blank: blank)
      ]));
      await tester.pumpAndSettle();
      final elems = tester.widgetList(find.byType(TextFormField));
      for (final elem in elems) {
        final val = (elem as TextFormField).validator!;
        expect(val(null), blank);
        expect(val(empty), blank);
        expect(val(tenCharText), null);
      }
    });
    testWidgets('validator', (WidgetTester tester) async {
      const error = 'cannot have uppercase letters [A-Z]';

      /// Input values cannot have uppercase letters.
      String? noUppercase(String? v) =>
          (v != null && v.contains(RegExp('[A-Z]+'))) ? error : null;
      await tester.pumpWidget(WellFormed.app([
        BasicTextField(validator: noUppercase),
        BasicTextField.len(13, validator: noUppercase),
        BasicTextField.min(13, validator: noUppercase),
        BasicTextField.max(13, validator: noUppercase),
        BasicTextField.range(13, 26, validator: noUppercase),
      ]));
      await tester.pumpAndSettle();
      final elems = tester.widgetList(find.byType(TextFormField));
      for (final elem in elems) {
        final val = (elem as TextFormField).validator!;
        expect(val(null), null);
        expect(val('13 characters'), null);
        expect(val('13 Characters'), error);
      }
    });
    testWidgets('blank and validator', (WidgetTester tester) async {
      const error = 'it must always be invalid';
      const nok = Nok(error: error);
      await tester.pumpWidget(WellFormed.app([
        BasicTextField(blank: blank, validator: nok),
        BasicTextField.len(13, blank: blank, validator: nok),
        BasicTextField.min(13, blank: blank, validator: nok),
        BasicTextField.max(13, blank: blank, validator: nok),
        BasicTextField.range(13, 26, blank: blank, validator: nok),
      ]));
      await tester.pumpAndSettle();
      final elems = tester.widgetList(find.byType(TextFormField));
      for (final elem in elems) {
        final val = (elem as TextFormField).validator!;
        expect(val(null), blank);
        expect(val(empty), blank);
        expect(val('13 characters'), error);
        expect(val('13 Characters'), error);
      }
    });
    testWidgets('trim and onChanged', (WidgetTester tester) async {
      const trimmed = 'abcdefghijklm';
      const nonTrimmed = '\n $trimmed \t';
      var count = 0;
      void onChanged(String s) {
        if (s.contains(RegExp('^$trimmed\$'))) {
          ++count;
        }
      }

      await tester.pumpWidget(WellFormed.app([
        BasicTextField(key: kDef, trim: true, onChanged: onChanged),
        BasicTextField.len(10, key: kLen, trim: true, onChanged: onChanged),
        BasicTextField.min(10, key: kMin, trim: true, onChanged: onChanged),
        BasicTextField.max(10, key: kMax, trim: true, onChanged: onChanged),
        BasicTextField.range(10, 20,
            key: kRange, trim: true, onChanged: onChanged)
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
          BasicTextField(controller: TextEditingController(text: init)),
          BasicTextField.len(23,
              controller: TextEditingController(text: initLen)),
          BasicTextField.min(23,
              controller: TextEditingController(text: initMin)),
          BasicTextField.max(23,
              controller: TextEditingController(text: initMax)),
          BasicTextField.range(
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
          BasicTextField(initialValue: init),
          BasicTextField.len(23, initialValue: initLen),
          BasicTextField.min(23, initialValue: initMin),
          BasicTextField.max(23, initialValue: initMax),
          BasicTextField.range(15, 25, initialValue: initRange)
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
          BasicTextField(
            decoration: const InputDecoration(labelText: label),
          ),
          BasicTextField.len(
            23,
            decoration: const InputDecoration(labelText: labelLen),
          ),
          BasicTextField.min(
            23,
            decoration: const InputDecoration(labelText: labelMin),
          ),
          BasicTextField.max(
            23,
            decoration: const InputDecoration(labelText: labelMax),
          ),
          BasicTextField.range(
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
          BasicTextField(textInputAction: action),
          BasicTextField.len(23, textInputAction: actionLen),
          BasicTextField.min(23, textInputAction: actionMin),
          BasicTextField.max(23, textInputAction: actionMax),
          BasicTextField.range(15, 25, textInputAction: actionRange),
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
          BasicTextField(style: style),
          BasicTextField.len(23, style: style),
          BasicTextField.min(23, style: style),
          BasicTextField.max(23, style: style),
          BasicTextField.range(15, 25, style: style),
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
          BasicTextField(textDirection: textDirection),
          BasicTextField.len(23, textDirection: textDirection),
          BasicTextField.min(23, textDirection: textDirection),
          BasicTextField.max(23, textDirection: textDirection),
          BasicTextField.range(15, 25, textDirection: textDirection),
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
          BasicTextField(textAlign: textAlign),
          BasicTextField.len(23, textAlign: textAlign),
          BasicTextField.min(23, textAlign: textAlign),
          BasicTextField.max(23, textAlign: textAlign),
          BasicTextField.range(15, 25, textAlign: textAlign),
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
          BasicTextField(readOnly: readOnly),
          BasicTextField.len(23, readOnly: readOnly),
          BasicTextField.min(23, readOnly: readOnly),
          BasicTextField.max(23, readOnly: readOnly),
          BasicTextField.range(15, 25, readOnly: readOnly),
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
          BasicTextField(obscureText: obscureText),
          BasicTextField.len(23, obscureText: obscureText),
          BasicTextField.min(23, obscureText: obscureText),
          BasicTextField.max(23, obscureText: obscureText),
          BasicTextField.range(15, 25, obscureText: obscureText),
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
          BasicTextField(autocorrect: autocorrect),
          BasicTextField.len(23, autocorrect: autocorrect),
          BasicTextField.min(23, autocorrect: autocorrect),
          BasicTextField.max(23, autocorrect: autocorrect),
          BasicTextField.range(15, 25, autocorrect: autocorrect),
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
        WellFormed.app(
            [BasicTextField(obscuringCharacter: obscuringCharacter)]),
      );
      final elem = tester.widget(find.byType(TextField));
      expect((elem as TextField).obscuringCharacter, obscuringCharacter);
    });
    testWidgets('maxLength', (WidgetTester tester) async {
      const maxLength = 10;
      await tester.pumpWidget(
        WellFormed.app([BasicTextField(maxLength: maxLength)]),
      );
      final elem = tester.widget(find.byType(TextField));
      expect((elem as TextField).maxLength, maxLength);
    });
    testWidgets('keyboardType', (WidgetTester tester) async {
      const keyboardType = TextInputType.phone;
      await tester.pumpWidget(
        WellFormed.app([BasicTextField(keyboardType: keyboardType)]),
      );
      final elem = tester.widget(find.byType(TextField));
      expect((elem as TextField).keyboardType, keyboardType);
    });
    testWidgets('onEditingComplete', (WidgetTester tester) async {
      void onEdit() {}

      await tester.pumpWidget(
        WellFormed.app([BasicTextField(onEditingComplete: onEdit)]),
      );
      final elem = tester.widget(find.byType(TextField));
      expect((elem as TextField).onEditingComplete, onEdit);
    });
    testWidgets('onFieldSubmitted', (WidgetTester tester) async {
      final key = UniqueKey();
      void onSubmit(String s) {}
      await tester.pumpWidget(
        WellFormed.app([BasicTextField(key: key, onFieldSubmitted: onSubmit)]),
      );
      final elem = tester.widget(find.byType(TextField));
      expect((elem as TextField).onSubmitted, onSubmit);
    });
    testWidgets('onSaved', (WidgetTester tester) async {
      final key = UniqueKey();
      void onSaved(String? s) {}
      await tester.pumpWidget(
        WellFormed.app([BasicTextField(key: key, onSaved: onSaved)]),
      );
      final elem = tester.widget(find.byType(TextFormField));
      expect((elem as TextFormField).onSaved, onSaved);
    });
    testWidgets('inputFormatters', (WidgetTester tester) async {
      final key = UniqueKey();
      final formatters = [
        MaskTextInputFormatter(
          mask: '###.###.###-##',
          filter: {"#": RegExp(r'\d')},
        ),
      ];
      await tester.pumpWidget(
        WellFormed.app([BasicTextField(key: key, inputFormatters: formatters)]),
      );
      await tester.enterText(find.byKey(key), '99999999999');
      await tester.pumpAndSettle();
      final elem = tester.widget(find.byType(TextField));
      expect((elem as TextField).inputFormatters, formatters);
      expect(find.text('999.999.999-99'), findsOneWidget);
    });
    testWidgets('enabled', (WidgetTester tester) async {
      const enabled = false;
      await tester.pumpWidget(
        WellFormed.app([BasicTextField(enabled: enabled)]),
      );
      final elem = tester.widget(find.byType(TextField));
      expect((elem as TextField).enabled, enabled);
    });
    testWidgets('scrollPadding', (WidgetTester tester) async {
      const scrollPadding = EdgeInsets.all(40.0);
      await tester.pumpWidget(
        WellFormed.app([BasicTextField(scrollPadding: scrollPadding)]),
      );
      final elem = tester.widget(find.byType(TextField));
      expect((elem as TextField).scrollPadding, scrollPadding);
    });
    testWidgets('enableInteractiveSelection', (WidgetTester tester) async {
      const enableInteractiveSelection = false;
      await tester.pumpWidget(
        WellFormed.app([
          BasicTextField(
              enableInteractiveSelection: enableInteractiveSelection),
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
        WellFormed.app([BasicTextField(autovalidateMode: autoValidateMode)]),
      );
      final elem = tester.widget(find.byType(TextFormField));
      expect((elem as TextFormField).autovalidateMode, autoValidateMode);
    });
  });
}
