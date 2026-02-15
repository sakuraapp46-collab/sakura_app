import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhoneAuthService {
  static const String mockVerificationId = 'dev-mock-verification-id';
  static const String mockOtpCode = '123456';
  static bool get isMockMode => kDebugMode;

  final _auth = FirebaseAuth.instance;

  Future<String> sendCode(String phoneNumber) async {
    if (isMockMode) {
      return mockVerificationId;
    }

    final completer = Completer<String>();

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-retrieval can verify without manual OTP entry.
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (Object e) {
        if (!completer.isCompleted && e is FirebaseAuthException) {
          completer.completeError(
            'Phone number verification failed. Code: ${e.code}. Message: ${e.message}',
          );
        } else if (!completer.isCompleted) {
          completer.completeError(
            'Phone number verification failed. Error Message: ${e.toString()}',
          );
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        if (!completer.isCompleted) {
          completer.complete(verificationId);
        }
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out...
      },
    );
    return completer.future;
  }

  Future<void> confirmCode({
    required String verificationId,
    required String smsCode,
  }) async {
    if (isMockMode) {
      if (verificationId != mockVerificationId || smsCode != mockOtpCode) {
        throw FirebaseAuthException(
          code: 'invalid-verification-code',
          message: 'Use the dev OTP code: $mockOtpCode',
        );
      }
      return;
    }

    final credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
    await _auth.signInWithCredential(credential);
  }
}
