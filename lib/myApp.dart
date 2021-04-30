import 'package:flutter/material.dart';
import 'package:fd16/screens/home.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Animation",
      theme:  ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: Home(),
    );
  }
}