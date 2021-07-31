import 'package:flutter/material.dart';
import 'package:well_formed/well_formed.dart';

void main() {
  runApp(FormFieldTester(BasicTextField(trim: true, blank: 'Please fill in this field')));
}
