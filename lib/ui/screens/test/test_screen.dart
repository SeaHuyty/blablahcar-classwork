import 'package:blabla/ui/widgets/actions/bla_button.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const BlaButton(title: 'Contact Valodia', isPrimary: false,)
    );
  }
}