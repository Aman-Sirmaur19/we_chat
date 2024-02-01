// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBiqr6zwxssgKKarKwlNerC29eKi_sVOt0',
    appId: '1:367989657233:web:7f383fd6d3db06fb5af930',
    messagingSenderId: '367989657233',
    projectId: 'wechat-dc936',
    authDomain: 'wechat-dc936.firebaseapp.com',
    storageBucket: 'wechat-dc936.appspot.com',
    measurementId: 'G-62PFFMYEGE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA-VUPE4PE2u4sIoVIlhSyjtxmib7W4YL0',
    appId: '1:367989657233:android:e82020d1f2fcc4c25af930',
    messagingSenderId: '367989657233',
    projectId: 'wechat-dc936',
    storageBucket: 'wechat-dc936.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDP0HvUMenZok804k-xrUzFvoQwjcZ0rYY',
    appId: '1:367989657233:ios:d34933c507eb035a5af930',
    messagingSenderId: '367989657233',
    projectId: 'wechat-dc936',
    storageBucket: 'wechat-dc936.appspot.com',
    iosBundleId: 'com.example.weChat',
  );
}
