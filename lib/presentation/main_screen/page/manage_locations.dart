import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_app/util/blocs/cubit.dart';

import '../../../util/blocs/cubit.dart';
import '../../../util/blocs/states.dart';
import '../../../util/secure_storage.dart';
import '../widgets/text_field.dart';

class manageLocations extends StatefulWidget {
  manageLocations({super.key});

  @override
  State<manageLocations> createState() => _manageLocationsState();
}

class _manageLocationsState extends State<manageLocations> {

    @override
  void initState() {
    super.initState();
   // AppBloc.get(context).init();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("manage Locations"),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back)),
            ),
            body: ListView(
              children: 
                [Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text('Add favourite location',
                              style: TextStyle(fontWeight: FontWeight.w700))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SearchTextField(),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: MaterialButton(
                            color: Colors.blue,
                            textColor: Colors.white,
                            minWidth: double.infinity,
                            height: 45,
                            child: Center(
                                child: Text('+ Add Your favourite locatoin')),
                            onPressed: ()async {
                             AppBloc.get(context).insertData(AppBloc.get(context).cityEditController!.text.toString());
                              //await UserSecureStorage.setCityName( AppBloc.get(context).cityEditController!.text.toString());
                              // await AppBloc.get(context).preferences?.setString(
                              //   'CityName',
                              //    AppBloc.get(context).cityEditController!.text.toString());
                                // debugPrint(AppBloc.get(context).preferences?.getString('CityName'));
                                 debugPrint("input city name is :"+AppBloc.get(context).cityEditController!.text.toString());
                                //  if(AppBloc.get(context).cityEditController.toString()==null) return; 
                                //  setState(()=>this.AppBloc.get(context).cityEditController.toString());
                              AppBloc.get(context).getCurrentWeather();
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
