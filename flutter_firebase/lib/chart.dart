import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class Chart extends StatelessWidget {
  Chart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text('Chart'),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream : FirebaseFirestore.instance.collection('list').snapshots(),
          builder: (context, snapshot){
            if(!snapshot.hasData) return const LinearProgressIndicator();
            return SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              title: ChartTitle(text: 'Programming language'),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<ProgrammingData, String>>[
                ColumnSeries<ProgrammingData, String>(
                    color: Colors.deepPurpleAccent,
                    dataSource: snapshot.data?.docs.map((chart)=> ProgrammingData(
                      chart['name'],
                      chart['votes']
                    )).toList() as List<ProgrammingData>,
                    xValueMapper: (ProgrammingData data, _) => data.name,
                    yValueMapper: (ProgrammingData data,_)=> data.votes,
                    dataLabelSettings: const DataLabelSettings(isVisible: true)
                )
              ]
            );
          }
        )
    );
  }
}

class ProgrammingData {
  ProgrammingData(this.name, this.votes);

  final String name;
  final int votes;
}
