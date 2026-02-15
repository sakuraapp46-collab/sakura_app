import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions
{
  static FirebaseOptions get currentPlatform
  {
    if (kIsWeb)
    {
      throw UnsupportedError(
        'DefaultFirebaseOptions are not configured for web. Run flutterfire configure for web support.',
      );
    }

    switch (defaultTargetPlatform)
    {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
      case TargetPlatform.fuchsia:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not configured for this platform. Run flutterfire configure.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBO9d8R26uiX_0CrHIGqZhq9X9mJ2lTBcI',
    appId: '1:258217617703:android:340d21515d9ebf882c2102',
    messagingSenderId: '258217617703',
    projectId: 'sakura-app-56183',
    storageBucket: 'sakura-app-56183.firebasestorage.app',
  );
}
