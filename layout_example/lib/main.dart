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
      home: Layout()
  );
}
}
class Layout extends StatefulWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  State<Layout> createState() => _LayoutState();


}

class _LayoutState extends State<Layout> {
  bool star = true;
  int count = 41;

  @override
  Widget build(BuildContext context) {
    Widget imageSection = Image.network(
      'https://upload.wikimedia.org/wikipedia/commons/d/d7/Sky.jpg',
      height:240,
      width:600,
      fit: BoxFit.cover,
    );
    Widget titleSection = Container(
        padding: EdgeInsets.all(32),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('This is Sky',
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      )
                  ),
                  Text('korea',
                      style: TextStyle(
                          color: Colors. grey[500]
                      )
                  ),
                ],
              ),
            ),
            IconButton(
              icon : star
              ? Icon(Icons.star)
              : Icon(Icons.star_border),
              color: Colors.red,
              onPressed: (){
                setState(() {
                  if(star){
                    star = !star;
                    count = count - 1;
                  }else{
                    star = !star;
                    count = count + 1;
                  }
                });
              },
            ),
            Text('$count'),
          ],
        )
    );

    Widget buttonSection = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Icon(Icons.call, color: Colors.blue),
              Text('CALL', style: TextStyle(color: Colors.blue)),
            ],
          ),
          Column(
            children: [
              Icon(Icons.near_me, color: Colors.blue),
              Text('ROUTE', style: TextStyle(color: Colors.blue)),
            ],
          ),
          Column(
            children: [
              Icon(Icons.share, color: Colors.blue),
              Text('SHARE', style: TextStyle(color: Colors.blue)),
            ],
          ),
        ]
    );

    Widget textSection = Container(
        padding: EdgeInsets.all(32),
        child: Text('Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
            'Alps. Situated 1,578 meters above sea level, it is one of the '
            'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
            'half-hour walk through pastures and pine forest, leads you to the '
            'lake, which warms to 20 degrees Celsius in the summer. Activities '
            'enjoyed here include rowing, and riding the summer toboggan run.',)
    );

    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter example'),
        ),
        body: ListView(
          children: [
            imageSection,
            titleSection,
            buttonSection,
            textSection,
            // Image Section

          ],
        )
    );
  }
}




