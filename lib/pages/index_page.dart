import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import './community_page.dart';
import './home_page.dart';
import './member_page.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('首页'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.chat),
      title: Text('社区'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_pin_circle),
      title: Text('我的'),
    ),
  ];

  final List<Widget> tabBars = [
    HomePage(),
    CommunityPage(),
    MemberPage()
  ];

  int _selectedIndex = 1;
  var _selectedPage;
  void initState() {
    _selectedPage=tabBars[_selectedIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750,height: 1334)..init(context);
    return Scaffold(
        backgroundColor: Colors.blue[400],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          items: bottomTabs,
          onTap: (index){
            setState(() {
              _selectedIndex = index;
              _selectedPage = tabBars[_selectedIndex];
            });
          },
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: tabBars,
        )
    );
  }
}