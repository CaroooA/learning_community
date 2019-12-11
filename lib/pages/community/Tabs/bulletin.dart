import 'package:flutter/material.dart';
import 'package:learning_community/service/service_method.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';

class Bulletin extends StatefulWidget {
  @override
  _BulletinState createState() => _BulletinState();
}

class _BulletinState extends State<Bulletin> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  List list = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getRequest('http://10.0.2.2:3000/bulletin'),
      builder: (context,snapshot){
        if(snapshot.hasData){
          var data = json.decode(snapshot.data.toString());
          list = (data['data'] as List);
          print(list);
          return  ListView.builder(
            padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
            itemCount: list.length,
            itemBuilder: (BuildContext context,int index){
              return _bulletinBox(index);
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

  Widget _bulletinBox(index){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(Icons.notifications_active,color: Colors.red[400],),
        Card(
          elevation: 4.0,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),  //设置圆角
          child: Container(
            width: ScreenUtil().setWidth(650),
            height: ScreenUtil().setHeight(150),
            padding: EdgeInsets.only(top:22),
            child: Text('${list[index]['context']}',
              textAlign: TextAlign.center,
              style: TextStyle(
              fontSize:ScreenUtil().setSp(28)
            ),),
          ),
        ),
        ListTile(
          leading: Text(list[index]['name'],style: TextStyle(color: Colors.black38),),
          trailing: Text(list[index]['time'],style: TextStyle(color: Colors.black38),),
        )
      ],
    );
  }
}
