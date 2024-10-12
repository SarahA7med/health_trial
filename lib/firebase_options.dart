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

  static FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD-zu5HFQe36KLIWB5-dgpgR0Out9OZE5A',
    appId: '1:814970618977:web:5009becef21995b1875620',
    messagingSenderId: '814970618977',
    projectId: 'health-trial-3f587',
    authDomain: 'health-trial-3f587.firebaseapp.com',
    storageBucket: 'health-trial-3f587.appspot.com',
    measurementId: 'G-F1Y64KL539',
  );

  static  FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyChPNeyqj7nXS2RLjtxNAW0pwO7R-QEWbs',
    appId: '1:814970618977:android:8e6469d890fa6207875620',
    messagingSenderId: '814970618977',
    projectId: 'health-trial-3f587',
    storageBucket: 'health-trial-3f587.appspot.com',
  );

  static  FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDlHbtXDleYsBwaUSmc97stZCG0qeI87Ss',
    appId: '1:814970618977:ios:8f7da09a12a2becd875620',
    messagingSenderId: '814970618977',
    projectId: 'health-trial-3f587',
    storageBucket: 'health-trial-3f587.appspot.com',
    iosBundleId: 'com.example.healthTrial',
  );

  static  FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDlHbtXDleYsBwaUSmc97stZCG0qeI87Ss',
    appId: '1:814970618977:ios:8f7da09a12a2becd875620',
    messagingSenderId: '814970618977',
    projectId: 'health-trial-3f587',
    storageBucket: 'health-trial-3f587.appspot.com',
    iosBundleId: 'com.example.healthTrial',
  );

  static  FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD-zu5HFQe36KLIWB5-dgpgR0Out9OZE5A',
    appId: '1:814970618977:web:292c847156e3d3b3875620',
    messagingSenderId: '814970618977',
    projectId: 'health-trial-3f587',
    authDomain: 'health-trial-3f587.firebaseapp.com',
    storageBucket: 'health-trial-3f587.appspot.com',
    measurementId: 'G-59KP7LFNDK',
  );
}
