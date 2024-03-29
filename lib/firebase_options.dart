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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDm6LasiGf4p_dHaxurv5PZZXUUmE9zXwE',
    appId: '1:746315037774:web:130995dd95ea70fec3171f',
    messagingSenderId: '746315037774',
    projectId: 'tiktok-woong',
    authDomain: 'tiktok-woong.firebaseapp.com',
    storageBucket: 'tiktok-woong.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBFPDyJTk1IVxz6ZV7K0MdLOhfRGYSE2Gs',
    appId: '1:746315037774:android:32c157fd7c26d7e8c3171f',
    messagingSenderId: '746315037774',
    projectId: 'tiktok-woong',
    storageBucket: 'tiktok-woong.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAmf6wnnpvoZ-5d6RDN9pPpsCqzpDv-zig',
    appId: '1:746315037774:ios:ced83df8d320272bc3171f',
    messagingSenderId: '746315037774',
    projectId: 'tiktok-woong',
    storageBucket: 'tiktok-woong.appspot.com',
    androidClientId: '746315037774-og5ds1e3kh7brlpcrgkocpdnskcnhv6j.apps.googleusercontent.com',
    iosClientId: '746315037774-oq5ipvu497epvi4saqlte7isn9hslcth.apps.googleusercontent.com',
    iosBundleId: 'com.example.tiktokClone',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAmf6wnnpvoZ-5d6RDN9pPpsCqzpDv-zig',
    appId: '1:746315037774:ios:ced83df8d320272bc3171f',
    messagingSenderId: '746315037774',
    projectId: 'tiktok-woong',
    storageBucket: 'tiktok-woong.appspot.com',
    androidClientId: '746315037774-og5ds1e3kh7brlpcrgkocpdnskcnhv6j.apps.googleusercontent.com',
    iosClientId: '746315037774-oq5ipvu497epvi4saqlte7isn9hslcth.apps.googleusercontent.com',
    iosBundleId: 'com.example.tiktokClone',
  );
}
