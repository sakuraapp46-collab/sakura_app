import 'package:intl/intl.dart';

bool containsExternalContact(String text)
{
  final patterns = [
    RegExp(r'(?:https?://www\.)\S+'), // URLs
    RegExp(r'\b\+?\d[\d\d\-]{7,}\b'), //Social handles
    RegExp(r'\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b', caseSensitive: false), // Email addresses
    RegExp(r'\b\d{3}[-.]?\d{3}[-.]?\d{4}\b'), // Phone numbers
  ];

  return patterns.any((rx) => rx.hasMatch(text));
}

bool isAtLeast20YearsOld(DateTime birthday)
{
  final today = DateTime.now();
  final age = today.year - birthday.year;
  if (today.month < birthday.month || (today.month == birthday.month && today.day < birthday.day)) {
    return age - 1 >= 20;
  }
  return age >= 20;
}


String formatDate(DateTime d) => DateFormat('yyyy-MM-dd').format(d);