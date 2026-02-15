import 'package:flutter/material.dart';
class DoneHomePlaceholder extends StatelessWidget {
const DoneHomePlaceholder({super.key});
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text('Home')),
body: const Center(child: Text('Welcome to [App Name]!')),
);
}
}