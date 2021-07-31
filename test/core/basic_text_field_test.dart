import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formdator/formdator.dart';
import 'package:well_formed/well_formed.dart';

import '../props_tester.dart';

Future<void> main() async {
  await PropsTester.basic().run();
  group('BasicTextField', () {
    testWidgets('blank', (WidgetTester tester) async {
      const blankMsg = 'this field is required';
      final key = UniqueKey();
      final submitKey = UniqueKey();
      final clearKey = UniqueKey();
      await tester.pumpWidget(
        FormFieldTester(
          BasicTextField(key: key, blank: blankMsg),
          submitKey: submitKey,
          clearKey: clearKey,
        ),
      );
      final elem = tester.widget(find.byType(TextFormField));
      final val = (elem as TextFormField).validator!;
      expect(val(null), blankMsg);
      expect(val(''), blankMsg);
      expect(val('non-empty text'), null);
    });
    testWidgets('validator', (WidgetTester tester) async {
      const error = 'must contain only lowercase letters [a-z]';

      /// validation to ensure that the input value has only lowercase letters
      /// and spaces.
      String? lowercaseOnly(String? v) {
        return (v != null && v.contains(RegExp('[^a-z ]'))) ? error : null;
      }

      final key = UniqueKey();
      final submitKey = UniqueKey();
      final clearKey = UniqueKey();
      await tester.pumpWidget(
        FormFieldTester(
          BasicTextField(key: key, validator: lowercaseOnly),
          submitKey: submitKey,
          clearKey: clearKey,
        ),
      );
      final elem = tester.widget(find.byType(TextFormField));
      final val = (elem as TextFormField).validator!;
      expect(val(null), null);
      expect(val(''), null);
      expect(val('lowecase only'), null);
      expect(val('there is a Single uppercase letter'), error);
      expect(val('numbers like 1 are also forbidden'), error);
    });
    testWidgets('blank and validator', (WidgetTester tester) async {
      const error = 'it must always be invalid';
      final key = UniqueKey();
      final submitKey = UniqueKey();
      final clearKey = UniqueKey();
      await tester.pumpWidget(
        FormFieldTester(
          BasicTextField(
              key: key, blank: error, validator: const Nok(error: error)),
          submitKey: submitKey,
          clearKey: clearKey,
        ),
      );
      final elem = tester.widget(find.byType(TextFormField));
      final val = (elem as TextFormField).validator!;
      expect(val(null), error);
      expect(val(''), error);
      expect(val('It does not matter if the field is filled in or not'), error);
      expect(val('it will always be evaluated as invalid'), error);
    });
  });
}
