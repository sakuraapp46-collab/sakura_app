import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/validators.dart';
import '../../../../core/widgets/primary_button.dart';
import '../onboarding_provider.dart';
import '../../repo/onboarding_repository.dart';
import '../../../../routes/app_routes.dart';

class DescriptionScreen extends StatefulWidget 
{
  const DescriptionScreen({super.key});

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> 
{
  final _ctrl = TextEditingController();
  bool _loading = false;

  @override
  void dispose() 
  { 
    _ctrl.dispose(); 
    super.dispose(); 
  }

  Future<void> _finish() async 
  {
    final text = _ctrl.text.trim();
    if (text.length > 500) 
    {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:
      Text('Max 500 characters')));
      return;
    }
    if (containsExternalContact(text)) 
    {
    showDialog(context: context, builder: (_) => AlertDialog(title: const
    Text('Not allowed'), content: const Text('Your description contains external contact info. Remove it to continue.'), actions: [TextButton(onPressed: () =>
    Navigator.pop(context), child: const Text('OK'))]));
    return;
    }
  final m = OnboardingProvider.of(context);
  m.setDescription(text);

  final user = FirebaseAuth.instance.currentUser;
  final userId = user?.uid ?? 'dev_${(m.phoneNumber ?? 'guest').replaceAll(RegExp(r'[^0-9]'), '')}';
  final phoneNumber = user?.phoneNumber ?? m.phoneNumber;
  setState(() => _loading = true);

  try 
  {
    final repo = OnboardingRepository();
    final photoUrls = await repo.uploadPhotos(userId, m.photos);
    final data = 
    {
      'phoneNumber': phoneNumber,
      'email': m.email,
      'userType': m.userType,
      'clientServices': m.clientInterests.map((e) => e.name).toList(),
      'servicesOffered': m.servicesOffered.map((e) => e.name).toList(),
      'pricing': m.pricing.map((k, v) => MapEntry(k.name, v)),
      'gender': m.gender?.name,
      'birthday': m.birthday, // Firestore stores as Timestamp automatically via plugin
      'locationText': m.locationText,
      'interestedIn': m.interests.map((e) => e.name).toList(),
      'photos': photoUrls,
      'description': m.description,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
    await repo.saveProfile(userId: userId, data: data);
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.done, (_) => false);
  } 
  catch (e) 
  {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to save: $e')));
  } 
  finally 
  {
  if (mounted) setState(() => _loading = false);
  }
}

@override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar: AppBar(title: const Text('Profile description')),
      body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: 
      [
        TextField(
        controller: _ctrl,
        textAlign: TextAlign.center,
        maxLength: 500,
        maxLines: 6,
        decoration: const InputDecoration(
          labelText: 'Tell us about you (no external contacts)',
          floatingLabelAlignment: FloatingLabelAlignment.center,
        ),),
        const SizedBox(height: 12),
        PrimaryButton(
          text: _loading ? 'Saving...' : 'Finish',
          onPressed: _loading ? null : _finish,
        ),
      ]),
      ),
    );
  }
}
