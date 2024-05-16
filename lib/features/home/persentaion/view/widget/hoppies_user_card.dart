
import 'package:flutter/material.dart';

class HoppiesUserCard extends StatelessWidget {
  const HoppiesUserCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      height: 30,
      width: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.grey),
      child: const Center(
          child: Text(
        'Simple',
        style: TextStyle(color: Colors.white),
      )),
    );
  }
}