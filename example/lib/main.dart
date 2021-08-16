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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple form demo',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Cyan().color,
          elevation: 0.0,
          title: const Text('A Form and its fields'),
        ),
        body: Center(
          child: SizedBox(
            width: 350,
            child: WellFormed.btn([
              DigitField.len(
                5,
                diff: 'Please enter exactly 5 digits; for example, "22335".',
                blank: 'Please enter the 5 digits',
                decoration: const InputDecoration(labelText: 'Enter 5 digits'),
              ),
              CepField(
                blank: 'Please enter the CEP value',
                decoration: const InputDecoration(
                  labelText: 'Insert a CEP',
                ),
              ),
              IntField.pos(
                blank: 'Please informe the positive integer',
                decoration: const InputDecoration(
                  labelText: 'Insert a positive interger',
                ),
              ),
              EmailField.len(
                50,
                blank: 'Please inform the email address',
                long: 'The email is too long.',
                decoration: const InputDecoration(
                  labelText: 'Enter an email with up to 50 characters',
                ),
              ),
              CpfField(
                blank: 'A CPF value is required',
                malformed: 'Invalid CPF',
                decoration: const InputDecoration(
                  labelText: 'Enter a CPF',
                  hintText: '999.999.999-99',
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
