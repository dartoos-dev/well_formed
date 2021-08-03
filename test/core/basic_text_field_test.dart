import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:well_formed/well_formed.dart';

import '../props_tester.dart';

Future<void> main() async {
  await PropsTester.basic().run();
  group('BasicTextField', () {
    testWidgets('length constraint', (WidgetTester tester) async {
      const diff = 'length error';
      const empty = ''; // zero-length text.
      const tenCharText = 'ten chars.';
      const short = 'Ten';
      const long =
          'There are certainly more than ten characters in this sentence.';
      await tester.pumpWidget(
        FormFieldTester(BasicTextField.len(10, diff: diff)),
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
      const less = 'too short text error';
      const empty = ''; // zero-length text.
      const tenChars = 'ten chars.';
      const tooShort = 'Ten';
      const long = 'There are more than ten characters in this sentence.';
      await tester.pumpWidget(
        FormFieldTester(BasicTextField.min(10, less: less)),
      );
      final elem = tester.widget(find.byType(TextFormField));
      final val = (elem as TextFormField).validator!;
      expect(val(null), null);
      expect(val(empty), less);
      expect(val(tenChars), null);
      expect(val(tooShort), less);
      expect(val(long), null);
    });
    testWidgets('max length constraint', (WidgetTester tester) async {
      const great = 'too long length error';
      const empty = ''; // zero-length text.
      const tenChars = 'ten chars.';
      const short = 'Ten';
      const tooLong = 'There are more than ten characters in this sentence.';
      await tester.pumpWidget(
        FormFieldTester(BasicTextField.max(10, great: great)),
      );
      final elem = tester.widget(find.byType(TextFormField));
      final val = (elem as TextFormField).validator!;
      expect(val(null), null);
      expect(val(empty), null);
      expect(val(tenChars), null);
      expect(val(short), null);
      expect(val(tooLong), great);
    });
    testWidgets('range length constraint', (WidgetTester tester) async {
      const less = 'too short text error';
      const great = 'too long length error';
      const empty = ''; // zero-length text.
      const tenChars = 'ten chars.';
      const tooShort = 'Ten';
      const tooLong = 'There are more than twenty characters in this sentence.';
      await tester.pumpWidget(
        FormFieldTester(BasicTextField.range(10, 20, less: less, great: great)),
      );
      final elem = tester.widget(find.byType(TextFormField));
      final val = (elem as TextFormField).validator!;
      expect(val(null), null);
      expect(val(empty), less);
      expect(val(tenChars), null);
      expect(val(tooShort), less);
      expect(val(tooLong), great);
    });
  });
}
