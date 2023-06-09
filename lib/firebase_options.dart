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
    apiKey: 'AIzaSyAiDTk9_u90-JSbLSe8p2CCEYWzg_wqogM',
    appId: '1:116210962196:web:49993223a517a77bea7c01',
    messagingSenderId: '116210962196',
    projectId: 'virtual-store-46aac',
    authDomain: 'virtual-store-46aac.firebaseapp.com',
    storageBucket: 'virtual-store-46aac.appspot.com',
    measurementId: 'G-BFHQENBTD0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDyjgujSmlwCmB3Orfwl-1cb_3yqsQ1YSw',
    appId: '1:116210962196:android:7e1bb3453e6f605eea7c01',
    messagingSenderId: '116210962196',
    projectId: 'virtual-store-46aac',
    storageBucket: 'virtual-store-46aac.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAwuJbYePTHOyI4iN7aymD6kUlWcACoNwk',
    appId: '1:116210962196:ios:15038e0227b3c904ea7c01',
    messagingSenderId: '116210962196',
    projectId: 'virtual-store-46aac',
    storageBucket: 'virtual-store-46aac.appspot.com',
    iosClientId: '116210962196-np5uokhats4llfqi5cfe5k1ve17ensd3.apps.googleusercontent.com',
    iosBundleId: 'com.example.onlineClothingStore',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAwuJbYePTHOyI4iN7aymD6kUlWcACoNwk',
    appId: '1:116210962196:ios:15038e0227b3c904ea7c01',
    messagingSenderId: '116210962196',
    projectId: 'virtual-store-46aac',
    storageBucket: 'virtual-store-46aac.appspot.com',
    iosClientId: '116210962196-np5uokhats4llfqi5cfe5k1ve17ensd3.apps.googleusercontent.com',
    iosBundleId: 'com.example.onlineClothingStore',
  );
}
