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
            child: WellFormed.scroll(
              [
                BasicTextField(
                  trim: true,
                  blank: 'Please fill in this field',
                ),
                DigitField(blank: 'Please enter the digits'),
              ],
              submit: (onSubmit) {
                return ElevatedButton(
                  // tooltip: 'Send',
                  onPressed: onSubmit,
                  child: const Icon(Icons.send),
                );
              },
              reset: (onReset) {
                return IconButton(
                  onPressed: onReset,
                  icon: const Icon(Icons.clear_all),
                );
              },
            ),
            // child: SingleChildScrollView(
            //     child: Column(children: [
            //   WellFormed.btn(
            //     [
            //       BasicTextField(
            //         trim: true,
            //         blank: 'Please fill in this field',
            //       ),
            //       DigitField(blank: 'Please enter the digits'),
            //     ],
            //   ),
            //   WellFormed(
            //     [
            //       BasicTextField(
            //         trim: true,
            //         blank: 'Please fill in this field',
            //       ),
            //       DigitField(blank: 'Please enter the digits'),
            //     ],
            //     submit: (onSubmit) {
            //       return IconButton(
            //         tooltip: 'Send',
            //         onPressed: onSubmit,
            //         icon: const Icon(Icons.send),
            //       );
            //     },
            //   )
            // ])),
          ),
        ),
      ),
    );
  }
}
