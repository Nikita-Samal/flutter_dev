import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants/auth_strings.dart';

/// General utility helpers
class AppUtils {
  AppUtils._();

  /// Show a floating snackbar
  static void showSnackBar(
    BuildContext context,
    String message, {
    bool isError = false,
    Duration duration = const Duration(seconds: 3),
  }) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? const Color(0xFFD35858) : null,
          duration: duration,
        ),
      );
  }

  /// Map FirebaseAuthException codes to user-friendly messages
  static String mapFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'wrong-password':
        return AuthStrings.signInWrongPassword;
      case 'user-not-found':
        return AuthStrings.signInUserNotFound;
      case 'user-disabled':
        return AuthStrings.signInUserDisabled;
      case 'too-many-requests':
        return AuthStrings.signInTooManyRequests;
      case 'invalid-credential':
      case 'invalid-email':
        return AuthStrings.signInInvalidCredential;
      case 'email-already-in-use':
        return AuthStrings.emailAlreadyInUse;
      case 'weak-password':
        return AuthStrings.weakPassword;
      case 'network-request-failed':
        return AuthStrings.networkError;
      default:
        return e.message ?? AuthStrings.unexpectedError;
    }
  }
}
