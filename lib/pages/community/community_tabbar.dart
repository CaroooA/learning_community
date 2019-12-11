import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../community/community_score.dart';
import 'Tabs/teacher_ask/teacher_quetion.dart';
import './Tabs/colloquy.dart';
import './Tabs/bulletin.dart';

class ComTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(1334),
      child: MyTabbedPage(),
    );
  }
}

class MyTabbedPage extends StatefulWidget {
  const MyTabbedPage({Key key}) : super(key: key);
  @override
  _MyTabbedPageState createState() => _MyTabbedPageState();
}

class _MyTabbedPageState extends State<MyTabbedPage>
    with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(text: '老师提问区'),
    Tab(text: '自由讨论区'),
    Tab(text: '公告栏')
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.chevron_left,color: Colors.black,),
          onPressed: (){
            print('返回上一页');
            Navigator.of(context).pushNamed("/home");
          },
        ),
        centerTitle: true,
        title: Text('数据结构',style: TextStyle(fontSize: 22)),
        elevation: 0,
        actions: <Widget>[
          goScore(context),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: myTabs,
          unselectedLabelColor: Colors.black,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          TeacherQue(),
          Colloquy(),
          Bulletin()
        ],
      ),
    );
  }

  //课程表现按钮
  Widget goScore(BuildContext context){
    return Container(
      width: ScreenUtil().setWidth(200),
      padding: EdgeInsets.only(left: 10),
      child:InkWell(
        onTap: (){
          Navigator.push(context,new MaterialPageRoute(builder: (context) => new CourseRank()));
        },
        child: Container(
          padding: EdgeInsets.all(5.0),
          alignment: Alignment.center,
          child:
          Text('课程表现', style: TextStyle(fontSize: 18),
          ),
        ),
      ) ,
    );
  }
}