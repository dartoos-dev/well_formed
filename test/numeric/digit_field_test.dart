import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:well_formed/well_formed.dart';
// import '../props_tester.dart';

Future<void> main() async {
  // await PropsTester.digit().run();
  group('DigitField', () {
    testWidgets('length constraint', (WidgetTester tester) async {
      const diff = 'length error';
      const tenCharText = '0123456789';
      const short = '123';
      const long = '00112233445566778899';
      await tester.pumpWidget(
        FormFieldTester(DigitField.len(10, diff: diff)),
      );
      final elem = tester.widget(find.byType(TextFormField));
      final val = (elem as TextFormField).validator!;
      expect(val(null), null);
      expect(val(tenCharText), null);
      expect(val(short), diff);
      expect(val(long), diff);
    });
    testWidgets('min length constraint', (WidgetTester tester) async {
      const less = 'too short text error';
      const tenChars = '0123456789';
      const tooShort = '999';
      const long = '99887766554433221100';
      await tester.pumpWidget(
        FormFieldTester(DigitField.min(10, less: less)),
      );
      final elem = tester.widget(find.byType(TextFormField));
      final val = (elem as TextFormField).validator!;
      expect(val(null), null);
      expect(val(tenChars), null);
      expect(val(tooShort), less);
      expect(val(long), null);
    });
    testWidgets('max length constraint', (WidgetTester tester) async {
      const great = 'too long length error';
      const tenChars = '0123456789';
      const short = '777';
      const tooLong = '99999999999';
      await tester.pumpWidget(
        FormFieldTester(DigitField.max(10, great: great)),
      );
      final elem = tester.widget(find.byType(TextFormField));
      final val = (elem as TextFormField).validator!;
      expect(val(null), null);
      expect(val(tenChars), null);
      expect(val(short), null);
      expect(val(tooLong), great);
    });
    testWidgets('range length constraint', (WidgetTester tester) async {
      const less = 'too short text error';
      const great = 'too long length error';
      const tenChars = '0123456789';
      const tooShort = '000';
      const tooLong = '000000000000000000000';
      await tester.pumpWidget(
        FormFieldTester(DigitField.range(10, 20, less: less, great: great)),
      );
      final elem = tester.widget(find.byType(TextFormField));
      final val = (elem as TextFormField).validator!;
      expect(val(null), null);
      expect(val(tenChars), null);
      expect(val(tooShort), less);
      expect(val(tooLong), great);
    });
  });
}
