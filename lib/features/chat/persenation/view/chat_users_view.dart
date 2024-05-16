import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/features/chat/persenation/view/chat_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeUserChat extends StatefulWidget {
  const HomeUserChat({super.key});

  @override
  State<HomeUserChat> createState() => _HomeUserChatState();
}

class _HomeUserChatState extends State<HomeUserChat> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('AddUserChat').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserItem(doc))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    if (_auth.currentUser!.email != data['email']) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatView(
                  name: data['name'],
                  uid: data['uid'],
                ),
              ));
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 8),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: data['image_url'] != null
                    ? NetworkImage(data['image_url'])
                    : const AssetImage('Assets/images/1.jpg') as ImageProvider,
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                data['name'],
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      );
    }
    return const SizedBox();
  }
}
