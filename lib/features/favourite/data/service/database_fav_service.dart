import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class AddFavUser {
  static CollectionReference favUsersRef =
      FirebaseFirestore.instance.collection('favorite_users');

  static Future<void> addFav({
    required String fullName,
    required String email,
    required String age,
    required String length,
    required String bio,
    required String imageUrl, 
  }) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final ref = FirebaseStorage.instance.refFromURL(imageUrl); 
      final file = File((await ref.getDownloadURL())); 
      final storageRef =
          FirebaseStorage.instance.ref().child('user_images/$fileName');
      final uploadTask = storageRef.putFile(file);
      final snapshot = await uploadTask;
      final downloadedImageUrl = await snapshot.ref.getDownloadURL();
      await favUsersRef.add({
        'image_url': downloadedImageUrl,
        'full_name': fullName,
        'email': email,
        'age': age,
        'length': length,
        'bio': bio,
      });

      print('User added to favorites');
    } catch (e) {
      print('Error adding user to favorites: $e');
    }
  }
}