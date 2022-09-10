import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/util/blocs/states.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

import '../../models/weather.dart';
import '../../services/network_remote/dio_helper.dart';
import '../../services/network_remote/end_points.dart';
import 'package:intl/intl.dart';

import '../secure_storage.dart';

class AppBloc extends Cubit<AppStates> {
  AppBloc() : super(AppInitialState());

  static AppBloc get(context) => BlocProvider.of<AppBloc>(context);

  CurrentWeatherModel? currentWeatherModel;
  TextEditingController? cityEditController = TextEditingController(text: "Cairo");
  //  SharedPreferences? preferences;
 //late List<Hour> hour;
  
  //     Future init() async {
  //    preferences =
  //     await SharedPreferences.getInstance();
  //     if(cityEditController!.text.toString()==null) return; 
  //      //setState(()=>cityEditController);
  // }

  // Future init()async{
  //   final cityname = await UserSecureStorage.getCityName()??"cairo";
    
  //     cityEditController!.text = cityname;
  //     emit(GetCurrentWeatherSuccess());
    
  // }
  
  void getCurrentWeather() async {

    Dio dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.weatherapi.com',
        receiveDataWhenStatusError: true,
      ),
    );

    emit(GetCurrentWeatherLoading());

    Response currentWeatherResponse =
        await DioHelper.getData(url: forecast, query: {
         // 3abc4ac71f114deb86380405201809 
      'key': 'b9f2622f7bf14eaeaa4162637220509',
      'q': cityEditController!.text.toString(),
      'days': 7,
      'aqi': 'no',
      'alerts': 'no',
    });

    emit(GetCurrentWeatherSuccess());

    debugPrint('---------------------');
    currentWeatherModel = CurrentWeatherModel.fromJson(
      currentWeatherResponse.data,
    );
    // DateTime localltime = DateTime.parse(currentWeatherModel!.location.localtime);
    // String localtimeOfDay = DateFormat('E').format(localltime).toString();
    // String localtimehour = DateFormat.jm().format(localltime).toString();
    debugPrint(currentWeatherModel!.location.name);
    debugPrint("focus here"+currentWeatherModel!.location.localtime);
    // debugPrint(localltime.toString());
    //debugPrint("hereeeeeee"+Intl.DateFormat('dd MMM yyyy HH:mm:ss ZZZ').parse(currentWeatherModel!.location.localtime).toString());
    // debugPrint(localtimeOfDay);
    // debugPrint(DateFormat.jm().format(localltime).toString());
    debugPrint(currentWeatherModel!.current.tempC.toString());
    debugPrint(currentWeatherModel!.current.condition);
    debugPrint(currentWeatherModel!.current.feelslikeC.toString());
    debugPrint(currentWeatherModel!.current.uv.toString());
    debugPrint(currentWeatherModel!.current.windKph.toString());
    debugPrint(currentWeatherModel!.current.humidity.toString());
    debugPrint(currentWeatherModel!.forecast.forecastday[0].date.toString());
    debugPrint('sunrise '+currentWeatherModel!.forecast.forecastday[0].sunrise.toString());
    debugPrint('maxtempC day  '+currentWeatherModel!.forecast.forecastday[0].maxtempC.toString());
    debugPrint('hour api '+currentWeatherModel!.forecast.forecastday[0].hour[1].time.toString());
    debugPrint(currentWeatherResponse.statusCode.toString());
    debugPrint('--0000000000-----');
    // h();
    
   
    //debugPrint('sunrise '+currentWeatherModel!.forecast.sunrise);
    //debugPrint('sunset '+currentWeatherModel!.forecast.sunset);
  }
  void h (){
    for(var i =0;i<currentWeatherModel!.forecast.forecastday[0].hour.length;i++){
      DateTime localltime =
              DateTime.parse(currentWeatherModel!.forecast.forecastday[0].hour[i].time);
          String localtimeOfDay = DateFormat('E').format(localltime).toString();
           String localtimehour = DateFormat.jm().format(localltime).toString();
              debugPrint(currentWeatherModel!.forecast.forecastday[0].hour[i].time.toString());
              debugPrint(localtimeOfDay);
              debugPrint(localtimehour);
              }
  }
  // void getCurrentWeather0() async {

  //   Dio dio = Dio(
  //     BaseOptions(
  //       baseUrl: 'https://api.weatherapi.com',
  //       receiveDataWhenStatusError: true,
  //     ),
  //   );

  //   emit(GetCurrentWeatherLoading());

  //   Response currentWeatherResponse =
  //       await DioHelper.getData(url: forecast, query: {
  //        // 3abc4ac71f114deb86380405201809 
  //     'key': 'b9f2622f7bf14eaeaa4162637220509',
  //     'q': cityEditController.toString(),
  //     'days': 7,
  //     'aqi': 'no',
  //     'alerts': 'no',
  //   });

  //   emit(GetCurrentWeather0Success());

  //   debugPrint('---mewooo----');
  //   debugPrint(currentWeatherModel!.location.name);
    
  // }
  late Database database;
  void initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'weather.db');

    debugPrint('AppDatabaseInitialized');

    openWeatherDatabase(
      path: path,
    );

    emit(DatabaseInitialized());
  }

  void openWeatherDatabase({required String path}) async {
     openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          '''CREATE TABLE weather (id INTEGER PRIMARY KEY, cityName TEXT)''',
        ).catchError((error) {
          debugPrint('Error ${error.toString}');
        });
        debugPrint('Table Created');
      },
      onOpen: (Database db) {
        debugPrint('AppDatabaseOpened');
        database = db;

      getCityName();
      },
    ).catchError((onError){
          debugPrint(onError.toString());
    });
    emit(DatabaseOpened());

  }

  void insertData(
    String citYname,
   ) async {

    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'weather.db');
    Database database = await openDatabase(path);

    await database.rawInsert(
        '''INSERT INTO weather(cityName) VALUES(?)''',
        ['$citYname'],
        ).then((value){
          debugPrint('inserted $value');
          emit(DatabaseInserted());
          getCityName();
    }).catchError((onError){
          debugPrint(onError.toString());
    });
// database.close();
  }

  void uptadeCityName(
    int id,
     String citYname
  )async{ 
    database.rawUpdate('''UPDATE weather SET isChecked = ?, status = ? WHERE id = ?''',
    ['$citYname', '$id']).then((value){
      debugPrint('updated $value');
      emit(UpdateCityName());
      getCityName();
    }).catchError((onError){
      debugPrint(onError.toString());
    }
    );
  }

  List<Map> weatherCityNamesList = [];

  void getCityName() async {
    emit(GetCurrentWeatherLoading());

    database.rawQuery('SELECT * FROM weather').then((value) {
      debugPrint('Tasks Fetched');
      weatherCityNamesList = value;
      debugPrint(weatherCityNamesList.toString());
      emit(DatabaseWeather());
    }).catchError((onError){
      debugPrint(onError.toString());
    });
  }

}
