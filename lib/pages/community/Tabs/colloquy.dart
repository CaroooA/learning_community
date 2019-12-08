import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:learning_community/service/service_method.dart';
import 'dart:convert';

class Colloquy extends StatefulWidget {
  @override
  _ColloquyState createState() => _ColloquyState();
}

class _ColloquyState extends State<Colloquy> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getRequest('http://10.0.2.2:3000/colloquy'),
      builder: (context,snapshot){
        if(snapshot.hasData){
          print(snapshot.data);
          var data = json.decode(snapshot.data.toString());
          print(data['data']['swiper']);
          return Column(
            children: <Widget>[
             SwiperDiy(swiperDateList: data['data']['swiper'])
            ],
          );
        }else{
          return Center(
            child: Text('...加载中'),
          );
        }
      },
    );
  }
}

//轮播组件
class SwiperDiy extends StatelessWidget {
  final Map swiperDateList;
  SwiperDiy({Key key,this.swiperDateList}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(333.0),
      child: Swiper(
        itemBuilder: (BuildContext context,int index){
          return Image.network("${swiperDateList['pic${index+1}']}",fit:BoxFit.fill);
        },
        itemCount: swiperDateList.length,
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}


