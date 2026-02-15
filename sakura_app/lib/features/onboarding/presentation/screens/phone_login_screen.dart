import 'package:flutter/material.dart';
import '../../../../core/widgets/primary_button.dart';
import '../onboarding_provider.dart';
import '../../../onboarding/data/phone_auth_service.dart';
import '../../../../routes/app_routes.dart';

class PhoneLoginScreen extends StatefulWidget
{
  const PhoneLoginScreen({super.key});

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  final _ctrl = TextEditingController();
  bool _loading = false;

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  Future<void> _sendCode() async 
  {

      final phone = _ctrl.text.trim();
      if(phone.isEmpty) 
      {
        return;
      }

      setState(() { _loading = true; });
      try
      {
          final service = PhoneAuthService();
          final verificationId = await service.sendCode(phone);
          if (!mounted) return;
          final model = OnboardingProvider.of(context);
          model..setPhone(phone)..setVerificationId(verificationId);
          Navigator.pushNamed(context, AppRoutes.otp);
      }
      catch(e)
      {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to send code: $e')),
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
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Login with your phone number',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            if (PhoneAuthService.isMockMode)
              const Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Text(
                  'Dev mode active. Any phone works; OTP is 123456.',
                  textAlign: TextAlign.center,
                ),
              ),
            TextField(
              controller: _ctrl,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone Number (e.g. +15551234567)',
                border: OutlineInputBorder(),
                floatingLabelAlignment: FloatingLabelAlignment.center,
              ),
            ),
            const SizedBox(height: 14),
            PrimaryButton(
              text: _loading ? 'Sending...' : 'Send Code',
              onPressed: _loading? null : _sendCode,
            ),
          ],
        ),
      ),
    );
  }
}
