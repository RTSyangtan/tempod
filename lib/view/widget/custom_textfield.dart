import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  const CustomTextField({super.key,required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
    decoration: InputDecoration(border: OutlineInputBorder(),labelText: label),
    );
  }
}
