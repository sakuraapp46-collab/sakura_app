import 'package:flutter/material.dart';
import '../../domain/enums.dart';
import '../onboarding_provider.dart';
import '../../../../routes/app_routes.dart';
import '../../../../core/widgets/primary_button.dart';

class InterestsScreen extends StatefulWidget 
{
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> 
{
  final options = Gender.values;
  final selected = <Gender>{};
  void _next() 
  {
    if (selected.isEmpty) return;
    final m = OnboardingProvider.of(context);
    m.interests
    ..clear()
    ..addAll(selected);
    Navigator.pushNamed(context, AppRoutes.photos);
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar: AppBar(title: const Text('Who are you interested in?')),
      body: ListView
      (
        padding: const EdgeInsets.all(16),
        children: 
        [
            ...options.map((g) => CheckboxListTile(
            value: selected.contains(g),
            title: Text(
              g.name,
              textAlign: TextAlign.center,
            ),
            onChanged: (v) => setState(() => v! ? selected.add(g) :
            selected.remove(g)),
          )),
          PrimaryButton(text: 'Continue', onPressed: _next), 
        ],
      ),
    );
  }
}
