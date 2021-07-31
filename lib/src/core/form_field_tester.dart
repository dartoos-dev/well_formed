import 'package:flutter/material.dart';

/// Widget for testing form field widgets.
///
/// This testing widget is intended to encapsulate one of the form fields
/// whithin a [Form] instance at a time. In addition, it provides a clear and
/// submit buttons so that the testing framework interact with the form
/// components.
class FormFieldTester extends StatelessWidget {
  /// [child] the content of the form element; [submit] the key to facilitate the location of
  /// the submit button; [clear] the key to facilitate the location of the
  /// clear button.
  FormFieldTester(Widget field, {Key? submitKey, Key? clearKey, Key? key})
      : _field = field,
        _submitKey = submitKey,
        _clearKey = clearKey,
        super(key: key);

  /// the field to be tested.
  final Widget _field;
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
                    children: [
                      _field,
                      ButtonBar(
                        children: [
                          TextButton(
                            key: _clearKey,
                            onPressed: () {
                              _formKey.currentState?.reset();
                            },
                            child: const Text('Clear'),
                          ),
                          ElevatedButton(
                            key: _submitKey,
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                _formKey.currentState?.save();
                              }
                            },
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
}
