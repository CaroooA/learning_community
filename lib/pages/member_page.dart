import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning_community/service/service_method.dart';
import 'dart:convert';

class MemberPage extends StatelessWidget {
  var titles = ["我的消息", "浏览记录", "我的提问", "我的问答", "我的课程", "我的荣誉", "设置"];
  var iconList = [Icons.email,Icons.assignment,Icons.speaker_notes,Icons.record_voice_over,Icons.school,Icons.local_florist,Icons.devices];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getRequest('http://10.0.2.2:3000/mine'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());
            return CustomScrollView(
                reverse: false,
                shrinkWrap: false,
                slivers: <Widget>[
                  SliverAppBar(
                    pinned: false,
                    backgroundColor: Colors.orange[300],
                    expandedHeight: 252.0,
                    iconTheme: IconThemeData(color: Colors.transparent),
                    flexibleSpace: InkWell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: ScreenUtil().setWidth(200.0),
                            height: ScreenUtil().setHeight(200.0),
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(data['data']['avator']),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '${data['data']['name']}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ScreenUtil().setSp(32)),
                                ),
                                SizedBox.fromSize(size: Size(750,10),),
                                Text(
                                  '${data['data']['stunum']}',
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(28),
                                    color: Colors.white
                                  ),
                                )
                              ],
                            )
                          )
                        ],
                      ),
                    ),
                  ),
                  SliverFixedExtentList(
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                    String title = titles[index];
                    IconData icon = iconList[index];
                    return SingleChildScrollView(
                      child: Container(
                          alignment: Alignment.centerLeft,
                          color: Colors.white,
                          child: new InkWell(
                              onTap: () {
                                print("the is the item of $title");
                              },
                              child: Column(children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        15.0, 15.0, 15.0, 15.0),
                                    child: Row(children: <Widget>[
                                      Icon(icon,color: Colors.deepOrange[300],),
                                      Expanded(child: Text('  ${title}',style: TextStyle(fontSize: ScreenUtil().setSp(28)),)),
                                      Icon(Icons.chevron_right)
                                    ])),
                                Divider(height: 2.0,color: Colors.black12,)
                              ]))),
                    );
                  }, childCount: titles.length),
                  itemExtent: 50.0,)
                ]);
          } else {
            return Center(
              child: Text('...加载中'),
            );
          }
        });
  }
}
