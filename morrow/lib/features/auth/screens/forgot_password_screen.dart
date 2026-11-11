import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:email_validator/email_validator.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/app_utils.dart';
import '../services/auth_service.dart';
import '../widgets/morrow_text_field.dart';
import '../widgets/primary_auth_button.dart';

/// Forgot Password Screen
///
/// Allows users to trigger a Firebase password-reset email.
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  bool _isLoading = false;
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendResetEmail() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    setState(() => _isLoading = true);

    final error = await AuthService.instance
        .sendPasswordResetEmail(_emailController.text);

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (error != null) {
      AppUtils.showSnackBar(context, error.errorMessage!, isError: true);
    } else {
      setState(() => _emailSent = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          color: AppColors.textPrimary,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: _emailSent ? _buildSuccessState() : _buildFormState(),
          ),
        ),
      ),
    );
  }

  Widget _buildFormState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        // Icon
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.peachLight.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.lock_reset_rounded,
            color: AppColors.primary,
            size: 28,
          ),
        ).animate().fadeIn(duration: 500.ms).scale(begin: const Offset(0.8, 0.8)),
        const SizedBox(height: 24),
        Text(
          'Reset Password',
          style: AppTextStyles.headlineLarge,
        ).animate().fadeIn(duration: 400.ms, delay: 100.ms).slideY(begin: 0.2, end: 0),
        const SizedBox(height: 10),
        Text(
          "Enter your email address and we'll send you a link to reset your password.",
          style: AppTextStyles.bodyMedium,
        ).animate().fadeIn(duration: 400.ms, delay: 150.ms),
        const SizedBox(height: 36),
        Form(
          key: _formKey,
          child: MorrowTextField(
            controller: _emailController,
            labelText: 'Email Address',
            hintText: 'you@example.com',
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.email],
            autocorrect: false,
            enabled: !_isLoading,
            prefixIcon: const Icon(Icons.email_outlined, size: 20),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your email address.';
              }
              if (!EmailValidator.validate(value.trim())) {
                return 'Please enter a valid email address.';
              }
              return null;
            },
            onFieldSubmitted: (_) => _sendResetEmail(),
          ),
        ).animate().fadeIn(duration: 400.ms, delay: 200.ms),
        const SizedBox(height: 28),
        PrimaryAuthButton(
          label: 'Send Reset Link',
          onPressed: _isLoading ? null : _sendResetEmail,
          isLoading: _isLoading,
        ).animate().fadeIn(duration: 400.ms, delay: 250.ms),
        const SizedBox(height: 24),
        Center(
          child: TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Back to Sign In',
              style: AppTextStyles.link,
            ),
          ),
        ).animate().fadeIn(duration: 400.ms, delay: 300.ms),
      ],
    );
  }

  Widget _buildSuccessState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: AppColors.successLight,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.mark_email_read_outlined,
            color: AppColors.success,
            size: 48,
          ),
        )
            .animate()
            .fadeIn(duration: 500.ms)
            .scale(begin: const Offset(0.5, 0.5)),
        const SizedBox(height: 32),
        Text(
          'Check Your Email',
          style: AppTextStyles.headlineLarge,
          textAlign: TextAlign.center,
        ).animate().fadeIn(duration: 400.ms, delay: 200.ms),
        const SizedBox(height: 12),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: AppTextStyles.bodyMedium,
            children: [
              const TextSpan(
                text: "We've sent a password reset link to\n",
              ),
              TextSpan(
                text: _emailController.text.trim(),
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ).animate().fadeIn(duration: 400.ms, delay: 300.ms),
        const SizedBox(height: 48),
        PrimaryAuthButton(
          label: 'Back to Sign In',
          onPressed: () => Navigator.of(context).pop(),
        ).animate().fadeIn(duration: 400.ms, delay: 400.ms),
        const SizedBox(height: 20),
        TextButton(
          onPressed: _sendResetEmail,
          child: Text(
            "Didn't receive the email? Resend",
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.primary,
            ),
          ),
        ).animate().fadeIn(duration: 400.ms, delay: 500.ms),
      ],
    );
  }
}
