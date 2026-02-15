import 'package:flutter/material.dart';
import '../../domain/enums.dart';
import '../onboarding_provider.dart';
import '../../../../routes/app_routes.dart';
import '../../../../core/widgets/primary_button.dart';

class PricingScreen extends StatefulWidget 
{
  const PricingScreen({super.key});

  @override
  State<PricingScreen> createState() => _PricingScreenState();
}

class _PricingScreenState extends State<PricingScreen> 
{
  final Map<ServiceKind, TextEditingController> _controllers = {};

  @override
  void initState()
  {
    super.initState();
    _initializeControllers(); 
  }

  void _initializeControllers()
  {
    final model = OnboardingProvider.of(context);
    for(final s in model.servicesOffered)
    {
      _controllers.putIfAbsent(s, () => TextEditingController());
    }
  }

  @override
  void dispose()
  {
    for(final c in _controllers.values)
    {
      c.dispose();
    }
    super.dispose();
  }

  void _next()
  {
    final model = OnboardingProvider.of(context);
    model.pricing.clear();
    for(final s in model.servicesOffered)
    {
      final text = _controllers[s]?.text ?? '';
      final price = num.tryParse(text);
      if(price != null)
      {
        model.pricing[s] = price;
      }
    }
    Navigator.pushNamed(context, AppRoutes.gender);
  }

  @override
  Widget build(BuildContext context) 
  {
    final model = OnboardingProvider.of(context);
    for(final s in model.servicesOffered)
    {
      _controllers.putIfAbsent(s, () => TextEditingController());
    }
    return Scaffold
    (
      appBar: AppBar(title: const Text('Set Your Prices')),
      body: ListView
      (
        padding: const EdgeInsets.all(16.0),
          children: 
          [
              ...model.servicesOffered.map
              ((s) => Padding
              (
                padding: const EdgeInsets.only(bottom: 12.0),
                child: TextField
                (
                  controller: _controllers[s],
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration
                  (
                    labelText: '${s.label} - Price',
                    prefixText: '\$',
                    border: const OutlineInputBorder(),
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                  ),
                ),
              )),
              PrimaryButton(text: 'Continue', onPressed: _next),
          ],
      )
    );
  }
}
