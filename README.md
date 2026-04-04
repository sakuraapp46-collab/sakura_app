1) Initialize a Flutter project
# check Flutter is installed and on a stable channel
flutter --version

# create a new app
flutter create my_app
cd my_app

# run the default counter app once (Android emulator / iOS simulator / device)
flutter run


Tip: Open the folder in Android Studio or VS Code. Use their device manager to start an emulator/simulator.

2) Add Firebase to your Flutter app
2.1 Install the CLIs (one time on your machine)
# Firebase CLI (requires Node.js)
npm install -g firebase-tools
firebase login

# FlutterFire CLI (generates Flutter config)
dart pub global activate flutterfire_cli


If flutterfire isn’t found later, add Dart’s global bin to your PATH (e.g., ~/.pub-cache/bin). 
FlutterFire

2.2 Add Firebase packages to your app

From your Flutter project root:

flutter pub add firebase_core cloud_firestore


firebase_core connects Flutter to Firebase; cloud_firestore is the database SDK. 
FlutterFire

2.3 Run the FlutterFire configuration wizard
flutterfire configure


Pick or create a Firebase project.

Select platforms (Android, iOS, Web, etc.).

This generates lib/firebase_options.dart and registers native apps, adds google-services.json/GoogleService-Info.plist, and updates Gradle as needed. 
Firebase
+1

2.4 Initialize Firebase in code

Edit lib/main.dart:

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();             // 1) make sure bindings are ready
  await Firebase.initializeApp(                         // 2) connect to Firebase using generated options
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());                                // 3) start your app
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Demo',
      home: Scaffold(
        appBar: AppBar(title: const Text('Hello Firebase')),
        body: const Center(child: Text('Ready!')),
      ),
    );
  }
}

3) Which Firebase database should I use?

Cloud Firestore (recommended): Document/collection (“NoSQL”) database. Strong querying, automatic scaling, offline cache, good for most app data. (We’ll use this.)

Realtime Database: Legacy JSON tree. Great for ultra-low-latency streaming, but weaker querying/structure.

The Flutter docs and setup tools bias toward Firestore for new apps. 
Firebase

4) Firestore: enable + first read/write
4.1 Enable Firestore

In the Firebase Console → Build → Firestore Database → Create database (start in test mode for learning; later, tighten security rules).

“Test mode” is for development only. You’ll switch to rules that check request.auth != null before production.

4.2 Write & read data (very small example)
import 'package:cloud_firestore/cloud_firestore.dart';

// Write a profile document
Future<void> createUserProfile(String uid, String name) async {
  await FirebaseFirestore.instance
      .collection('users')        // a collection named "users"
      .doc(uid)                   // one document per user
      .set({
        'displayName': name,
        'createdAt': FieldValue.serverTimestamp(),
      });
}

// Read a document once
Future<Map<String, dynamic>?> readUserProfile(String uid) async {
  final snap = await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .get();
  return snap.data();             // returns Map or null
}

// Listen for live updates
Stream<Map<String, dynamic>?> watchUserProfile(String uid) {
  return FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .snapshots()
      .map((s) => s.data());
}

5) Local development with the Firebase Emulator Suite (optional but awesome)

You can run Firestore locally (no billing, no internet) while developing:

# from your project root
firebase init emulators
firebase emulators:start


Then, before you use Firestore in Dart (e.g., right after initializeApp in main), point to the emulator in debug builds:

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (!kReleaseMode) {
    // Use local Firestore emulator
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  }

  runApp(const MyApp());
}


This flow is covered in Firebase’s Flutter emulator codelab. 
Firebase

6) Platform specifics (important)
Android

In android/app/build.gradle, ensure:

defaultConfig {
    minSdk 23       // many Firebase libs (e.g., Auth, In-App Messaging) now require 23
}


Newer Firebase/AndroidX libraries have moved to minSdk 23 for many components; if you see a build error asking for a higher minSdk, set it to 23 (or higher). 
Stack Overflow
+1

Keep your compile/target SDKs current; Play Console now requires targetSdk 35 for new updates (from 2025-08-31). 
Android Developers

iOS

Use Xcode 16.2+ and target iOS 13+ in ios/Podfile:

platform :ios, '13.0'


If CocoaPods errors say Firestore requires a higher iOS, bump it (e.g., 14 or 15), then run pod repo update && pod install. 
Firebase
+2
Firebase
+2

7) How Firestore “works” (mental model)

Data model: collection → documents → (optional) subcollections.
Example: users/{uid} has fields (displayName, createdAt) and might contain todos/ as a subcollection.

Reads & writes: You pay per read, write, and stored GB. Batching writes is efficient.

Queries: You can filter (where), sort (orderBy), and paginate (limit, cursors). Complex queries may need indexes; the SDK/console will prompt you to create them.

Security rules: You write rules that run on every read/write. Start with:

// Only allow signed-in users to read/write their own doc
rules_version = '2';
service cloud.firestore {
match /databases/{db}/documents {
match /users/{uid} {
allow read, write: if request.auth != null && request.auth.uid == uid;
}
}
}

(Set via Console → Firestore → Rules.)

---

# 8) Hooking this into your UI

You already have login/register screens in the canvas. Once you add **Firebase Auth**, you can:

- Save a profile after sign-up:
```dart
await createUserProfile(user.uid, user.email ?? 'User');


Read profile on HomeScreen using a StreamBuilder with watchUserProfile(uid).

If you want, I can wire your existing code to Firebase Auth + Firestore profiles so it’s end-to-end.

Quick checklist (copy/paste)

 flutter create my_app and flutter run

 npm i -g firebase-tools && firebase login (Firebase CLI) 
FlutterFire

 dart pub global activate flutterfire_cli (FlutterFire CLI) 
FlutterFire

 flutter pub add firebase_core cloud_firestore 
FlutterFire

 flutterfire configure → select platforms → generates firebase_options.dart 
Firebase

 Initialize Firebase in main.dart (see snippet) 
FlutterFire

 Android: set minSdk 23 if required; keep targetSdk current (Play > API 35). 
Stack Overflow
+1

 iOS: Xcode 16.2+, platform :ios, '13.0' (bump if CocoaPods asks). 
Firebase
+1

 Firestore: enable in Console; set sensible security rules; test read/write.

 (Optional) Emulators for local dev. 
Firebase

If you tell me your target platforms (Android/iOS/Web) and whether you want Firestore or Realtime DB, I’ll drop in the exact code you can paste into your project and connect it to your current screens.