// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
        return windows;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA3QNCRe245BknPoTGGAJGmU9H3ES4CV1M',
    appId: '1:152333808278:web:f7429b9d5b12d38a7648b7',
    messagingSenderId: '152333808278',
    projectId: 'firelearn-45b7c',
    authDomain: 'firelearn-45b7c.firebaseapp.com',
    storageBucket: 'firelearn-45b7c.appspot.com',
    measurementId: 'G-5WCCQD0M3L',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDVq740GANCeGbaorcunew-7ilQLJu9ISU',
    appId: '1:152333808278:android:bdb5bc45ab03c9427648b7',
    messagingSenderId: '152333808278',
    projectId: 'firelearn-45b7c',
    storageBucket: 'firelearn-45b7c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAyU4NH2JYrl5HtCevv6eU456gp7oJMxb8',
    appId: '1:152333808278:ios:3c97112d642ddb6a7648b7',
    messagingSenderId: '152333808278',
    projectId: 'firelearn-45b7c',
    storageBucket: 'firelearn-45b7c.appspot.com',
    iosBundleId: 'com.example.firelearn',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAyU4NH2JYrl5HtCevv6eU456gp7oJMxb8',
    appId: '1:152333808278:ios:3c97112d642ddb6a7648b7',
    messagingSenderId: '152333808278',
    projectId: 'firelearn-45b7c',
    storageBucket: 'firelearn-45b7c.appspot.com',
    iosBundleId: 'com.example.firelearn',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA3QNCRe245BknPoTGGAJGmU9H3ES4CV1M',
    appId: '1:152333808278:web:eab88592facd705b7648b7',
    messagingSenderId: '152333808278',
    projectId: 'firelearn-45b7c',
    authDomain: 'firelearn-45b7c.firebaseapp.com',
    storageBucket: 'firelearn-45b7c.appspot.com',
    measurementId: 'G-YG7K8CFREZ',
  );
}
