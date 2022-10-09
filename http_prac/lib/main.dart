import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'HttpPractice.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Puppy_directory',
      theme: ThemeData(
        fontFamily: 'CookieRun_Re'
      ),
      home: const HttpPractice(),
    );
  }
}




