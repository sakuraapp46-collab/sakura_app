import 'package:flutter/material.dart';
import '../../../../core/widgets/primary_button.dart';
import '../onboarding_provider.dart';
import '../../../../routes/app_routes.dart';


class EmailScreen extends StatefulWidget
{
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> 
{
  final _ctrl = TextEditingController();

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  Future<void> _continue() async 
  {
      final email = _ctrl.text.trim();
      if(email.isEmpty) 
      {
        return;
      }
      final model = OnboardingProvider.of(context);
      model.setEmail(email);
      Navigator.pushNamed(context, AppRoutes.userType);
  }

  @override
  Widget build(BuildContext context) 
  {
    return  Scaffold(
        appBar: AppBar(title: const Text('Email')),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                children: [
                    const Text(
                      'Enter you email address',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                        controller: _ctrl,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                            floatingLabelAlignment: FloatingLabelAlignment.center,
                        ),
                    ),
                    PrimaryButton(
                        text: 'Continue',
                        onPressed: _continue,
                    ),
                ],
            ),
        ),
    );
  }
}
