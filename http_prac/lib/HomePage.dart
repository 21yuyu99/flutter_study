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
  Widget dogBox(int index1,int index2){
    return(
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              uploadDog(index1),
              uploadDog(index2),
            ]
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff885aef),
        title:Text('강아지 백과사전')
      ),
      body:
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
             //list last_index = 171
             //무한스크롤
              dogBox(0, 1),
              dogBox(2,3),
              dogBox(4, 5),
            ],
          )

    );
  }
}


Widget uploadDog(int index){
  Future<Object> dogApi(int index) async {
    try{
      var url = Uri.https('api.thedogapi.com','/v1/breeds');
      var response = await http.get(url);
      // print('Response body: ${response.body}');
      var decodeData = jsonDecode(response.body);
      //var list = [];
      //list.add(decodeData[0]['image']['url']);
      var l = Map<String, dynamic>.from(decodeData[index]);
      return l;
    }
    catch(e){
      debugPrint("failed to load");
      return {};
    }
  }
  return(
      FutureBuilder(
          future : dogApi(index),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(!snapshot.hasData) return CircularProgressIndicator();
            return
              Column(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                        image : DecorationImage(
                          image:
                          NetworkImage(snapshot.data['image']['url']),
                        )
                    ),
                  ),
                  Text(snapshot.data['name']),
                ],
              );
          }
      )
  );
}