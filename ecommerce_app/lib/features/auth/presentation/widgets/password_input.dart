import 'package:flutter/material.dart';
import 'package:nikita/common/validators/app_validators.dart';
import 'package:nikita/common/widgets/custom_text_field.dart';

class PasswordInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final TextInputAction textInputAction;
  final VoidCallback? onEditingComplete;
  
  const PasswordInput({
    super.key,
    required this.controller,
    this.label = 'Password',
    this.textInputAction = TextInputAction.done,
    this.onEditingComplete,
  });
  
  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _obscure = true;
  
  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: widget.label,
      hint: 'Enter your password',
      controller: widget.controller,
      obscureText: _obscure,
      textInputAction: widget.textInputAction,
      prefixIcon: const Icon(Icons.lock_outlined),
      suffixIcon: IconButton(
        icon: Icon(_obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
        onPressed: () => setState(() => _obscure = !_obscure),
      ),
      validator: AppValidators.validatePassword,
    );
  }
}
