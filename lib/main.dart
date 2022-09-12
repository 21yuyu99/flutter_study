import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: ContainerWidget(),
    );
  }
}

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Flutter example'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('title'),
            subtitle: Text('Flutter is very easy framework'),
            trailing: Icon(Icons.watch),
            onTap: (){
              print('tap');
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          print('123');
        },
        child: Icon(Icons.stop),
        backgroundColor: Colors.green,
      ),
    );
  }
}

