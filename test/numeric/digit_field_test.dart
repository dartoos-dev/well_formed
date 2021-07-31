import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:well_formed/well_formed.dart';

void main() {
  group('DigitField', () {
    testWidgets('key', (WidgetTester tester) async {
      const testKey = Key('K');
      await tester.pumpWidget(FormFieldTester(DigitField(key: testKey)));
      expect(find.byKey(testKey), findsOneWidget);
    });
    testWidgets('inputDecoration', (WidgetTester tester) async {
      const label = 'Digits';
      await tester.pumpWidget(
        FormFieldTester(
          DigitField(
            decoration: const InputDecoration(
              labelText: label,
              icon: Icon(Icons.code),
            ),
          ),
        ),
      );
      expect(find.text(label), findsOneWidget);
    });
    testWidgets('initialValue', (WidgetTester tester) async {
      const init = '1234';
      await tester.pumpWidget(
        FormFieldTester(DigitField(initialValue: init)),
      );
      expect(find.text(init), findsOneWidget);
    });
    // testWidgets('blank', (WidgetTester tester) async {
    //   final key = UniqueKey();
    //   await tester.pumpWidget(
    //     MaterialApp(
    //       home: Scaffold(body: DigitField()),
    //     ),
    //   );
    //   // Enter the empty String '' into the form field.
    //   tester.enterText(find.byKey(key), '');
    //   // Rebuild the widget after the state has changed.
    //   tester.pump();
    //   // expect(find.text(init), findsOneWidget);
    // });
  });
}
