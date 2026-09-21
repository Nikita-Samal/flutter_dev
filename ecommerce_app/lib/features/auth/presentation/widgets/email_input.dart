import 'package:flutter/material.dart';
import 'package:nikita/common/validators/app_validators.dart';
import 'package:nikita/common/widgets/custom_text_field.dart';

class EmailInput extends StatelessWidget {
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final VoidCallback? onEditingComplete;
  
  const EmailInput({
    super.key,
    required this.controller,
    this.textInputAction = TextInputAction.next,
    this.onEditingComplete,
  });
  
  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: 'Email Address',
      hint: 'Enter your email',
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      textInputAction: textInputAction,
      prefixIcon: const Icon(Icons.email_outlined),
      validator: AppValidators.validateEmail,
    );
  }
}
