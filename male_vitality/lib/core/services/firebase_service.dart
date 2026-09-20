import 'dart:developer' as developer;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

/// Centralized Firebase Service
/// Manages Firebase initialization, service accessors, and graceful fallback handling.
class FirebaseService {
  FirebaseService._();

  static bool _isAvailable = false;
  static String? _initializationError;

  /// Whether Firebase is successfully initialized and available for live cloud operations
  static bool get isAvailable => _isAvailable;

  /// Helper getter to check if Firebase is configured and ready
  static bool get isConfigured => _isAvailable;

  /// Diagnostic error message if initialization failed
  static String? get initializationError => _initializationError;

  /// Returns the current [FirebaseAuth] instance if available, otherwise null
  static FirebaseAuth? get auth {
    if (!_isAvailable) return null;
    try {
      return FirebaseAuth.instance;
    } catch (_) {
      return null;
    }
  }

  /// Returns the current [FirebaseFirestore] instance if available, otherwise null
  static FirebaseFirestore? get firestore {
    if (!_isAvailable) return null;
    try {
      return FirebaseFirestore.instance;
    } catch (_) {
      return null;
    }
  }

  /// Initializes Firebase with optional custom [FirebaseOptions].
  /// If Firebase configuration files (GoogleService-Info.plist or google-services.json)
  /// are not yet present, it gracefully falls back without crashing the app.
  static Future<bool> initialize({FirebaseOptions? options}) async {
    try {
      if (Firebase.apps.isNotEmpty) {
        _isAvailable = true;
        return true;
      }

      if (options != null) {
        await Firebase.initializeApp(options: options);
      } else {
        await Firebase.initializeApp();
      }

      _isAvailable = true;
      _initializationError = null;

      if (kDebugMode) {
        developer.log(
          'Firebase initialized successfully.',
          name: 'FirebaseService',
        );
      }
      return true;
    } catch (e, stack) {
      _isAvailable = false;
      _initializationError = e.toString();

      if (kDebugMode) {
        developer.log(
          'Firebase not configured yet or failed to initialize ($e). '
          'Running with local/mock repositories until `flutterfire configure` is completed.',
          name: 'FirebaseService',
          error: e,
          stackTrace: stack,
        );
      }
      return false;
    }
  }
}
