import 'dart:io';
import 'package:dating_app/core/utlis/custom_button.dart';
import 'package:dating_app/core/utlis/custom_text_field.dart';
import 'package:dating_app/features/auth/data/servcies/database_service.dart';
import 'package:dating_app/features/auth/data/servcies/register_service.dart';
import 'package:dating_app/features/auth/persentation/view/widget/login_view_body.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterViewBodyState createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
      child: ListView(
        children: [
          Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                  onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginView(),
                        ),
                      ),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 16),
                  ))),
          GestureDetector(
            onTap: _pickImage,
            child: CircleAvatar(
              radius: 65,
              backgroundImage: _imageFile == null
                  ? const AssetImage('Assets/images/man.jpg')
                  : FileImage(_imageFile!) as ImageProvider,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            hintText: 'Name',
            iconData: Icons.person,
            onChanged: (p0) => fullname = p0,
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
          CustomTextField(
            hintText: 'Confirm Password',
            iconData: Icons.lock,
            onChanged: (p0) => null,
          ),
          CustomTextField(
            hintText: 'Age',
            iconData: Icons.airline_stops_rounded,
            onChanged: (p0) => age = p0,
          ),
          CustomTextField(
            hintText: 'Length',
            iconData: Icons.accessibility_new,
            onChanged: (p0) => length = p0,
          ),
          CustomTextField(
            hintText: 'Bio',
            iconData: Icons.chat_bubble,
            onChanged: (p0) => bio = p0,
          ),
          CustomButton(
            onPressed: _register,
            textButton: 'Register',
          ),
        ],
      ),
    );
  }

  String? email, password, fullname, age, bio, length;
  File? _imageFile ;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }void _register() async {
  if (_imageFile == null) {
    // Display an error message if the image is not selected
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Please select an image'),
    ));
    return;
  }

  try {
    await RegisterAuth.registerUser(
      emailAddress: email!,
      password: password!,
      context: context,
      name: fullname!,
       imageFile: _imageFile!,
    );

    // Check if the image file exists before adding the user
    if (_imageFile != null) {
      await AddUser.addUser(
        fullName: fullname!,
        email: email!,
        age: age!,
        length: length!,
        bio: bio!,
        imageFile: _imageFile!,
      );
    }

    Fluttertoast.showToast(
      msg: "You Register Successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginView(),
      ),
    );
  } catch (e) {
    Fluttertoast.showToast(
      msg: "Sorry, registration failed",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }}
}
