import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../../util/blocs/cubit.dart';
import '../../util/blocs/states.dart';

class HourlyChart extends StatefulWidget {
  const HourlyChart({super.key});

  @override
  State<HourlyChart> createState() => _HourlyChartState();
}

class _HourlyChartState extends State<HourlyChart> {
 //late List<ChartDetails <dynamic,int>>_chartDetails;
 @override
 void initState() {
  //_chartDetails = getChartData();
    super.initState();
  }
  @override
 
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppStates>(
      listener: (context, state) {},
        builder: (context, state){
         return Container(
            child: SfSparkLineChart(
                //Enable the trackball
                trackball: SparkChartTrackball(
                  width:5,
                    activationMode: SparkChartActivationMode.tap),
                //Enable marker
                marker: SparkChartMarker(
                    displayMode: SparkChartMarkerDisplayMode.all),
                //Enable data label
                labelDisplayMode: SparkChartLabelDisplayMode.all,
                data: <double>[
                  1, 5, -6, 0, 1, -2, 7, -7, -4, -10, 13, -6, 7, 5, 11, 5, 3
                ],
              )
          );
        }
    );
    // SfCartesianChart(series: <ChartSeries>[
    //   LineSeries<ChartSeries,int>(dataSource: _chartDetails,
    //    xValueMapper: (ChartDetails degree, _)=>degree.hour,
    //     yValueMapper:  (ChartDetails degree, _)=>degree.degree)
    // ],);
  }

  //  List<ChartDetails<dynamic,int>> getChartData(){
  //   final List<ChartDetails> chartDetails =[
  //     ChartDetails(hour: 1, degree: 33),
  //     ChartDetails(hour: 2, degree: 14),
  //     ChartDetails(hour: 3, degree: 32),
  //     ChartDetails(hour: 4, degree: 13),
  //     ChartDetails(hour: 5, degree: 24),
  //     ChartDetails(hour: 6, degree: 30),
  //   ];
  //   return chartDetails;
  // }
}

class ChartDetails{
  ChartDetails({required this.degree, required this.hour});
  final int degree;
  final int hour;
}