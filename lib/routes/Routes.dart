import 'package:flutter/material.dart';
import 'package:learning_community/pages/home_page.dart';
import '../pages/community/Tabs.dart';
import '../pages/community/Tabs/teacher_quetion.dart';

//配置路由
final routes = {
  '/':(context) => HomePage(),
  '/home':(context)=>HomePage(),
  '/community/teacherQue': (context) => TeacherQue(),
  '/colloquy': (context) => Colloquy(),
  '/bulltin': (context) => Bulletin()
};

var onGenerateRoute=(RouteSettings settings) {
  // 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    }else{
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context));
      return route;
    }
  }
};