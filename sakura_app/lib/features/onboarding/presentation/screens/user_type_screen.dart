import 'package:flutter/material.dart';
import '../../domain/enums.dart';
import '../onboarding_provider.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../routes/app_routes.dart';

class UserTypeScreen extends StatelessWidget
{
  const UserTypeScreen({super.key});
  void _go(BuildContext context, UserType type) 
  {
      final model = OnboardingProvider.of(context);
      model.setUserType(type);
      if(type == UserType.client) 
      {
        Navigator.pushNamed(context, AppRoutes.clientServices);
      } 
      else if(type == UserType.freelancer) 
      {
        Navigator.pushNamed(context, AppRoutes.freelancerServices);
      }
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
        appBar: AppBar(title: const Text('Select User Type')),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                children: [
                    const Text('Please select your user type:'),
                    const SizedBox(height: 12),
                    PrimaryButton( text: 'CLIENT', onPressed: () => _go(context, UserType.client),),
                    PrimaryButton( text: 'FREELANCE', onPressed: () => _go(context, UserType.freelancer),),
                    const SizedBox(height: 12),
                ],
            ),
        ),
    );
  }
}
