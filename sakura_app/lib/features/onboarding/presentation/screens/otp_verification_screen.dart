import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sakura_app/features/onboarding/presentation/onboarding_provider.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../routes/app_routes.dart';

class OtpVerificationScreen extends StatefulWidget
{
  const OtpVerificationScreen({super.key});
  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _codeCtrl = TextEditingController();
  bool _loading = false;

  @override
  void dispose() { _codeCtrl.dispose(); super.dispose(); }

  Future<void> _verify() async
  {
      final model = OnboardingProvider.of(context);
      final id = model.verificationId;
      if(id == null) 
      {
       return;
      }
      setState(() { _loading = true; });
      final navigator = Navigator.of(context);
      try
      {
          final cred = PhoneAuthProvider.credential( verificationId: id, smsCode: _codeCtrl.text.trim());
          final user = await FirebaseAuth.instance.signInWithCredential(cred).then((value) => value.user);

          if(user != null && mounted)
          {
            navigator.pushReplacementNamed(AppRoutes.email);
          }
      }
      on FirebaseAuthException catch(e)
      {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to verify code: $e')),
          );
      }
      finally
      {
          if(mounted)
          {
            setState(() => _loading = false);
          }
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('OTP Verification')),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                children: [
                    TextField(
                        controller: _codeCtrl,
                        decoration: const InputDecoration(labelText: 'Enter OTP Code'),
                        keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    PrimaryButton(
                        text: _loading ? 'Verifying...' : 'Verify Code',
                        onPressed: _loading ? null : _verify,
                    ),
                ],
            ),
        ),
    );
  }
}