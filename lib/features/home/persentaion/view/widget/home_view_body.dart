import 'package:dating_app/features/chat/persenation/view/chat_users_view.dart';
import 'package:dating_app/features/chat/persenation/view/chat_view.dart';
import 'package:dating_app/features/favourite/persentaion/view/favourite.dart';
import 'package:dating_app/features/home/persentaion/view/widget/list_home_view_body.dart';
import 'package:dating_app/features/setting/persention/view/setting_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          bottom: const TabBar(
            indicator: BoxDecoration(),
            dividerColor: Colors.white,
            labelColor: Colors.purple,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                icon: Icon(Icons.groups, size: 30),
              ),
              Tab(
                icon: Icon(Icons.volunteer_activism, size: 30),
              ),
              Tab(
                icon: Icon(Icons.forum, size: 30),
              ),
              Tab(
                icon: Icon(Icons.settings, size: 30),
              ),
            ],
          ),
          elevation: 0,
        ),
        body:  TabBarView(
          children: [
          const  Expanded(
              child: HomeViewList(),
            ),
          const  Expanded(child: FavouriteView()),
         const   Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
              child: HomeUserChat(),
            ),
            SettingsView(),
          ],
        ),
      ),
    );
  }
}
