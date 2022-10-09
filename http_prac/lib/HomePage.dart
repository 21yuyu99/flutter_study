import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   Future<List> allDog(int index) async {
    try{
      var url = Uri.https('api.thedogapi.com','/v1/breeds');
      var response = await http.get(url);
      // print('Response body: ${response.body}');
      var decodeData = jsonDecode(response.body);
      var list = [];
      list.add(decodeData[0]['image']['url']);
      return list;
    }
    catch(e){
      debugPrint("failed to load");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('강아지 백과사전')
      ),
      body:
      FutureBuilder(
        future : allDog(0),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(!snapshot.hasData) return CircularProgressIndicator();
          return Column(
              children: [
                Row(
                  children: [
                    Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                            image : DecorationImage(
                              image:
                              NetworkImage(snapshot.data[0]),
                            )
                        )
                    )
                  ],
                )
              ]
          );
        }
      )
    );
  }
}