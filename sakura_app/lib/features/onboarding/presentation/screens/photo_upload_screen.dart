import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/widgets/primary_button.dart';
import '../onboarding_provider.dart';
import '../../../../routes/app_routes.dart';
class PhotoUploadScreen extends StatefulWidget {
const PhotoUploadScreen({super.key});
@override
State<PhotoUploadScreen> createState() => _PhotoUploadScreenState();
}
class _PhotoUploadScreenState extends State<PhotoUploadScreen> {
final picker = ImagePicker();
Future<void> _addPhoto() async {
final x = await picker.pickImage(source: ImageSource.gallery, imageQuality:
85);
if (x == null) return;
if (!mounted) return;
final m = OnboardingProvider.of(context);
if (m.photos.length >= 5) return;
setState(() => m.photos.add(File(x.path)));
}
void _next() {
final m = OnboardingProvider.of(context);
if (m.photos.isEmpty) {
ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:
Text('Please add at least one photo')));
return;
}
Navigator.pushNamed(context, AppRoutes.description);
}
@override
Widget build(BuildContext context) {
final m = OnboardingProvider.of(context);
return Scaffold(
appBar: AppBar(title: const Text('Add your photos (1–5)')),
floatingActionButton: FloatingActionButton(onPressed: _addPhoto, child:
const Icon(Icons.add_a_photo)),
body: GridView.builder(
padding: const EdgeInsets.all(12),
gridDelegate: const
SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing:
8, mainAxisSpacing: 8),
itemCount: m.photos.length,
itemBuilder: (_, i) => Image.file(m.photos[i], fit: BoxFit.cover),
),
bottomNavigationBar: Padding(
padding: const EdgeInsets.all(12),
child: PrimaryButton(text: 'Continue', onPressed: _next),
),
);
}
}
