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
          primarySwatch: Colors.amber,
          highlightColor: Colors.amber[300],
          splashColor: Colors.amber[300]),
      onGenerateRoute: onGenerateRoute,
    );
  }
}
