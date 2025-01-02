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
    apiKey: 'AIzaSyDfhiLQvSxRjCdfDqcqreXE3oOs7RRApsI',
    appId: '1:522244921049:web:30ec5dcd7ff27eea8c50c8',
    messagingSenderId: '522244921049',
    projectId: 'kelembaban-tanah-72e35',
    authDomain: 'kelembaban-tanah-72e35.firebaseapp.com',
    databaseURL: 'https://kelembaban-tanah-72e35-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'kelembaban-tanah-72e35.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD9eHu2i9R-47cGkOQ4Rv3O6DoO1ekEW00',
    appId: '1:522244921049:android:469109633553dc558c50c8',
    messagingSenderId: '522244921049',
    projectId: 'kelembaban-tanah-72e35',
    databaseURL: 'https://kelembaban-tanah-72e35-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'kelembaban-tanah-72e35.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCK64e-F8dcDHju1XMVKxm_rzi-zcOGpIQ',
    appId: '1:522244921049:ios:be1089bb7b5f75918c50c8',
    messagingSenderId: '522244921049',
    projectId: 'kelembaban-tanah-72e35',
    databaseURL: 'https://kelembaban-tanah-72e35-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'kelembaban-tanah-72e35.firebasestorage.app',
    iosClientId: '522244921049-l6j6au9a7fghea2lg72jrpaoj1mpbdpp.apps.googleusercontent.com',
    iosBundleId: 'com.example.growInApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCK64e-F8dcDHju1XMVKxm_rzi-zcOGpIQ',
    appId: '1:522244921049:ios:be1089bb7b5f75918c50c8',
    messagingSenderId: '522244921049',
    projectId: 'kelembaban-tanah-72e35',
    databaseURL: 'https://kelembaban-tanah-72e35-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'kelembaban-tanah-72e35.firebasestorage.app',
    iosClientId: '522244921049-l6j6au9a7fghea2lg72jrpaoj1mpbdpp.apps.googleusercontent.com',
    iosBundleId: 'com.example.growInApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDfhiLQvSxRjCdfDqcqreXE3oOs7RRApsI',
    appId: '1:522244921049:web:6fb39a3059b0a54a8c50c8',
    messagingSenderId: '522244921049',
    projectId: 'kelembaban-tanah-72e35',
    authDomain: 'kelembaban-tanah-72e35.firebaseapp.com',
    databaseURL: 'https://kelembaban-tanah-72e35-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'kelembaban-tanah-72e35.firebasestorage.app',
  );
}
