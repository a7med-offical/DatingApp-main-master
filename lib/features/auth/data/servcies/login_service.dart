import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/features/home/persentaion/view/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginUser {
  static User? user;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    
  
  static Future<dynamic> registerUser(
      {required String emailAddress,
      required String password,
      required String name,
      required BuildContext context}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      user = credential.user;
      if (user != null) {
        _firestore.collection('AddUserChat').doc(credential.user!.uid).set({
          'uid':credential.user!.uid,
          'email':emailAddress,
          'name':name
        },SetOptions(merge: true));
       
        Fluttertoast.showToast(
            msg: "You Login Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Sorry can'/t login",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } on FirebaseAuthException 
                  catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    }
  }
}
                                           
                                                     

        