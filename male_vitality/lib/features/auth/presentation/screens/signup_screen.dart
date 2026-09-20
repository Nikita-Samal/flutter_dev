import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../common/colors/app_colors.dart';
import '../../../../common/extensions/context_extensions.dart';
import '../../../../common/widgets/buttons/app_button.dart';
import '../../../../common/widgets/cards/app_card.dart';
import '../../../../common/widgets/inputs/app_text_field.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/validators.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

/// Clinical Sign Up Screen
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _agreedToHipaa = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitSignUp() {
    if (!_agreedToHipaa) {
      context.showSnackBar(
        'Please review and agree to HIPAA medical consent to proceed.',
        isError: true,
      );
      return;
    }

    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
            SignUpSubmitted(
              firstName: _firstNameController.text.trim(),
              lastName: _lastNameController.text.trim(),
              email: _emailController.text.trim(),
              password: _passwordController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthenticatedNeedsOnboarding || state is Authenticated) {
          context.go(AppRoutes.onboarding);
        } else if (state is AuthFailureState) {
          context.showSnackBar(state.message, isError: true);
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20.0),
              color: AppColors.primary,
              onPressed: () => context.go(AppRoutes.login),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: AppSpacing.screenPadding,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Text(
                      'Create Health Profile',
                      style: AppTextStyles.displaySmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    AppSpacing.verticalXs,
                    Text(
                      'Join MaleVitality to unlock precision health protocols tailored to your age and biomarkers.',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.slate500,
                      ),
                    ),
                    AppSpacing.verticalLg,

                    // Form Card
                    AppCard(
                      padding: AppSpacing.cardPaddingRelaxed,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // First and Last Name row
                          Row(
                            children: [
                              Expanded(
                                child: AppTextField(
                                  controller: _firstNameController,
                                  label: 'First Name',
                                  hintText: 'e.g. David',
                                  textInputAction: TextInputAction.next,
                                  validator: (val) => Validators.required(
                                    val,
                                    'First name required',
                                  ),
                                ),
                              ),
                              AppSpacing.horizontalMd,
                              Expanded(
                                child: AppTextField(
                                  controller: _lastNameController,
                                  label: 'Last Name',
                                  hintText: 'e.g. Miller',
                                  textInputAction: TextInputAction.next,
                                  validator: (val) => Validators.required(
                                    val,
                                    'Last name required',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          AppSpacing.verticalMd,

                          // Email
                          AppTextField(
                            controller: _emailController,
                            label: 'Clinical Email',
                            hintText: 'david.miller@example.com',
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            prefixIcon: const Icon(
                              Icons.mail_outline_rounded,
                              color: AppColors.slate400,
                              size: 20.0,
                            ),
                            validator: Validators.email,
                          ),
                          AppSpacing.verticalMd,

                          // Password
                          AppTextField(
                            controller: _passwordController,
                            label: 'Create Secure Password',
                            hintText: 'Min. 8 characters with numbers',
                            obscureText: _obscurePassword,
                            textInputAction: TextInputAction.next,
                            prefixIcon: const Icon(
                              Icons.lock_outline_rounded,
                              color: AppColors.slate400,
                              size: 20.0,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: AppColors.slate400,
                                size: 20.0,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            validator: Validators.password,
                          ),
                          AppSpacing.verticalMd,

                          // Confirm Password
                          AppTextField(
                            controller: _confirmPasswordController,
                            label: 'Confirm Password',
                            hintText: 'Re-enter your password',
                            obscureText: _obscurePassword,
                            textInputAction: TextInputAction.done,
                            prefixIcon: const Icon(
                              Icons.lock_reset_rounded,
                              color: AppColors.slate400,
                              size: 20.0,
                            ),
                            validator: (val) {
                              if (val != _passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          AppSpacing.verticalMd,

                          // HIPAA & Medical Terms Consent Checkbox
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 24.0,
                                height: 24.0,
                                child: Checkbox(
                                  value: _agreedToHipaa,
                                  activeColor: AppColors.secondary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  onChanged: (val) {
                                    setState(() {
                                      _agreedToHipaa = val ?? false;
                                    });
                                  },
                                ),
                              ),
                              AppSpacing.horizontalSm,
                              Expanded(
                                child: Text(
                                  'I consent to secure digital health records handling under HIPAA standards and agree to the MaleVitality Terms of Service.',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.slate600,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          AppSpacing.verticalLg,

                          // Submit Action
                          AppButton(
                            text: 'Continue to Health Intake',
                            isLoading: isLoading,
                            onPressed: isLoading ? null : _submitSignUp,
                          ),
                        ],
                      ),
                    ),
                    AppSpacing.verticalLg,

                    Center(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            'Already registered with MaleVitality? ',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.slate600,
                            ),
                          ),
                          TextButton(
                            onPressed: () => context.go(AppRoutes.login),
                            child: Text(
                              'Sign In',
                              style: AppTextStyles.labelLarge.copyWith(
                                color: AppColors.secondary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
