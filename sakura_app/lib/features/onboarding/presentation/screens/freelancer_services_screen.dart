import 'package:flutter/material.dart';
import '../../domain/enums.dart';
import '../onboarding_provider.dart';
import '../../../../routes/app_routes.dart';

class FreelancerServicesScreen extends StatefulWidget
{
  const FreelancerServicesScreen({super.key});

  @override
  State<FreelancerServicesScreen> createState() => _FreelancerServicesScreenState();
}

class _FreelancerServicesScreenState extends State<FreelancerServicesScreen> 
{
  final items = ServiceKind.values;
  final selected = <ServiceKind>{};

  void _next()
  {
    if(selected.isEmpty)
    {
      return;
    }

    final model = OnboardingProvider.of(context);
    model.servicesOffered..clear()..addAll(selected);
    Navigator.pushNamed(context, AppRoutes.pricing);
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar(title: const Text('What Services Do You Offer?')),
      body: ListView
      (
        padding: const EdgeInsets.all(16.0),
          children: 
          [
              ...items.map((s) => CheckboxListTile
              (
                value: selected.contains(s),
                title: Text(s.label),
                onChanged: (v) => setState(() => v! ? selected.add(s) : selected.remove(s)),
              )),
              const SizedBox(height: 12,),
              ElevatedButton(onPressed: _next, child: const Text('Continue')),
              const SizedBox(height: 12),
              ElevatedButton(onPressed: _next, child: const Text('Continue')),
          ],
      )
    );
  }
}