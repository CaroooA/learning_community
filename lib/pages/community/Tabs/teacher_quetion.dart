import 'package:flutter/material.dart';
import 'package:learning_community/service/service_method.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';

class TeacherQue extends StatefulWidget {
  @override
  _TeacherQueState createState() => _TeacherQueState();
}

class _TeacherQueState extends State<TeacherQue> {
  List list = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getRequest('http://10.0.2.2:3000/teacherq'),
      builder: (context,snapshot){
        if(snapshot.hasData){
          print(snapshot.data);
          var data = json.decode(snapshot.data.toString());
          list = (data['data'] as List);
          return  ListView.builder(
            padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
            itemCount: list.length,
            itemBuilder: (BuildContext context,int index){
              return _question(index);
            },
          );
        }else{
          return Center(
            child: Text('...加载中'),
          );
        }
      },
    );
  }

  Widget _question(int index) {
    return Container(
      height: ScreenUtil().setHeight(220.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  list[index]['name'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil().setSp(28)
                  ),
                ),
                Text(
                  list[index]['time'],
                  style: TextStyle(fontSize: 12.0, color: Colors.black54),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  list[index]['question'],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: ScreenUtil().setSp(28)),
                ),
              ],
            ),
          ),
          Expanded(
            child: Text('参与人数（${list[index]['person']}）',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: ScreenUtil().setSp(24), color: Colors.black38)),
          )
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.black12))),
    );
  }
}