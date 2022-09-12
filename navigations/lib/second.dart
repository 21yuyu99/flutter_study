import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SecondPage'),

      ),
        body: Center(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context, 'ok');
                  },
                  child: const Text('back'),
                )
              ],
            )
        )

    );
  }
}
