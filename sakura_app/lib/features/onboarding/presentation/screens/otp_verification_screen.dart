import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sakura_app/features/onboarding/presentation/onboarding_provider.dart';
import '../../data/phone_auth_service.dart';
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
          final service = PhoneAuthService();
          await service.confirmCode(
            verificationId: id,
            smsCode: _codeCtrl.text.trim(),
          );

          if (mounted)
          {
            navigator.pushReplacementNamed(AppRoutes.email);
          }
      }
      on FirebaseAuthException catch(e)
      {
          if (!mounted) return;
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
                    if (PhoneAuthService.isMockMode)
                      const Padding(
                        padding: EdgeInsets.only(bottom: 12),
                        child: Text(
                          'Dev mode OTP: 123456',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    TextField(
                        controller: _codeCtrl,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          labelText: 'Enter OTP Code',
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                        ),
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
