import 'package:flutter/material.dart';
import './pages/index_page.dart';
import './routes/Routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '学习平台',
      home: IndexPage(),
      theme: ThemeData(
          primarySwatch: Colors.yellow,
          highlightColor: Colors.yellow[300],
          splashColor: Colors.yellow[400]),
      onGenerateRoute: onGenerateRoute,
    );
  }
}
