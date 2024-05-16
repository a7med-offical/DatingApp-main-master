
import 'package:flutter/material.dart';

class CardIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Function() onPresse;

  const CardIcon(
      {required this.icon, required this.color, required this.onPresse});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.white, 
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
            child: IconButton(
          onPressed: onPresse,
          icon: Icon(
            icon,
            color: color,
          ),
        )),
      ),
    );
  }
}
