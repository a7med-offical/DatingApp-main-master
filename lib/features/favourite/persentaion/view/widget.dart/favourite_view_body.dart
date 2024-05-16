import 'package:flutter/material.dart';

class FavouriteViewBody extends StatelessWidget {
  const FavouriteViewBody(
      {super.key,
      required this.length,
      required this.fullname,
      required this.age, required this.image});
  final String length;
  final String fullname;
  final String age;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          elevation: 10,
          child: Expanded(
            child: Container(
              height: 180,
              width: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image:  DecorationImage(
                  image: NetworkImage(
                  image ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Positioned(
            bottom: 15,
            left: 10,
            child: Row(
              children: [
                Text(
                  fullname,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w900),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '$age / $length M',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w900),
                ),
              ],
            )),
      ],
    );
  }
}
