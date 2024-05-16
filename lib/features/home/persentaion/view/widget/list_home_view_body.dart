import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/features/auth/data/servcies/database_service.dart';
import 'package:dating_app/features/favourite/data/service/database_fav_service.dart';
import 'package:dating_app/features/home/persentaion/view/widget/all_user_card.dart';
import 'package:dating_app/features/home/persentaion/view/widget/card_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeViewList extends StatefulWidget {
  const HomeViewList({super.key});

  @override
  State<HomeViewList> createState() => _HomeViewListState();
}

class _HomeViewListState extends State<HomeViewList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: CardIcon(
              color: Colors.amber,
              icon: Icons.replay,
              onPresse: () => setState(() {
                print('fav added');
              }),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: CardIcon(
              color: Colors.red,
              icon: Icons.close,
              onPresse: () => null,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: CardIcon(
              color: Colors.blue,
              icon: Icons.star,
              onPresse: () => null,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: CardIcon(
              color: Colors.purple,
              icon: Icons.flash_on_outlined,
              onPresse: () async {},
            ),
            label: '',
          ),
        ],
        onTap: (int index) {},
      ),
      body: StreamBuilder(
        stream: AddUser.users.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          final List<DocumentSnapshot> documents = snapshot.data!.docs;
          String? currentUserEmail = FirebaseAuth.instance.currentUser?.email;

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final Map<String, dynamic> data =
                  documents[index].data() as Map<String, dynamic>;
              String userEmail = data['email'];

              if (userEmail != currentUserEmail) {
                return GestureDetector(
                  onTap: () {
                    AddFavUser.addFav(
                      fullName: data['full_name'],
                      email: data['email'],
                      age: data['length'],
                      length: data['age'],
                      bio: data['bio'],
                      imageUrl: data['image_url'],
                    );
                  },
                  child: AllUsers(
                    fullname: data['full_name'],
                    email: data['email'],
                    age: data['age'],
                    length: data['length'],
                    bio: data['bio'],
                    imageUrl: data['image_url'],
                  ),
                );
              } else {
                return SizedBox.shrink();
              }
            },
          );
        },
      ),
    );
  }
}
