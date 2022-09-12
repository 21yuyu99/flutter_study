import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  // const FirstPage({Key? key}) : super(key: key);
  final String name;
  const FirstPage({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FirstPage'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: (){
                  Navigator.pop(context);
            },
                child: const Text('back'),
            ),
            Text(name),
          ],
        )
      )
    );
  }
}
