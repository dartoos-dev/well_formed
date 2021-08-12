import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formdator/formdator.dart';
import 'package:well_formed/well_formed.dart';

/// Retrives a validator from widget fields.
class GetVal {
  /// Ctor.
  const GetVal(this._tester);

  final WidgetTester _tester;

  /// Forwards to [from].
  Future<ValStr> call(Widget field) async => from(field);

  /// Retrives the validator from [field].
  Future<ValStr> from(Widget field) async {
    await _tester.pumpWidget(WellFormed.app([field]));
    await _tester.pumpAndSettle();
    final elem = _tester.widget(find.byType(TextFormField));
    final val = (elem as TextFormField).validator;
    if (val == null) {
      throw AssertionError('validator cannot be null in this test case');
    }
    return val;
  }
}
