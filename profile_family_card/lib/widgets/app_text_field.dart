import 'package:flutter/material.dart';

class ZmlAppTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final ValueChanged<String>? onChanged;

  const ZmlAppTextField({
    super.key,
    required this.label,
    this.hint,
    this.onChanged, required String hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
      ),
    );
  }
}