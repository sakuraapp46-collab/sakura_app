import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String? firebaseInitError;
  try {
    await Firebase.initializeApp();
  } catch (e) {
    firebaseInitError = e.toString();
  }

  runApp(OnboardingApp(firebaseInitError: firebaseInitError));
}
