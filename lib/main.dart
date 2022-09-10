import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_app/services/network_remote/dio_helper.dart';
import 'package:weather_app/util/blocs/cubit.dart';

import 'presentation/main_screen/page/main_screen_page.dart';
import 'test.dart';

void main() {
  
  // SharedPreferences.setMockInitialValues({});
  
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper(); 

HttpOverrides.global = MyHttpOverrides();
   
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>(
          create: (context) => AppBloc()..getCurrentWeather(),
          //..initDatabase(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          //primarySwatch: Colors.blue,
        ),
        home: MainScreen(),
      ),
    );
  }
}
 
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}