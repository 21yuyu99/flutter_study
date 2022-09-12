import 'package:flutter/material.dart';
import 'dart:async';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StopWatch',
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
      home: const Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<String> lapTimes = []; //랩 타임을 기록할 변수
  Stopwatch watch = Stopwatch(); // 지속적으로 시간이 지나가는 변수
  String elapsedTime ='00:00:00:000'; // 경과시간을 기록하는 변수

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StopWatch'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding : const EdgeInsets.all(20),
              child: Text(
                  elapsedTime,
                  style: const TextStyle(
                  fontSize: 25
                )
              ),
            ),
            Container(
              width: 100,
              height: 200,
              child: ListView(
                  children: lapTimes.map((time)=> Text(time)).toList(),
                )

            ),
            Container(
              width: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(onPressed: (){
                    if(!watch.isRunning){
                      startWatch();
                    }
                    else{
                      stopWatch();
                    }
                  },
                    child: !watch.isRunning ? const Icon(Icons.play_arrow): const Icon(Icons.stop)
                  ),
                  FloatingActionButton(onPressed: (){
                    if(!watch.isRunning){
                      resetWatch();
                    }
                    else{
                      recordLapTime(elapsedTime);
                    }
                  },
                    child: !watch.isRunning ? const Text('Reset') : const Text('Lab')
                  ),
                ],
              )
            )

          ],
        )
      )
    );
  }

  transTime(int milliseconds){
    int seconds = (milliseconds / 1000).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String hoursStr = (hours % 60).toString().padLeft(2, '0');

    return "$hoursStr:$minutesStr:$secondsStr:$milliseconds";
  }

  updateTime(Timer timer){
    if(watch.isRunning){
      setState(() {
        elapsedTime = transTime(watch.elapsedMilliseconds);
      });
    }
  }

  startWatch(){
    watch.start();
    Timer.periodic(const Duration(microseconds: 100), updateTime);
  }

  stopWatch(){
    setState(() {
      watch.stop();
    });
  }

  resetWatch(){
    setState(() {
      watch.reset();
      setTime();
      lapTimes.clear();
    });
  }

  setTime(){
    var timeFar = watch.elapsedMilliseconds;
    setState(() {
      elapsedTime = transTime(timeFar);
    });
  }

  recordLapTime(String time){
    lapTimes.insert(0,'Lab ${lapTimes.length +1} $time');
  }
}

