import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpPractice extends StatefulWidget {
  const HttpPractice({Key? key}) : super(key: key);

  @override
  State<HttpPractice> createState() => _HttpPracticeState();
}

class _HttpPracticeState extends State<HttpPractice> {
  void test() async {
    var url = Uri.https('api.thedogapi.com','/v1/breeds');


    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }


  @override
  Widget build(BuildContext context) {
    test();
    return Scaffold(

    );
  }
}
