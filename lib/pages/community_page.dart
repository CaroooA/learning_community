import 'package:flutter/material.dart';
import './community/community_tabbar.dart';

class CommunityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              ComTabBar()
            ],
          )
        ],
    ),
    );
  }
}