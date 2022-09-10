import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../util/blocs/cubit.dart';
import '../../../util/blocs/states.dart';

class SearchTextField extends StatelessWidget {
   SearchTextField({super.key});
 
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppStates>(
      listener: (context, state) {},
        builder: (context, state){
          return Container(
         // margin: EdgeInsets.all(20),
          padding: EdgeInsets.only(left: 5, top: 5, right: 20, bottom: 00),
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  // model.updateCity(cityEditController.text);
                  // model.refreshWeather(cityEditController.text, context);
                },
              ),
              SizedBox(width: 10),
              Expanded(
                  child: TextField(
                      controller: AppBloc.get(context).cityEditController,
                      decoration:
                          InputDecoration.collapsed(hintText: "Enter City"),
                      onSubmitted: (value) {
                            // model.refreshWeather(city, context)
                          })),
            ],
          ));
        }
    );
  }
}
