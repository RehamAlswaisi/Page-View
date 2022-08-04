import 'package:flutter/material.dart';
import 'package:flutter_pageview/p_view.dart';

void main() {
  runApp(PView());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: ThemeData(primaryColor: Colors.blue, canvasColor: Colors.white),
      darkTheme:
          ThemeData(primaryColor: Colors.blue, canvasColor: Colors.black),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _x = GlobalKey<ScaffoldState>();

  String str = 'Flutter Demo';
  @override
  Widget build(BuildContext context) {
    return PView();
  }
}
