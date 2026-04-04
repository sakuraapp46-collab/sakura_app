import 'package:flutter/material.dart';
import '../../../../core/validators.dart';
import '../onboarding_provider.dart';
import '../../../../routes/app_routes.dart';
import '../../../../core/widgets/primary_button.dart';

class BirthdayScreen extends StatefulWidget 
{
  const BirthdayScreen({super.key});
  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> 
{
  DateTime? _selected;

  void _next() 
  {
    if (_selected == null)
    {
      return;
    }
    if (!isAtLeast20YearsOld(_selected!))
    {
      showDialog(context: context, builder: (_) => AlertDialog(title: const
      Text('Sorry'), content: const Text('The minimum age is 20.'), actions:
      [TextButton(onPressed: () => Navigator.pop(context), child: const
      Text('OK'))]));
      return;
    }
    final m = OnboardingProvider.of(context); m.setBirthday(_selected!);
    Navigator.pushNamed(context, AppRoutes.location);

  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar: AppBar(title: const Text('Your birthday')),
      body: Center
        (
        child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(
          _selected == null ? 'Pick your birthday' : 'Selected: ${formatDate(_selected!)}',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        PrimaryButton(onPressed: () async 
        {
          final now = DateTime.now();
          final picked = await showDatePicker
          (
            context: context,
            firstDate: DateTime(1900),
            lastDate: DateTime(now.year, now.month, now.day),
            initialDate: DateTime(now.year - 20, now.month, now.day),
          );
          if (picked != null) 
          {
            setState(() => _selected = picked);
          }
        },

      text: 'Choose date',
      ),
      const SizedBox(height: 12),
      PrimaryButton(text: 'Continue', onPressed: _next),
      ]),
      ),
    );
  }
}
