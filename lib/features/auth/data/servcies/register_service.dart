import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class RegisterAuth {
  static User? user;

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
   
 static  Future<dynamic> registerUser(
  
      { required File imageFile ,required String name,required String emailAddress, required String password,required BuildContext context}) async {
          final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final storageRef = FirebaseStorage.instance.ref().child('user_images/$fileName');
      final uploadTask = storageRef.putFile(imageFile);
      final snapshot = await uploadTask;
      final imageUrl = await snapshot.ref.getDownloadURL();
    try {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
        
      );

      user = credential.user;
      if (user != null) {
         _firestore.collection('AddUserChat').doc(credential.user!.uid).set({
          'uid':credential.user!.uid,
          'email':emailAddress,
          'name':name,
          'image_url':imageUrl
        },SetOptions(merge: true));
       
        print('register');
     
      }else{
                print('register not');

       
    
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
