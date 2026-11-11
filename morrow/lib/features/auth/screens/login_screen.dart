import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:email_validator/email_validator.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/app_utils.dart';
import '../services/auth_service.dart';
import '../widgets/morrow_text_field.dart';
import '../widgets/primary_auth_button.dart';
import '../widgets/auth_divider.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';

/// Morrow Login Screen
///
/// Premium, warm maternal-care-inspired authentication experience.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  // ─── Actions ──────────────────────────────────────────────────────────────

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    setState(() => _isLoading = true);

    final result = await AuthService.instance.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (!result.success) {
      AppUtils.showSnackBar(context, result.errorMessage!, isError: true);
    }
    // On success, the authStateChanges stream in app.dart handles navigation.
  }

  void _navigateToForgotPassword() {
    Navigator.of(context).push(
      _fadeRoute(const ForgotPasswordScreen()),
    );
  }

  void _navigateToRegister() {
    Navigator.of(context).push(
      _fadeRoute(const RegisterScreen()),
    );
  }

  PageRoute<T> _fadeRoute<T>(Widget page) => PageRouteBuilder(
        pageBuilder: (context, a1, a2) => page,
        transitionsBuilder: (ctx, animation, a2, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: AppConstants.animationMedium,
      );

  // ─── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: size.height - 100),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height * 0.06),
                    _buildBrandHeader(),
                    const SizedBox(height: 40),
                    _buildWelcomeText(),
                    const SizedBox(height: 36),
                    _buildForm(),
                    const SizedBox(height: 28),
                    _buildForgotPassword(),
                    const SizedBox(height: 28),
                    _buildSignInButton(),
                    const SizedBox(height: 32),
                    const AuthDivider(),
                    const SizedBox(height: 28),
                    _buildSocialNote(),
                    const Spacer(),
                    const SizedBox(height: 32),
                    _buildRegisterRow(),
                    const SizedBox(height: 20),
                    _buildFooter(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ─── Sections ─────────────────────────────────────────────────────────────

  Widget _buildBrandHeader() {
    return Column(
      children: [
        // Brand mark — decorative petal motif
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: AppColors.primaryGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.3),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(
            Icons.favorite_rounded,
            color: Colors.white,
            size: 36,
          ),
        )
            .animate()
            .fadeIn(duration: 600.ms, delay: 100.ms)
            .scale(begin: const Offset(0.7, 0.7)),
        const SizedBox(height: 16),
        Text(
          'MORROW',
          style: AppTextStyles.brandTitle,
        )
            .animate()
            .fadeIn(duration: 600.ms, delay: 200.ms)
            .slideY(begin: 0.3, end: 0),
      ],
    );
  }

  Widget _buildWelcomeText() {
    return Column(
      children: [
        Text(
          'Welcome Back',
          style: AppTextStyles.headlineLarge,
          textAlign: TextAlign.center,
        )
            .animate()
            .fadeIn(duration: 500.ms, delay: 300.ms)
            .slideY(begin: 0.2, end: 0),
        const SizedBox(height: 8),
        Text(
          'Your motherhood journey continues here.',
          style: AppTextStyles.bodyMedium,
          textAlign: TextAlign.center,
        )
            .animate()
            .fadeIn(duration: 500.ms, delay: 400.ms)
            .slideY(begin: 0.2, end: 0),
      ],
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          MorrowTextField(
            controller: _emailController,
            focusNode: _emailFocus,
            labelText: 'Email Address',
            hintText: 'you@example.com',
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
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
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_passwordFocus);
            },
          ).animate().fadeIn(duration: 400.ms, delay: 450.ms).slideY(begin: 0.1, end: 0),
          const SizedBox(height: 16),
          MorrowTextField(
            controller: _passwordController,
            focusNode: _passwordFocus,
            labelText: 'Password',
            hintText: '••••••••',
            obscureText: _obscurePassword,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.password],
            enabled: !_isLoading,
            prefixIcon: const Icon(Icons.lock_outline_rounded, size: 20),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 20,
                color: AppColors.textHint,
              ),
              onPressed: () {
                setState(() => _obscurePassword = !_obscurePassword);
              },
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password.';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters.';
              }
              return null;
            },
            onFieldSubmitted: (_) => _signIn(),
          ).animate().fadeIn(duration: 400.ms, delay: 500.ms).slideY(begin: 0.1, end: 0),
        ],
      ),
    );
  }

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: _isLoading ? null : _navigateToForgotPassword,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          'Forgot Password?',
          style: AppTextStyles.link.copyWith(fontSize: 13),
        ),
      ),
    ).animate().fadeIn(duration: 400.ms, delay: 550.ms);
  }

  Widget _buildSignInButton() {
    return PrimaryAuthButton(
      label: 'Sign In',
      onPressed: _isLoading ? null : _signIn,
      isLoading: _isLoading,
    ).animate().fadeIn(duration: 400.ms, delay: 600.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildSocialNote() {
    // Social auth (Google / Apple) is intentionally disabled until Firebase
    // providers are configured. Showing a subtle informational note instead.
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.info_outline_rounded,
            size: 18,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Google & Apple sign-in will be available once Firebase providers are configured.',
              style: AppTextStyles.bodySmall,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms, delay: 650.ms);
  }

  Widget _buildRegisterRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'New to Morrow?',
          style: AppTextStyles.bodyMedium,
        ),
        TextButton(
          onPressed: _isLoading ? null : _navigateToRegister,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            'Create Account',
            style: AppTextStyles.link,
          ),
        ),
      ],
    ).animate().fadeIn(duration: 400.ms, delay: 700.ms);
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                // TODO: launch Privacy Policy URL
              },
              child: Text(
                'Privacy Policy',
                style: AppTextStyles.linkSmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                '·',
                style: AppTextStyles.bodySmall,
              ),
            ),
            GestureDetector(
              onTap: () {
                // TODO: launch Terms of Service URL
              },
              child: Text(
                'Terms & Conditions',
                style: AppTextStyles.linkSmall,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          AppConstants.appFooterTagline,
          style: AppTextStyles.brandTagline.copyWith(fontSize: 11),
          textAlign: TextAlign.center,
        ),
      ],
    ).animate().fadeIn(duration: 500.ms, delay: 750.ms);
  }
}
