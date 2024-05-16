import 'package:dating_app/features/favourite/persentaion/view/widget.dart/list_view_favourite.dart';
import 'package:flutter/material.dart';

class FavouriteView extends StatelessWidget {
  const FavouriteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      height: 600,
      width: double.infinity,
      child: const ListFavourite(),
    );
  }
}


