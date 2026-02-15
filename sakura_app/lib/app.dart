import 'package:flutter/material.dart';
import 'routes/app_routes.dart';
import 'features/onboarding/domain/onboarding_model.dart';
import 'features/onboarding/presentation/onboarding_provider.dart';
import 'features/onboarding/presentation/screens/phone_login_screen.dart';
import 'features/onboarding/presentation/screens/otp_verification_screen.dart';
import 'features/onboarding/presentation/screens/email_screen.dart';
import 'features/onboarding/presentation/screens/user_type_screen.dart';
import 'features/onboarding/presentation/screens/client_services_screen.dart';
import 'features/onboarding/presentation/screens/freelancer_services_screen.dart';
import 'features/onboarding/presentation/screens/pricing_screen.dart';
import 'features/onboarding/presentation/screens/gender_screen.dart';
import 'features/onboarding/presentation/screens/birthday_screen.dart';
import 'features/onboarding/presentation/screens/location_screen.dart';
import 'features/onboarding/presentation/screens/interests_screen.dart';
import 'features/onboarding/presentation/screens/photo_upload_screen.dart';
import 'features/onboarding/presentation/screens/description_screen.dart';
import 'features/onboarding/presentation/screens/done_home_placeholder.dart';

class OnboardingApp extends StatelessWidget
{
  const OnboardingApp({super.key, this.firebaseInitError});

  final String? firebaseInitError;

  @override
  Widget build(BuildContext context)
  {
    return OnboardingProvider(
      model: OnboardingModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Onboarding Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4F46E5)),
          useMaterial3: true,
          inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder()),
        ),
        home: firebaseInitError == null
            ? null
            : FirebaseSetupErrorScreen(error: firebaseInitError!),
        initialRoute: firebaseInitError == null ? AppRoutes.phone : null,
        routes: {
          AppRoutes.phone: (context) => const PhoneLoginScreen(),
          AppRoutes.otp: (context) => const OtpVerificationScreen(),
          AppRoutes.email: (context) => const EmailScreen(),
          AppRoutes.userType: (context) => const UserTypeScreen(),
          AppRoutes.clientServices: (context) => const ClientServicesScreen(),
          AppRoutes.freelancerServices: (context) => const FreelancerServicesScreen(),
          AppRoutes.pricing: (context) => const PricingScreen(),
          AppRoutes.gender: (context) => const GenderScreen(),
          AppRoutes.birthday: (context) => const BirthdayScreen(),
          AppRoutes.location: (context) => const LocationScreen(),
          AppRoutes.interests: (context) => const InterestsScreen(),
          AppRoutes.photos: (context) => const PhotoUploadScreen(),
          AppRoutes.description: (context) => const DescriptionScreen(),
          AppRoutes.done: (context) => const DoneHomePlaceholder(),
        },
      ),
    );
  }
}

class FirebaseSetupErrorScreen extends StatelessWidget
{
  const FirebaseSetupErrorScreen({super.key, required this.error});

  final String error;

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title: const Text('Setup required')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Firebase is not configured, so registration cannot start yet.'),
            const SizedBox(height: 12),
            const Text('Fix:'),
            const Text('1. Run: flutterfire configure'),
            const Text('2. Ensure google-services.json / GoogleService-Info.plist are added'),
            const Text('3. Restart the app'),
            const SizedBox(height: 12),
            Text('Error: $error', style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
