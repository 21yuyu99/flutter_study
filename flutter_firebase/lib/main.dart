import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'chart.dart';
// import 'firebase_options.dart';


// void main() {
//
//   runApp(const MyApp());
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      home: HomePage(),
    );
  }
}
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  Widget sample = Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: const ListTile(
                title: Text('c'),
                trailing: Text('20'),
              )
          ),
          Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: const ListTile(
                title: Text('c'),
                trailing: Text('20'),
              )
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: const ListTile(
              title: Text('c'),
              trailing: Text('20'),
            ),

          )
        ],
      )
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Votes'),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Chart())
                );
              },
              icon: const Icon(Icons.show_chart)
          )
        ]
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('list')
            .snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData) return const LinearProgressIndicator();
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: snapshot.data?.docs.map((data) =>
            buildListItem(context,data)).toList() as List<Widget>
          );
        }
      )
    );
  }
  Widget buildListItem(BuildContext context, DocumentSnapshot document){
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ListTile(
        //title: Text(document.data['name']),
        title: Text(document.get('name')),
        trailing: Text(document.get('votes').toString()),
        onTap: () => document.reference.update({'votes': FieldValue.increment(1)}),
      )
    );
  }
}