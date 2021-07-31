import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:well_formed/well_formed.dart';
import 'to_basic_text_field.dart';

/// The minimum amount of properties that a form field must support.
typedef ToField = Widget Function({
  Key? key,
  TextEditingController? controller,
  String? initialValue,
  InputDecoration? decoration,
  TextInputAction? textInputAction,
  TextStyle? style,
  TextDirection? textDirection,
  TextAlign textAlign,
  bool readOnly,
  bool obscureText,
  bool autocorrect,
  String obscuringCharacter,
  int? maxLength,
  TextInputType? keyboardType,
  ValueChanged<String>? onChanged,
  VoidCallback? onEditingComplete,
  ValueChanged<String>? onFieldSubmitted,
  FormFieldSetter<String>? onSaved,
  FormFieldValidator<String>? validator,
  List<TextInputFormatter>? inputFormatters,
  bool? enabled,
  EdgeInsets scrollPadding,
  bool enableInteractiveSelection,
  AutovalidateMode? autovalidateMode,
});

/// Basic Properties Tester — Checks 24 properties of a text form field.
///
/// These properties are:
///
/// - Key? key, TextEditingController? controller, String? initialValue;
/// - InputDecoration? decoration, TextInputAction? textInputAction;
/// - TextStyle? style, TextDirection? textDirection, TextAlign textAlign;
/// - bool readOnly, bool obscureText, bool autocorrect, String obscuringCharacter;
/// - int? maxLength, TextInputType? keyboardType, ValueChanged<String>? onChanged;
/// - VoidCallback? onEditingComplete, ValueChanged<String>? onFieldSubmitted;
/// - FormFieldSetter<String>? onSaved, FormFieldValidator<String>? validator;
/// - List<TextInputFormatter>? inputFormatters, bool? enabled, EdgeInsets scrollPadding;
/// - bool enableInteractiveSelection, AutovalidateMode?  autovalidateMode.
class PropsTester {
  /// It sets the [ToField] function and the group title value.
  PropsTester(this._toField, this._title);

  /// Test cases for the [BasicTextField] class having [title] as the title of
  /// the test case group.
  PropsTester.basic({String title = 'BasicTextField'})
      : this(ToBasicTextField(), title);

  /// The title of the test cases group.
  final String _title;

  /// The widget that somehow builds a [TextField].
  final ToField _toField;

  /// Run the entire test suite at once.
  Future<void> run() async {
    group(_title, () {
      testWidgets('key', (WidgetTester tester) async {
        const testKey = Key('K');
        await tester.pumpWidget(FormFieldTester(_toField(key: testKey)));
        expect(find.byKey(testKey), findsOneWidget);
      });
      testWidgets('controller', (WidgetTester tester) async {
        const init = 'Initial Text';
        final controller = TextEditingController(text: init);
        await tester.pumpWidget(
          FormFieldTester(_toField(controller: controller)),
        );
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).controller, controller);
        expect(find.text(init), findsOneWidget);
      });
      testWidgets('initialValue', (WidgetTester tester) async {
        const init = '1234567890-ABCDEFGHIJKLMNOPQRSTUVXWYZ';
        await tester.pumpWidget(
          FormFieldTester(_toField(initialValue: init)),
        );
        expect(find.text(init), findsOneWidget);
      });
      testWidgets('decoration', (WidgetTester tester) async {
        const label = 'Required';
        await tester.pumpWidget(
          FormFieldTester(
            _toField(
              decoration: const InputDecoration(
                labelText: label,
                icon: Icon(Icons.code),
              ),
            ),
          ),
        );
        expect(find.text(label), findsOneWidget);
      });
      testWidgets('textInputAction', (WidgetTester tester) async {
        await tester.pumpWidget(
          FormFieldTester(_toField(textInputAction: TextInputAction.go)),
        );
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).textInputAction, TextInputAction.go);
      });
      testWidgets('style', (WidgetTester tester) async {
        const style = TextStyle();
        await tester.pumpWidget(
          FormFieldTester(_toField(style: style)),
        );
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).style, style);
      });
      testWidgets('textDirection', (WidgetTester tester) async {
        const textDirection = TextDirection.rtl;
        await tester.pumpWidget(
          FormFieldTester(_toField(textDirection: textDirection)),
        );
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).textDirection, textDirection);
      });
      testWidgets('textAlign', (WidgetTester tester) async {
        const textAlign = TextAlign.justify;
        await tester.pumpWidget(
          FormFieldTester(_toField(textAlign: textAlign)),
        );
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).textAlign, textAlign);
      });
      testWidgets('readOnly', (WidgetTester tester) async {
        const readOnly = true;
        await tester.pumpWidget(
          FormFieldTester(_toField(readOnly: readOnly)),
        );
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).readOnly, readOnly);
      });
      testWidgets('obscureText', (WidgetTester tester) async {
        const obscureText = true;
        await tester.pumpWidget(
          FormFieldTester(_toField(obscureText: obscureText)),
        );
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).obscureText, obscureText);
      });
      testWidgets('autocorrect', (WidgetTester tester) async {
        const autocorrect = false;
        await tester.pumpWidget(
          FormFieldTester(_toField(autocorrect: autocorrect)),
        );
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).autocorrect, autocorrect);
      });
      testWidgets('obscuringCharacter', (WidgetTester tester) async {
        const obscuringCharacter = '*';
        await tester.pumpWidget(
          FormFieldTester(_toField(obscuringCharacter: obscuringCharacter)),
        );
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).obscuringCharacter, obscuringCharacter);
      });
      testWidgets('maxLength', (WidgetTester tester) async {
        const maxLength = 10;
        await tester.pumpWidget(
          FormFieldTester(_toField(maxLength: maxLength)),
        );
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).maxLength, maxLength);
      });
      testWidgets('keyboardType', (WidgetTester tester) async {
        const keyboardType = TextInputType.phone;
        await tester.pumpWidget(
          FormFieldTester(_toField(keyboardType: keyboardType)),
        );
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).keyboardType, keyboardType);
      });
      testWidgets('onChanged', (WidgetTester tester) async {
        final key = UniqueKey();
        var count = 0;
        await tester.pumpWidget(
          FormFieldTester(_toField(key: key, onChanged: (String s) => ++count)),
        );
        await tester.enterText(find.byKey(key), 'abc');
        await tester.pumpAndSettle();
        // final elem = tester.widget(find.byType(TextField));
        expect(count, 1);
      });
      testWidgets('onEditingComplete', (WidgetTester tester) async {
        void onEdit() {}

        await tester.pumpWidget(
          FormFieldTester(_toField(onEditingComplete: onEdit)),
        );
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).onEditingComplete, onEdit);
      });
      testWidgets('onFieldSubmitted', (WidgetTester tester) async {
        final key = UniqueKey();
        void onSubmit(String s) {}
        await tester.pumpWidget(
          FormFieldTester(_toField(key: key, onFieldSubmitted: onSubmit)),
        );
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).onSubmitted, onSubmit);
      });
      testWidgets('onSaved', (WidgetTester tester) async {
        final key = UniqueKey();
        void onSaved(String? s) {}
        await tester.pumpWidget(
          FormFieldTester(_toField(key: key, onSaved: onSaved)),
        );
        final elem = tester.widget(find.byType(TextFormField));
        expect((elem as TextFormField).onSaved, onSaved);
      });
      testWidgets('validator', (WidgetTester tester) async {
        String? valid(String? s) => null;
        await tester.pumpWidget(FormFieldTester(_toField(validator: valid)));
        final elem = tester.widget(find.byType(TextFormField));
        expect((elem as TextFormField).validator, valid);
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
          FormFieldTester(_toField(key: key, inputFormatters: formatters)),
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
          FormFieldTester(_toField(enabled: enabled)),
        );
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).enabled, enabled);
      });
      testWidgets('scrollPadding', (WidgetTester tester) async {
        const scrollPadding = EdgeInsets.all(40.0);
        await tester.pumpWidget(
          FormFieldTester(_toField(scrollPadding: scrollPadding)),
        );
        final elem = tester.widget(find.byType(TextField));
        expect((elem as TextField).scrollPadding, scrollPadding);
      });
      testWidgets('enableInteractiveSelection', (WidgetTester tester) async {
        const enableInteractiveSelection = false;
        await tester.pumpWidget(
          FormFieldTester(
            _toField(enableInteractiveSelection: enableInteractiveSelection),
          ),
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
          FormFieldTester(_toField(autovalidateMode: autoValidateMode)),
        );
        final elem = tester.widget(find.byType(TextFormField));
        expect((elem as TextFormField).autovalidateMode, autoValidateMode);
      });
    });
  }
}
