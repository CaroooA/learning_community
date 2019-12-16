import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning_community/service/service_method.dart';
import 'dart:convert';

class CourseRank extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getRequest('http://10.0.2.2:3000/ranking'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());
            var list = (data['data'] as List);
            print(list);
            return  Container(
              height: 400.0,
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    title: Text('数据结构'),
                    backgroundColor: Theme.of(context).primaryColor,
                    expandedHeight: 200.0,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text('第5名'),
                      centerTitle: true,
                      background:
                      Image.asset('assets/images/food01.jpeg', fit: BoxFit.cover),
                    ),
                    pinned: true,
                  ),
              SliverFixedExtentList(
                itemExtent: 5.0,
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return Container(
                      height: ScreenUtil().setHeight(300),
                      child: Row(
                        children: <Widget>[
                          Text('${index}')
                        ],
                      ),
                    );
                  },
                ),
              ),
              ],
              )
            );
          } else {
            return Center(
              child: Text('...加载中'),
            );
          }
        });
  }
}

