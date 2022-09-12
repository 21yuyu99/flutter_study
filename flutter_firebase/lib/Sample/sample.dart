import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
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
      home: HomePages(),
    );
  }
}
class HomePages extends StatelessWidget {
  HomePages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget liveData = StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('test')
            .doc('test2')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const LinearProgressIndicator();
          // final data = snapshot.data as Map<String, dynamic>;
          //final Object? data = snapshot.data;
          final data = snapshot.data as DocumentSnapshot;
          return Text(data['name']);
        });
    // return Text(snapshot.data['name']);
    Widget getData = Center(
        child: Column(
            children:
            data.map((function)=>
                ElevatedButton(
                  onPressed: ()=>function.call(),
                  child: Text((RegExp(r"['](.*?)[']").stringMatch(function.toString()))?.replaceAll("'","") as String),
                )).toList()
        )
    );
    return Scaffold(
        appBar: AppBar(
          title: const Text('firebase'),
        ),
        body: getData
    );
  }


  List<Function> data = const [documentGets, documentSets1, documentSets2, documentRemoves,
    fieldGets,fieldAdds,fieldRemoves];

  //Document
  static documentGets(){
    FirebaseFirestore.instance
        .collection('test')
        .get()
        .then((value)=>{
      for(DocumentSnapshot doc in value.docs){
        print(doc.id)
      },
      print('Done documentGets')
    });
  }

  static documentSets1(){
    FirebaseFirestore.instance
        .collection('test')
        .doc('test3 ')
        .set({
      'type': 'user info'
    })
        .then((value){
      debugPrint('Done documentSets1');
    });
  }

  static documentSets2(){
    FirebaseFirestore.instance
        .collection('test')
        .add({'type': 'user info'})
        .then((value){
      debugPrint('Done documentSets2');
    });
  }

  static documentRemoves(){
    FirebaseFirestore.instance
        .collection('test')
        .doc('test1')
        .delete()
        .then((value){
      debugPrint('Done documentRemoves');
    });
  }

  static fieldGets(){
    FirebaseFirestore.instance
        .collection('test')
        .doc('test2')
        .get()
        .then((value){
      //debugPrint((value.data as DocumentSnapshot)['name']);
      //debugPrint(value.data()?['name']);

      debugPrint(value.data().toString());

    });
  }
  static fieldAdds(){
    FirebaseFirestore.instance
        .collection('test')
        .doc('test2')
        .update({
      'type' : 'user info',
    }).then((_){
      debugPrint('Done fieldAdds');
    });
  }

  static fieldRemoves(){
    FirebaseFirestore.instance
        .collection('test')
        .doc('test2')
        .update({
      'type':FieldValue.delete()
    }).then((_){
      debugPrint('Done fieldRemoves');
    });
  }
}


