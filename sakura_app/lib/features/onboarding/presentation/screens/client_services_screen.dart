import 'package:flutter/material.dart';
import 'package:sakura_app/features/onboarding/domain/enums.dart';
import 'package:sakura_app/routes/app_routes.dart';
import '../onboarding_provider.dart';
import '../../../../core/widgets/primary_button.dart';

class ClientServicesScreen extends StatefulWidget
{
  const ClientServicesScreen({super.key});

  @override
  State<ClientServicesScreen> createState() => _ClientServicesScreenState();
}

class _ClientServicesScreenState extends State<ClientServicesScreen> 
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
      model.clientInterests..clear()..addAll(selected);
      Navigator.pushNamed(context, AppRoutes.gender);
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar: AppBar(title: const Text('Select Client Services')),
      body: ListView
      (
        padding: const EdgeInsets.all(16.0),
          children: 
          [
              ...items.map((s) => CheckboxListTile
              (
                value: selected.contains(s),
                title: Text(
                  s.label,
                  textAlign: TextAlign.center,
                ),
                onChanged: (v) => setState(() => v! ? selected.add(s) : selected.remove(s)),
              )),
              const SizedBox(height: 12,),
              PrimaryButton(text: 'Continue', onPressed: _next),
          ],
      ),
    );
  }
}
