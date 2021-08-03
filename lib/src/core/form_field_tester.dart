import 'package:flutter/material.dart';

/// Widget for testing form field widgets.
///
/// This testing widget is intended to encapsulate form fields whithin a [Form]
/// instance. In addition, it provides a clear and submit buttons so that both
/// the testing framework and humans can interact with the form components.
class FormFieldTester extends StatelessWidget {
  /// For a single form field.
  FormFieldTester(
    Widget field, {
    Key? submitKey,
    Key? clearKey,
    Key? key,
  }) : this.many([field], submitKey: submitKey, clearKey: clearKey, key: key);

  /// Form tester for two or more fields.
  ///
  /// [child] the content of the form element; [submit] the key to facilitate the location of
  /// the submit button; [clear] the key to facilitate the location of the
  /// clear button.
  FormFieldTester.many(
    List<Widget> fields, {
    Key? submitKey,
    Key? clearKey,
    Key? key,
  })  : _fields = fields,
        _submitKey = submitKey,
        _clearKey = clearKey,
        super(key: key);

  /// the field to be tested.
  final List<Widget> _fields;
  final Key? _submitKey;
  final Key? _clearKey;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Testing Form',
      home: SafeArea(
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: 350,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      ..._fields,
                      ButtonBar(
                        children: [
                          TextButton(
                            key: _clearKey,
                            onPressed: _reset,
                            child: const Text('Clear'),
                          ),
                          ElevatedButton(
                            key: _submitKey,
                            onPressed: _submit,
                            child: const Text('Submit'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _reset() => _formKey.currentState?.reset();
  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
    }
  }
}
