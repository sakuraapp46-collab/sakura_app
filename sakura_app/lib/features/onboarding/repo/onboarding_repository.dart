import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';


class OnboardingRepository 
{
  final _db = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  Future<void> saveProfile ({
    required String userId,
    required Map<String, dynamic> data,}) async {
      await _db.collection('users').doc(userId).set(data, SetOptions(merge: true));
    }

  Future<List<String>> uploadPhotos(String userId, List<File> files) async
  {
      final List<String> paths = [];
      for( var i = 0; i < files.length; i++)
      {
        final ref = _storage.ref('user_uploads/$userId/photo_$i.jpg');
        await ref.putFile(files[i]);

        paths.add(await ref.getDownloadURL());
      }
      return paths;
  }
}
