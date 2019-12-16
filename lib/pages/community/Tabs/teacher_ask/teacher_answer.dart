import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:like_button/like_button.dart';

class TeacherAsk extends StatefulWidget {
  final Map commentList;
  TeacherAsk({Key key, this.commentList}) : super(key: key);

  @override
  _TeacherAskState createState() => _TeacherAskState();
}

class _TeacherAskState extends State<TeacherAsk>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;
  TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('详情'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _teacherQuestion(context),
            _comment(context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context){
                return _buildCommentInput();
              }
          );
        },
        icon: Icon(Icons.textsms),
        label: Text('回复'),
        backgroundColor: Colors.yellow[400],
      ),
    );
  }

  Widget _teacherQuestion(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '   ${widget.commentList['question']}',
            textAlign: TextAlign.start,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: ScreenUtil().setSp(30)),
          ),
          ListTile(
            leading: Text(
              '${widget.commentList['name']}',
              style: TextStyle(
                  color: Colors.blueGrey[800],
                  fontSize: ScreenUtil().setSp(28)),
            ),
            trailing: Text(
              '${widget.commentList['time']}',
              style: TextStyle(
                  color: Colors.blueGrey[800],
                  fontSize: ScreenUtil().setSp(28)),
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.black12))),
    );
  }

  //讨论组件
  Widget _comment(BuildContext context) {
    ScrollController _scrollController = ScrollController();

    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
      itemCount: widget.commentList['answer'].length,
      scrollDirection: Axis.vertical,
      controller: _scrollController,
      itemBuilder: (BuildContext context, int index) {
        return _commentCard(index);
      },
    );
  }

  //评论列表
  Widget _commentCard(int index) {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage:
                  NetworkImage(widget.commentList['answer'][index]['avator']),
            ),
            title: Text('${widget.commentList['answer'][index]['stuname']}'),
            subtitle: Text('${widget.commentList['answer'][index]['time']}'),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  '${widget.commentList['answer'][index]['content']}',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
          LikeButton(
              mainAxisAlignment: MainAxisAlignment.start,
              likeBuilder: (bool isLiked) {
                return Icon(
                  Icons.thumb_up,
                  color: isLiked ? Colors.deepOrange[600] : Colors.grey,
                );
              },
              likeCount: int.parse(
                  '${widget.commentList['answer'][index]['goodNum']}'))
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.black12))),
    );
  }

  //回复框
  Widget _buildCommentInput() {
    return Card(
      elevation: 0,
      child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
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
      )),
    );
  }
}
