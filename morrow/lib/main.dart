import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'app.dart';

// ─── Firebase Options ──────────────────────────────────────────────────────
// TODO: After running `flutterfire configure`, the generated
// `firebase_options.dart` file will be imported here.
// Uncomment the line below once the file is generated:
//
// import 'firebase_options.dart';
// ──────────────────────────────────────────────────────────────────────────

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock orientation to portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Status bar styling
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  // ── Firebase Initialization ─────────────────────────────────────────────
  // TODO: Replace the try/catch approach with proper Firebase initialization
  // once you have run `flutterfire configure` and have firebase_options.dart.
  //
  // Replace this block with:
  //
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  //
  bool firebaseInitialized = false;
  try {
    await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
    );
    firebaseInitialized = true;

    // ── Crashlytics ───────────────────────────────────────────────────────
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    // ── Analytics ─────────────────────────────────────────────────────────
    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  } catch (e) {
    // Firebase not yet configured — running in UI-only mode.
    // This is expected until `flutterfire configure` is run.
    debugPrint('[Morrow] Firebase not configured: $e');
    debugPrint('[Morrow] Running in UI preview mode.');
  }

  runApp(MorrowApp(firebaseReady: firebaseInitialized));
}
