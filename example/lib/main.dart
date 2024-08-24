import 'package:eo_color/eo_color.dart';
import 'package:flutter/material.dart';
import 'package:well_formed/well_formed.dart';

void main() {
  runApp(const _DemoApp());
}

/// Demo purposes form app widget.
class _DemoApp extends StatelessWidget {
  /// Ctor.
  const _DemoApp({Key? key}) : super(key: key);

  static final _labelStyle = TextStyle(color: const Grey.veryDark().color);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple form demo',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Cyan().color,
          elevation: 0.0,
          title: const Text('Well_Formed Showcase App'),
        ),
        body: Center(
          child: SizedBox(
            width: 350,
            child: WellFormed.btn([
              DigitField.len(
                5,
                diff: 'Please enter exactly 5 digits. For example: "22335".',
                blank: 'Please enter the 5 digits.',
                decoration: InputDecoration(
                  labelText: 'Enter 5 digits',
                  labelStyle: _labelStyle,
                ),
              ),
              IntField.pos(
                blank: 'Please enter a positive integer',
                decoration: InputDecoration(
                  labelText: 'Enter a positive interger',
                  labelStyle: _labelStyle,
                ),
              ),
              EmailField.len(
                50,
                blank: 'Please inform the email address.',
                long: 'The email is too long',
                decoration: InputDecoration(
                  labelText: 'Enter an email with up to 50 characters',
                  labelStyle: _labelStyle,
                ),
              ),
              CpfField(
                blank: 'A CPF value is required.',
                malformed: 'Invalid CPF',
                decoration: InputDecoration(
                  labelText: 'Enter a CPF',
                  hintText: '999.999.999-99',
                  labelStyle: _labelStyle,
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
