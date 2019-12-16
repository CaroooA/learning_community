import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:learning_community/service/service_method.dart';
import 'package:like_button/like_button.dart';
import 'dart:convert';

class Colloquy extends StatefulWidget {
  @override
  _ColloquyState createState() => _ColloquyState();
}

class _ColloquyState extends State<Colloquy>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getRequest('http://10.0.2.2:3000/colloquy'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          var data = json.decode(snapshot.data.toString());
          print(data['data']['discuss']);
          var commentlist = (data['data']['discuss'] as List);
          return SingleChildScrollView(
              child: Column(
            children: <Widget>[
              SwiperDiy(swiperDateList: data['data']['swiper']),
              Comment(commentList: commentlist),
            ],
          ));
        } else {
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
  SwiperDiy({Key key, this.swiperDateList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(333.0),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network("${swiperDateList['pic${index + 1}']}",
              fit: BoxFit.fill);
        },
        itemCount: swiperDateList.length,
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

//讨论组件
class Comment extends StatelessWidget {
  final List commentList;
  Comment({Key key, this.commentList}) : super(key: key);
  ScrollController _scrollController = ScrollController();
  TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
      itemCount: commentList.length,
      scrollDirection: Axis.vertical,
      controller: _scrollController,
      itemBuilder: (BuildContext context, int index) {
        return _commentCard(context, index);
      },
    );
  }

  Widget _commentCard(BuildContext context, int index) {
    return Card(
        elevation: 2.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(commentList[index]['avator']),
              ),
              title: Text(commentList[index]['name']),
              trailing: Text(commentList[index]['time']),
              subtitle: Text(
                commentList[index]['question'],
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(26), color: Colors.black54),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            ListTile(
              leading: FlatButton(
                child: Text(
                  '查看回复（${commentList[index]['person']}）',
                  style: TextStyle(
                      color: Colors.blueGrey[700],
                      fontSize: ScreenUtil().setSp(28)),
                ),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return _replyList(commentList[index]['answer']);
                      });
                },
              ),
              trailing: FlatButton(
                child: Text(
                  '发表回复',
                  style: TextStyle(
                      color: Colors.blueGrey[700],
                      fontSize: ScreenUtil().setSp(28)),
                ),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return _buildCommentInput();
                      });
                },
              ),
            )
          ],
        ));
  }

  Widget _buildCommentInput() {
    return Card(
      elevation: 0,
      child: Form(
          child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  minLines: 3,
                  maxLines: 100,
                  decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                  controller: _controller,
                ),
                RaisedButton(
                  onPressed: (){

                  },
                  child: Text('回复'),
                  color: Colors.yellow[800],
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))
                  )
                )
              ],
            )
          ),
        ],
      )),
    );
  }

  //回复列表
  Widget _replyList(List list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
      itemCount: list.length,
      scrollDirection: Axis.vertical,
      controller: _scrollController,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          width: ScreenUtil().setWidth(750),
          padding: EdgeInsets.all(10.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(list[index]['avator']),
                  ),
                  title: Text('${list[index]['name']}'),
                  subtitle: Text('${list[index]['content']}',style: TextStyle(fontSize: ScreenUtil().setSp(26)),),
                ),
                list[index]['isReply'] == true ?  ListTile(
                  contentPadding: EdgeInsets.only(left: 50),
        leading: CircleAvatar(
        backgroundImage: NetworkImage(list[index]['reply'][0]['avator']),
        ),
        title: Text('${list[index]['reply'][0]['name']}'),
        subtitle: Text('${list[index]['reply'][0]['content']}',style: TextStyle(fontSize: ScreenUtil().setSp(26)),),
        ) : Container(height: 0,)
              ]),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.black12))),
        );
      },
    );
  }
}
