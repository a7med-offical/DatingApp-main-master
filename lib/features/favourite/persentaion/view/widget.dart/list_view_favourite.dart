import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/features/favourite/persentaion/view/widget.dart/favourite_view_body.dart';
import 'package:flutter/material.dart';

class ListFavourite extends StatelessWidget {
  const ListFavourite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:  FirebaseFirestore.instance.collection('favorite_users').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        final List<DocumentSnapshot> documents = snapshot.data!.docs;
        if (documents.length >= 2) {
          return GridView.builder(
            itemCount: documents.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final Map<String, dynamic> data =
                  documents[index].data() as Map<String, dynamic>;
              return FavouriteViewBody(
                image: data['image_url'],
                age: data['age'],
                fullname: data['full_name'],
                length: data['length'],
              );
            },
          );
        } else {
          return const Center(child: Text('No Favourite user Added'));
        }
      },
    );
  }
}
