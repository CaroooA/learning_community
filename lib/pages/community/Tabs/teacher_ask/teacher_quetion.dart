import 'package:flutter/material.dart';
import 'package:learning_community/service/service_method.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import './teacher_answer.dart';
import 'dart:convert';

class TeacherQue extends StatefulWidget {
  @override
  _TeacherQueState createState() => _TeacherQueState();
}

class _TeacherQueState extends State<TeacherQue>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  ScrollController _scrollController = ScrollController();

  List list = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getRequest('http://10.0.2.2:3000/teacherq'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());
            list = (data['data'] as List);
            print(list[1]['answer']);
            return Container(
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context){return TeacherAsk(commentList: list[index]);}
                      ));
                    },
                    child: _question(index),
                  );
                }
              )
            );
          } else {
            return Center(
              child: Text('...加载中'),
            );
          }
        });
  }

  Widget _question(int index) {
    return Container(
      width: ScreenUtil().setWidth(750),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              list[index]['name'],
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(28)),
            ),
            Text(
              list[index]['time'],
              style: TextStyle(fontSize: 12.0, color: Colors.black54),
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Icon(Icons.help, color: Colors.red[400]),
              Text(
                '   ${list[index]['question']}',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil().setSp(28)),
              )
            ]),
            Padding(padding: EdgeInsets.all(2.5)),
            ListTile(
              contentPadding: EdgeInsets.only(left: 0),
              leading: Text('参与人数（${list[index]['person']}）',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(24), color: Colors.black54)),
              trailing: Chip(
                padding: EdgeInsets.only(right: 10.0),
                label: Text(
                  '  ${list[index]['tag']}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontSize: ScreenUtil().setSp(24)),
                ),
                backgroundColor: Colors.black38,
              ),
            )
          ]),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.black12))),
    );
  }
}
