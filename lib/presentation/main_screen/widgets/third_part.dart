// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../util/blocs/states.dart';
import '../../../util/blocs/cubit.dart';

class ThirdPart extends StatelessWidget {
  const ThirdPart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppStates>(
      listener: (context, state) {},
      builder: (context, state){
        String? _localtimeOfDay;
        return Container(
          padding: EdgeInsets.only(bottom: 18),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            20,
          ),
          border: Border.all(
            color: const Color(0xffB2D6FF),
            width: 1,
          ),
          color: const Color(0xffB2D6FF).withOpacity(0.30),
        ),
        child: ListView.builder(
            physics : const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 7,
            itemBuilder: ((context, index) {
              DateTime _localltime =
              DateTime.parse(AppBloc.get(context).currentWeatherModel!.forecast.forecastday[index].date);
           _localtimeOfDay = DateFormat('EEEE').format(_localltime).toString();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(3),
                    //color: Colors.red,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,0,0,1),
                          child: SizedBox(
                            width: 100,
                            child: Text(_localtimeOfDay!,
                            style: const TextStyle(fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold))),
                        ),
                        const Icon(
                          Icons.water_drop_sharp,
                          size: 18,
                          color: Color(0xffB9D6F6),
                        ),
                        const SizedBox(width: 2),
                        Text(
                            "${AppBloc.get(context).currentWeatherModel!.forecast.
                          forecastday[index].avghumidity.toStringAsFixed(0)}%",
                          style: const TextStyle(fontSize: 12,color: Colors.white)),
                        const SizedBox(width: 20),
                        const Icon(
                          Icons.circle,
                          size: 24,
                          color: Colors.yellow,
                        ),
                        const SizedBox(width: 14),
                        Transform.rotate(
                          angle: -math.pi / 4,
                          child: const Icon(
                            Icons.nightlight_sharp,
                            size: 24,
                            color: Colors.yellow,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Text(
                         "${AppBloc.get(context).currentWeatherModel!.forecast.
                          forecastday[index].maxtempC.toStringAsFixed(0)}\u00B0 ",
                          style: const TextStyle(fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                        Text(
                          "${AppBloc.get(context).currentWeatherModel!.forecast.
                          forecastday[index].mintempC.toStringAsFixed(0)}\u00B0",
                          style: const TextStyle(fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                      ],
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
