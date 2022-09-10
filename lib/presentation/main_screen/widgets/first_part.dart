// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../util/blocs/cubit.dart';
import '../../../util/blocs/states.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppStates>(
      listener: (context, state) {},
      builder: (context, state){
          String? _localtimehour;
        if(state is GetCurrentWeatherSuccess){
            
          }
        return Container(
        width: double.infinity,
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            20,
          ),
          border: Border.all(
            color: const Color(0xffB2D6FF),
            width: 1,
          ),
          color: const Color(0xffB2D6FF).withOpacity(0.40),
        ),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: AppBloc.get(context).currentWeatherModel!.forecast.forecastday[0].hour.length,
            itemBuilder: ((context, index) {
              DateTime _localltime =
              DateTime.parse(AppBloc.get(context).currentWeatherModel!.forecast.forecastday[0].hour[index].time);
           _localtimehour = DateFormat.jm().format(_localltime).toString();
              return Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5,18,0,0),
                    child: SizedBox(
                      width: 60,
                      height: 180,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(_localtimehour!,
                          style: const TextStyle(fontSize: 12,color: Colors.white)),
                          const SizedBox(height: 10),
                          const Icon(
                            Icons.circle,
                            size: 24,
                            color: Colors.yellow,
                          ),
                          const SizedBox(height: 10),
                          Text(
                              "${ AppBloc.get(context).currentWeatherModel!.forecast.
                          forecastday[0].hour[index].tempC.toStringAsFixed(0)}\u00B0",
                          style: const TextStyle(fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.water_drop_sharp,
                                size: 13,
                                color: Color(0xffB9D6F6),
                              ),
                              Text("${AppBloc.get(context).currentWeatherModel!.forecast.
                          forecastday[0].hour[index].humidity}%",
                          style: const TextStyle(fontSize: 12,color: Colors.white)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            })),
      );
      }
    );
  }
}
