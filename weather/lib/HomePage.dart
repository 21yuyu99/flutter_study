// import 'dart:js_util/js_util_wasm.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late bool gps;

  var weatherData;
  String url = "http://api.openweathermap.org/data/2.5/weather?";
  String lat ="";
  String lon = "";
  String appid = "appid=accfe7fb300590e570e86118c51a9e17&";
  String units = "units=metric";

  var background = Color(0xFFB1D1CF);
  var textground = Color(0xFF9DBBB9);
  String image = "images/cold_mountain.png";
  DateFormat formatter = DateFormat('H시 m분 s초');
  DateFormat sun = DateFormat('H시 m분');
  void permission() async{
    await Geolocator.requestPermission();
    var value = await Geolocator.checkPermission();
    setState(() {
      if(value == LocationPermission.always || value == LocationPermission.whileInUse) {
        gps = true;
      } else {
        gps= false;
      }
    });
  }
  Future getData()async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
    lat = "lat=" + position.latitude.toString() + '&';
    lon = "lon=" + position.longitude.toString() + '&';

    http.Response response = await http.get(
    Uri.encodeFull(url + lat + lon + appid + units),
      headers: {"Accept" : "application/json"},
    );
    print("Response body: ${response.body}");
    weatherData = jsonDecode(response.body);

    if(weatherData['main']['temp'] < 22){
      background = Color(0xFFB1D1CF);
      image = "images/cold_mountain.png";
      textground = Color(0xFF9DBBB9);
      print("cold");
    }
    else{
      background = Color(0xFFF5CE88);
      image = "images/hot_mountain.png";
      textground = Color(0xFFE5AB48);
      print('hot');
    }
    return weatherData;
  }
  Future<Null> _onRefresh()async{
    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    permission();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding :EdgeInsets.zero,
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Row(
                children: [
                  Text(
                    'Weather Apps',
                    style : TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight : FontWeight.bold
                    )
                  ),
                  Spacer(),
                  IconButton(
                      onPressed:  (){},
                      icon: Icon(Icons.share, color: Colors.black,),
                  )

                ],
              )
            ),
            
            Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image : NetworkImage(
                            'https://i.pinimg.com/originals/f5/51/7b/f5517be6ed6d9a528e9d99482e65dbcf.jpg'
                          ),
                        )
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'reasley',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text('reasley.com@gmail.com', style: TextStyle(
                      color: Colors.black
                    )),
                    Divider(color :Colors.black),
                    ListTile(
                      leading: Icon(Icons.home),
                      title: Text('Home'),
                      onTap: (){
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text('Settings'),
                    )

                  ],
                )
            )
          ],
        )
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                    onPressed: (){
                  _scaffoldKey.currentState?.openDrawer();
                  },
                    icon: Icon(Icons.menu),
                  ),
                    Spacer(),
                    Text('Weather Apps'),
                    Spacer(),

                    gps == true?
                        IconButton(onPressed: (){
                      _scaffoldKey.currentState?.showSnackBar(SnackBar(content : Text('위치 정보를 정상적으로 받아오고 있습니다.')));
                    }, icon: Icon(Icons.gps_fixed))
                        :
                    IconButton(onPressed: (){
                      _scaffoldKey.currentState?.showSnackBar(SnackBar(content : Text('위치 정보가 정상적이지 못합니다.')));
                    }, icon: Icon(Icons.gps_not_fixed)
                    )
                      ],
        ),
                FutureBuilder(
                  future : getData(),
                  builder: (BuildContext context, AsyncSnapshot snapshot){
                    if(!snapshot.hasData) return CircularProgressIndicator();
                    return Container(
                      color: background,
                      child: Column(
                        children: [
                          SizedBox(height: 40,),
                          Text("${snapshot.data['weather'][0]['main']}",
                              style: TextStyle(
                                fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold
                              )
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.location_on, color: Colors.white, size: 16,),
                              Text("${snapshot.data['name']}",
                                style: TextStyle(
                                  fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold
                                )
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("${snapshot.data['main']['temp'].toStringAsFixed(0)}",
                                style: TextStyle(
                                  fontSize: 65, color: Colors.white, fontWeight: FontWeight.bold
                                )
                              ),
                              Column(
                                children: [
                                  Text("°C",
                                  style: TextStyle(
                                    fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold
                                  )
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.keyboard_arrow_up, color: Colors.white, size : 15),
                                      Text("${snapshot.data['main']['temp_max'].toStringAsFixed(0)}°C",
                                      style: TextStyle(
                                        fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold
                                      )),

                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.keyboard_arrow_down, color: Colors.white, size : 15),
                                      Text("${snapshot.data['main']['temp_min'].toStringAsFixed(0)}°C",
                                          style: TextStyle(
                                              fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold
                                          )),

                                    ],
                                  )
                                ],
                              )
                            ],
                          ),

                          ///step4
                          Image.network('http://openweathermap.org/img/wn/' + weatherData['weather'][0]['icon']  + '@2x.png'),
                          Image.asset(image, width: MediaQuery.of(context).size.width),

                          /// Step5
                          Container(
                            padding: EdgeInsets.only(right: 10, top: 10),
                            alignment: Alignment.centerRight,
                            child: Text('Last Updated: ${formatter.format(DateTime.now())}'),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                                color: textground,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('More information',
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                    SizedBox(height: 10),
                                    IntrinsicHeight(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(Icons.water_damage, color: Colors.white),
                                          Column(
                                            children: [
                                              Text('Humidity'),
                                              Text('${snapshot.data['main']['humidity']}%')
                                            ],
                                          ),
                                          VerticalDivider(color: Colors.white,),

                                          Icon(Icons.remove_red_eye, color: Colors.white,),
                                          Column(
                                            children: [
                                              Text('Visibility'),
                                              Text('${snapshot.data['visibility']}')
                                            ],
                                          ),
                                          VerticalDivider(color: Colors.white,),

                                          Icon(Icons.water_damage,color: Colors.white,),
                                          Column(
                                            children: [
                                              Text('Country'),
                                              Text('${snapshot.data['sys']['country']}')
                                            ],
                                          )
                                        ],
                                      )
                                    ),
                                    SizedBox(height: 20),
                                    IntrinsicHeight(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          infoSpace(Icons.speed, 'Wind Speed', '${snapshot.data['wind']['speed']}'),
                                          VerticalDivider(color: Colors.white,),
                                          infoSpace(Icons.speed, 'Wind Deg', '${snapshot.data['wind']['deg']}'),
                                        ],
                                      )
                                    ),
                                    SizedBox(height: 20,),
                                    IntrinsicHeight(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          infoSpace(Icons.wb_sunny, 'Sunset', sun.format(DateTime.fromMillisecondsSinceEpoch(snapshot.data['sys']['sunset']*1000))),
                                          VerticalDivider(color: Colors.white),
                                          infoSpace(Icons.nights_stay, 'Sunrise', sun.format(DateTime.fromMillisecondsSinceEpoch(snapshot.data['sys']['sunrise']*1000))),
                                        ],
                                      )
                                    )
                                  ],



                                )
                              )
                            )
                          ),
                          SizedBox(height: 20,),
                        ],
                      ),
                    );
                  }
                )
              ]

            )
          )
        )
      ),

      // floatingActionButton: FloatingActionButton(
      //     onPressed: (){
      //       // _scaffoldKey.currentState?.openDrawer();
      //       print('http://openweathermap.org/img/wn/' + weatherData['weather'][0]['icon'] + '@2x.png');
      //       // print(gps);
      //       //print(url + lat + lon + appid + units);
      //       //getData();
      //    },
      // ),
    );
  }
  Widget infoSpace(IconData icons, String topText, String bottomText){
    return Container(
      width: MediaQuery.of(context).size.width/2-50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(icons, color: Colors.white,),
          Container(
            width: MediaQuery.of(context).size.width/5,
            child: Column(
              children: [
                Text(topText),
                Text(bottomText),
              ]
          )
          )],
      )
    );
  }
}