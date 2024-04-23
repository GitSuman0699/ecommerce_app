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
    apiKey: 'AIzaSyA-PDx7GS7vBudAL33ILb6_5fFsiQesgEI',
    appId: '1:928033464347:web:84188e6d6542016a5e98be',
    messagingSenderId: '928033464347',
    projectId: 'ecommerce-app-734dd',
    authDomain: 'ecommerce-app-734dd.firebaseapp.com',
    storageBucket: 'ecommerce-app-734dd.appspot.com',
    measurementId: 'G-4VSVBC8WZ7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDjxUJanRK9tWmlQ1DM9qaE8jGhzkqrVTI',
    appId: '1:928033464347:android:8a03edbecfc501615e98be',
    messagingSenderId: '928033464347',
    projectId: 'ecommerce-app-734dd',
    storageBucket: 'ecommerce-app-734dd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDyz5RF8Kucygd3R4TIdNX8-dO_up-7qps',
    appId: '1:928033464347:ios:34ac5b6a7e5c5e6c5e98be',
    messagingSenderId: '928033464347',
    projectId: 'ecommerce-app-734dd',
    storageBucket: 'ecommerce-app-734dd.appspot.com',
    iosBundleId: 'com.example.ecommerceApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDyz5RF8Kucygd3R4TIdNX8-dO_up-7qps',
    appId: '1:928033464347:ios:34ac5b6a7e5c5e6c5e98be',
    messagingSenderId: '928033464347',
    projectId: 'ecommerce-app-734dd',
    storageBucket: 'ecommerce-app-734dd.appspot.com',
    iosBundleId: 'com.example.ecommerceApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA-PDx7GS7vBudAL33ILb6_5fFsiQesgEI',
    appId: '1:928033464347:web:71aec43415abb6af5e98be',
    messagingSenderId: '928033464347',
    projectId: 'ecommerce-app-734dd',
    authDomain: 'ecommerce-app-734dd.firebaseapp.com',
    storageBucket: 'ecommerce-app-734dd.appspot.com',
    measurementId: 'G-6DM2B2X5NZ',
  );
}
