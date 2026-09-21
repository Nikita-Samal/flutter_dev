// THIS FILE IS A PLACEHOLDER.
// Run `flutterfire configure` to generate this file with real Firebase credentials.
// See README.md for setup instructions.

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  // PLACEHOLDER VALUES - Replace by running: flutterfire configure

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBSGPWbUpAZvGXuOPKle_okZGYnjPbyXHU',
    appId: '1:411146820224:web:bf08001b2e7d6078732465',
    messagingSenderId: '411146820224',
    projectId: 'e-commerce-48eb6',
    authDomain: 'e-commerce-48eb6.firebaseapp.com',
    storageBucket: 'e-commerce-48eb6.firebasestorage.app',
    measurementId: 'G-6D4E6L0S11',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBz7XaI5WFmDqrFIZvxEi3EE2gILyb55ek',
    appId: '1:411146820224:android:2a0d6be1d1248d29732465',
    messagingSenderId: '411146820224',
    projectId: 'e-commerce-48eb6',
    storageBucket: 'e-commerce-48eb6.firebasestorage.app',
  );
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCG6Z0Ywz7ZWr2bD8_ZhXE_zz7Uw7C3DLQ',
    appId: '1:411146820224:ios:6871d1af85775988732465',
    messagingSenderId: '411146820224',
    projectId: 'e-commerce-48eb6',
    storageBucket: 'e-commerce-48eb6.firebasestorage.app',
    iosBundleId: 'com.nikita.nikita',
  );
  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'YOUR_MACOS_API_KEY',
    appId: 'YOUR_MACOS_APP_ID',
    messagingSenderId: 'YOUR_SENDER_ID',
    projectId: 'YOUR_PROJECT_ID',
    storageBucket: 'YOUR_PROJECT_ID.appspot.com',
    iosBundleId: 'com.nikita.nikita',
  );
}
