import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class PhoneAuthService {
  final _auth = FirebaseAuth.instance;
  Future<String> sendCode(String phoneNumber) async {
    final completer = Completer<String>();

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async 
      {
        // Auto-retrieval or instant verification
        await _auth.signInWithCredential(credential);
        completer.complete('Phone number automatically verified and user signed in: ${_auth.currentUser?.uid}');
      },
      verificationFailed: (Object e) 
      {
        if(e is FirebaseAuthException)
        {
          completer.completeError(
            'Phone number verification failed. Code: ${e.code}. Message: ${e.message}');
        }
        else
        {
        completer.completeError(
          'Phone number verification failed. Error Message: ${e.toString()}');
        }
     },
      codeSent: (String verificationId, int? resendToken) 
      {
        completer.complete(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) 
      {
        // Auto-resolution timed out...
      },
    );
    return completer.future;
  }

  Future<UserCredential> confirmCode({required String verificationId, required String smsCode}) async 
  {
    final credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
    return _auth.signInWithCredential(credential);
  }

}