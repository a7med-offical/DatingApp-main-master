import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/core/utlis/custom_button.dart';
import 'package:dating_app/core/utlis/custom_text_field.dart';
import 'package:dating_app/features/auth/data/servcies/login_service.dart';
import 'package:dating_app/features/home/persentaion/view/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginView extends StatelessWidget {
  LoginView({super.key,});

  String? email, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 16),
                    ))),
            Image.asset(
              'Assets/images/splash_icon.png',
              height: 150,
            ),
            const Text(
              'Dating App ',
              style: TextStyle(
                  fontSize: 26,
                  fontStyle: FontStyle.italic,
                  color: Colors.purple,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              'welcome back to login',
              style: TextStyle(color: Color.fromRGBO(158, 158, 158, 1), fontSize: 16),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              hintText: 'Email',
              iconData: Icons.person,
              onChanged: (p0) => email = p0,
            ),
            CustomTextField(
              hintText: 'Password',
              iconData: Icons.lock,
              onChanged: (p0) => password = p0,
            ),
            CustomButton(
              onPressed: () async{
                 String? name = await fetchUserNameByEmail(email!);
          if (name != null) {
            LoginUser.registerUser(
              emailAddress: email!,
              password: password!,
              // ignore: use_build_context_synchronously
              context: context,
              name: name,
            );
            
             Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeView(),
            ));
            }else {
              print ('nullllllllllll');
            }
              },
              textButton: 'Login',
            ),
          ],
        ),
      ),
    );
  }
   Future<String?> fetchUserNameByEmail(String email) async {
    String? userName;
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('AddUserChat')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();
    if (snapshot.docs.isNotEmpty) {
      userName = snapshot.docs.first['name'];
    }
    return userName;
  }
}
