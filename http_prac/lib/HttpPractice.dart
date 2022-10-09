import 'package:flutter/material.dart';
import 'package:http_prac/HomePage.dart';

class HttpPractice extends StatefulWidget {
  const HttpPractice({Key? key}) : super(key: key);

  @override
  State<HttpPractice> createState() => _HttpPracticeState();
}

class _HttpPracticeState extends State<HttpPractice> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffc5b2fc),
      body: Center(
          child :
          Container(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=> const HomePage()),
                );
              }, child: Text('강아지\n백과사전',
            style: TextStyle(fontFamily: 'CookieRun_Re')
            ),
              style: ElevatedButton.styleFrom(
                primary: Color(0xff885aef),
                padding: EdgeInsets.all(60),
                shadowColor: Color(0xff885aef),
                elevation: 20,
                shape: CircleBorder(),
                textStyle: TextStyle(fontSize: 25),
              ),
        ),
      )
      )
    );
  }
}