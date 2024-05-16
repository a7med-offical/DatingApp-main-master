import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class AddUser {
  static CollectionReference users = FirebaseFirestore.instance.collection('users');

  static Future<void> addUser({
    required String fullName,
    required String email,
    required String age,
    required String length,
    required String bio,
    required File imageFile,
  }) async {
    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final storageRef = FirebaseStorage.instance.ref().child('user_images/$fileName');
      final uploadTask = storageRef.putFile(imageFile);
      final snapshot = await uploadTask;
      final imageUrl = await snapshot.ref.getDownloadURL();

      await users.add({
        'full_name': fullName,
        'email': email,
        'age': age,
        'length': length,
        'bio': bio,
        'image_url': imageUrl,
      });

      print("User Added");
    } catch (error) {
      print("Failed to add user: $error");
    }
  }
}

