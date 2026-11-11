import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import '../../../core/constants/app_constants.dart';
import '../models/user_model.dart';

/// Result type for auth operations
class AuthResult {
  final bool success;
  final String? errorMessage;
  final UserModel? user;

  const AuthResult({
    required this.success,
    this.errorMessage,
    this.user,
  });

  const AuthResult.success(this.user)
      : success = true,
        errorMessage = null;

  const AuthResult.failure(String message)
      : success = false,
        errorMessage = message,
        user = null;
}

/// Morrow Authentication Service
///
/// Handles all Firebase Authentication operations.
/// Keeps auth logic completely separate from the UI layer.
class AuthService {
  AuthService._();
  static final AuthService instance = AuthService._();

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _logger = Logger(printer: PrettyPrinter(methodCount: 0));

  // ─── Auth State Stream ──────────────────────────────────────────────────────

  /// Stream of Firebase [User] objects.
  /// Null means the user is signed out.
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Returns the currently signed-in Firebase [User], if any.
  User? get currentUser => _auth.currentUser;

  // ─── Email / Password ───────────────────────────────────────────────────────

  /// Sign in with email and password.
  Future<AuthResult> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      await _updateLastSignedIn(credential.user!.uid);
      final userModel = await _fetchOrCreateUser(credential.user!);
      return AuthResult.success(userModel);
    } on FirebaseAuthException catch (e) {
      _logger.w('Sign-in failed: ${e.code}');
      return AuthResult.failure(_mapFirebaseError(e));
    } catch (e) {
      _logger.e('Unexpected sign-in error: $e');
      return AuthResult.failure(
        'Something went wrong. Please try again.',
      );
    }
  }

  /// Register a new account with email and password.
  Future<AuthResult> registerWithEmailAndPassword({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      if (displayName != null && displayName.isNotEmpty) {
        await credential.user!.updateDisplayName(displayName);
      }

      final userModel = await _createUserDocument(
        credential.user!,
        displayName: displayName,
      );

      return AuthResult.success(userModel);
    } on FirebaseAuthException catch (e) {
      _logger.w('Registration failed: ${e.code}');
      return AuthResult.failure(_mapFirebaseError(e));
    } catch (e) {
      _logger.e('Unexpected registration error: $e');
      return AuthResult.failure('Something went wrong. Please try again.');
    }
  }

  /// Send a password-reset email.
  Future<AuthResult?> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      return null; // null means success (no user model needed)
    } on FirebaseAuthException catch (e) {
      _logger.w('Password reset failed: ${e.code}');
      return AuthResult.failure(_mapFirebaseError(e));
    } catch (e) {
      _logger.e('Unexpected password reset error: $e');
      return AuthResult.failure('Something went wrong. Please try again.');
    }
  }

  // ─── Sign Out ───────────────────────────────────────────────────────────────

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      _logger.e('Sign-out error: $e');
    }
  }

  // ─── Firestore helpers ──────────────────────────────────────────────────────

  Future<UserModel> _fetchOrCreateUser(User firebaseUser) async {
    final ref = _firestore
        .collection(AppConstants.usersCollection)
        .doc(firebaseUser.uid)
        .withConverter<UserModel>(
          fromFirestore: (snap, _) => UserModel.fromFirestore(snap),
          toFirestore: (model, _) => model.toFirestore(),
        );

    final snap = await ref.get();
    if (snap.exists) {
      return snap.data()!;
    }
    return _createUserDocument(firebaseUser);
  }

  Future<UserModel> _createUserDocument(
    User firebaseUser, {
    String? displayName,
  }) async {
    final now = DateTime.now();
    final model = UserModel(
      uid: firebaseUser.uid,
      email: firebaseUser.email!,
      displayName: displayName ?? firebaseUser.displayName,
      photoUrl: firebaseUser.photoURL,
      createdAt: now,
      lastSignedInAt: now,
    );

    await _firestore
        .collection(AppConstants.usersCollection)
        .doc(firebaseUser.uid)
        .set(model.toFirestore());

    return model;
  }

  Future<void> _updateLastSignedIn(String uid) async {
    try {
      await _firestore
          .collection(AppConstants.usersCollection)
          .doc(uid)
          .update({'lastSignedInAt': Timestamp.fromDate(DateTime.now())});
    } catch (_) {
      // Non-critical — ignore
    }
  }

  // ─── Error Mapping ──────────────────────────────────────────────────────────

  String _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'user-not-found':
        return 'No account found with this email. Please create an account.';
      case 'user-disabled':
        return 'This account has been disabled. Please contact support.';
      case 'too-many-requests':
        return 'Too many sign-in attempts. Please wait a moment and try again.';
      case 'invalid-credential':
      case 'invalid-email':
        return 'Invalid email or password. Please try again.';
      case 'email-already-in-use':
        return 'An account already exists with this email address.';
      case 'weak-password':
        return 'Password is too weak. Please choose a stronger password.';
      case 'network-request-failed':
        return 'No internet connection. Please check your network and try again.';
      default:
        return e.message ?? 'Something went wrong. Please try again.';
    }
  }
}
