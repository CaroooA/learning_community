import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning_community/service/service_method.dart';
import 'package:learning_community/pages/index_page.dart';
import 'dart:convert';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
    future: getRequest('http://10.0.2.2:3000/home'),
    builder: (context, snapshot) {
    if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.amber,
                title: GestureDetector(
                  onTap: (){
                    showSearch(context: context, delegate:SearchBarDelegate());
                  },
                  child: TextFileWidget(),
                ),
                automaticallyImplyLeading: false,
                actions: <Widget>[
                  new Center(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: Icon(
                            Icons.search,
                            size: 30,
                          ),
                          onPressed: () {
                            showSearch(context: context, delegate:SearchBarDelegate());
                          },
                        )),
                  )
                ],
              ),
              body: Stack(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text('我的课程(${data['data']['count']})',
                          style: TextStyle(fontSize: ScreenUtil().setSp(32)),),
                      )),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top:10),
                    child: CourList(CourseList: data['data']['course']),
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: Text('...加载中'),
            );
          }
        });
  }
}

///搜索控件
class TextFileWidget extends StatelessWidget {
  Widget buildTextField() {
    return TextField(
      cursorColor: Colors.black54,
      decoration: InputDecoration(
          contentPadding: new EdgeInsets.only(left: 0.0),
          fillColor: Colors.black54,
          border: InputBorder.none,
          hintText: "搜索课程",
          hintStyle: new TextStyle(fontSize: 14, color: Colors.black54)),
      style: new TextStyle(fontSize: 14, color: Colors.black54),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget editView() {
      return Container(
        decoration: new BoxDecoration(
          border: Border.all(color: Colors.grey[200], width: 1.0), //灰色的一层边框
          color: Colors.grey[200],
          borderRadius: new BorderRadius.all(new Radius.circular(15.0)),
        ),
        alignment: Alignment.center,
        height: 36,
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
        child: buildTextField(),
      );
    }

    return editView();
  }
}

//课程列表控件
class CourList extends StatelessWidget {
  final List CourseList;
  CourList({Key key, this.CourseList}) : super(key: key);

  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
          padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
          itemCount: CourseList.length,
          controller: _scrollController,
          itemBuilder: (BuildContext context,int index){
            return Container(
              padding: EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context){return IndexPage();}
                  ));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      leading: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(CourseList[index]['image'],fit:BoxFit.cover),
                        ),
                      ),
                      title: Text(CourseList[index]['name']),
                      subtitle: Row(
                        children: <Widget>[
                          Text('${CourseList[index]['teacher']}     '),
                          Expanded(
                            child: Text(CourseList[index]['description'],overflow: TextOverflow.ellipsis,),
                          )
                        ],
                      ),
                      trailing: Icon(Icons.chevron_right),
                    ),
                    Divider(height: 2.0,color: Colors.black12,)
                  ],
                ),
              )
            );
          });
  }
}

class SearchBarDelegate extends SearchDelegate<String> {

  var searchList =
  [
    '数据结构',
    '概率论与数理统计',
    '大国兴衰',
    '离散数学'
  ];


  var recentSuggest = [
  '数据结构',
  '概率论与数理统计'
  ];

  //清空按钮
  @override
  List<Widget>buildActions(BuildContext context){
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = "", //搜索值为空
      )
    ];
  }
  //返回上级按钮
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation
        ),
        onPressed: () => close(context, null)  //点击时关闭整个搜索页面
    );
  }
  //搜到到内容后的展现
  @override
  Widget buildResults(BuildContext context){
    return Container(
      width: 100.0,
      height:100.0,
      child: Card(
        color:Colors.redAccent,
        child: Center(
          child: Text(query),
        ),
      ),
    );
  }
  //设置推荐
  @override
  Widget buildSuggestions(BuildContext context){
    final suggestionsList= query.isEmpty
        ? recentSuggest
        : searchList.where((input)=> input.startsWith(query)).toList();

    return ListView.builder(
      itemCount:suggestionsList.length,
      itemBuilder: (context,index) => ListTile(
        title: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context){return IndexPage();}));
          },
          child: RichText( //富文本
            text: TextSpan(
                text: suggestionsList[index].substring(0,query.length),
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                      text: suggestionsList[index].substring(query.length),
                      style: TextStyle(color: Colors.grey)
                  )
                ]
            ),
          ),
        )
      ),
    );
  }

}