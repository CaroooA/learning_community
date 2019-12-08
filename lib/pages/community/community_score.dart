import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseRank extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(400.0),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            actions: <Widget>[
              //
            ],
            centerTitle: true,
            title: Text('数据结构'),
            backgroundColor: Theme.of(context).primaryColor,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                '第5名',
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              background: Image.asset("assets/image/scoreRank.png")
            ),
          )
        ],
      ),
    );
  }
}
