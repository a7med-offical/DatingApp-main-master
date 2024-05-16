import 'package:dating_app/features/home/persentaion/view/widget/hoppies_user_card.dart';
import 'package:flutter/material.dart';

class AllUsers extends StatelessWidget {
  final String fullname, age, bio, length, imageUrl,email;

  const AllUsers({
    required this.email,
    required this.fullname,
    required this.age,
    required this.bio,
    required this.length,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.78,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.amber,
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          bottom: 100,
          left: 30,
          child: Row(
            children: [
              Text(
                fullname,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '$age / $length M',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 70,
          left: 30,
          child: Text(
            bio,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Positioned(
          bottom: 30,
          left: 30,
          child: Row(
            children: [
              HoppiesUserCard(),
              HoppiesUserCard(),
              HoppiesUserCard(),
              HoppiesUserCard(),
            ],
          ),
        ),
      ],
    );
  }
}
