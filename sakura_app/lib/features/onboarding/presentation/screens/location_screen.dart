import 'package:flutter/material.dart';
import '../onboarding_provider.dart';
import '../../../../routes/app_routes.dart';
import '../../../../core/widgets/primary_button.dart';

class LocationScreen extends StatefulWidget 
{
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> 
{
  final _ctrl = TextEditingController();

  @override
  void dispose() 
  { 
    _ctrl.dispose(); 
    super.dispose(); 
  }

  void _next() 
  {
    if (_ctrl.text.trim().isEmpty) return;
    OnboardingProvider.of(context).setLocation(_ctrl.text.trim());
    Navigator.pushNamed(context, AppRoutes.interests);
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar: AppBar(title: const Text('Location')),
      body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: 
      [
        const Text(
          'Enter your city/area (autocomplete later)',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _ctrl,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            labelText: 'Location',
            floatingLabelAlignment: FloatingLabelAlignment.center,
          ),
        ),
        const SizedBox(height: 8),
        PrimaryButton(text: 'Continue', onPressed: _next),
      ]),
      ),
    );
  }
}
