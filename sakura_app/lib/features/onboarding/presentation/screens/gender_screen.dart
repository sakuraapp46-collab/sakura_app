import 'package:flutter/material.dart';
import '../../domain/enums.dart';
import '../onboarding_provider.dart';
import '../../../../routes/app_routes.dart';
import '../../../../core/widgets/primary_button.dart';

class GenderScreen extends StatefulWidget 
{
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> 
{
  Gender? selected;
  void _next()
  {
    if(selected == null) return;
    final m = OnboardingProvider.of(context);
    m.setGender(selected!);
    Navigator.pushNamed(context, AppRoutes.birthday);
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(title : const Text('What is your gender')),
      body: Column(children: [
        RadioListTile(value: Gender.man, groupValue: selected, title: const Text('Man', textAlign: TextAlign.center), onChanged: (v) => setState(() => selected = v),),
        RadioListTile(value: Gender.woman, groupValue: selected, title: const Text('Woman', textAlign: TextAlign.center), onChanged: (v) => setState( () => selected = v),),
        RadioListTile(value: Gender.transMan, groupValue: selected, title: const Text('Trans Man', textAlign: TextAlign.center), onChanged: (v) => setState(() => selected = v),),
        RadioListTile(value: Gender.transWoman, groupValue: selected, title: const Text('Trans Woman', textAlign: TextAlign.center), onChanged: (v) => setState(() => selected = v),),
        PrimaryButton(text: 'Continue', onPressed: _next)
      ]),
    );
  }
}
