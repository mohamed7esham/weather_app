// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/presentation/main_screen/page/manage_locations.dart';
import 'package:weather_app/presentation/main_screen/widgets/first_part.dart';
import 'package:weather_app/presentation/main_screen/widgets/third_part.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../util/blocs/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sticky_headers/sticky_headers.dart';

import '../../../util/blocs/states.dart';
import '../../chart/hourly_chart.dart';
import '../../contact_us/contact_us.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late ScrollController scrollController;

  Color bg = Colors.transparent;
  Color SilverAppBarbg = Colors.transparent;

  double topPading = 10;

  bool visble = true;


  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    //getConnetivity();
    scrollController = ScrollController();

    scrollController.addListener(() {
      //debugPrint(scrollController.position.pixels.toString());
      //setState(() {/* State being set is the Scroll Controller's offset */});

      if (scrollController.position.pixels > 128) {
        setState(() {
          SilverAppBarbg = Colors.black;
          bg = SilverAppBarbg;
          topPading = 80;
          visble = false;
        });
      } else {
        setState(() {
          SilverAppBarbg = Colors.transparent;
          bg = SilverAppBarbg;
          topPading = 10;
          visble = true;
        });
      }
    });

    super.initState();

    AppBloc.get(context).getCurrentWeather();
    //AppBloc.get(context).initDatabase();
  }

  // getConnetivity() => 
  // subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async{
  //   isDeviceConnected = await InternetConnectionChecker().hasConnection;
  //   if(!isDeviceConnected && isAlertSet == false){
  //     showDialogBox();
  //     setState(() => isAlertSet = true);
  //   }

  //  },);


  @override
  void dispose() {
    //subscription.cancel();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          String? _localtimeOfDay;
          String? _localtimehour;
          if (state is GetCurrentWeatherLoading) {
            return const Scaffold(
                backgroundColor: Colors.lightBlueAccent,
                body: Center(child: CircularProgressIndicator()));
          }
          if (state is GetCurrentWeatherSuccess) {
            DateTime _localltime = DateTime.tryParse(AppBloc.get(context)
                    .currentWeatherModel!
                    .location
                    .localtime) ??
                DateTime.now();
            _localtimeOfDay = DateFormat('E').format(_localltime).toString();
            _localtimehour = DateFormat.jm().format(_localltime).toString();
          } else {}
          return RefreshIndicator(
            onRefresh: () async {
              AppBloc.get(context).getCurrentWeather();
            },
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Color(0xff7E9AD4), Colors.lightBlueAccent])),
              child: Scaffold(
                //appBar: true ? AppBar(title: Text('l'),) : PreferredSize(preferredSize: Size(0.0, 0.0),child: Container(),),
                backgroundColor: bg,
                extendBodyBehindAppBar: true,
                body: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    // SliverAppBar(
                    //   toolbarHeight: 100,
                    //   //collapsedHeight:200,
                    //   expandedHeight: 200,
                    //   elevation: 0,
                    //    backgroundColor: SilverAppBarbg,
                    //   automaticallyImplyLeading:true,
                    //   pinned: true,
                    //   //toolbarHeight: 100,
                    //   title: Visibility(
                    //     visible: true,
                    //     child: Text(
                    //       AppBloc.get(context)
                    //               .currentWeatherModel!
                    //               .location
                    //               .region +
                    //           ", " +
                    //           AppBloc.get(context)
                    //               .currentWeatherModel!
                    //               .location
                    //               .name,
                    //       style: const TextStyle(color: Colors.white),
                    //     ),
                    //   ),
                    //  flexibleSpace: FlexibleSpaceBar(
                    //   title: Container(
                    //       child: Row(
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           Text(
                    //             AppBloc.get(context)
                    //                     .currentWeatherModel!
                    //                     .current
                    //                     .tempC
                    //                     .toStringAsFixed(0) +
                    //                 "\u00B0",
                    //             style: const TextStyle(
                    //                 fontSize: 40, color: Colors.white),
                    //           ),
                    //           Lottie.asset(
                    //             'assets/lottie_animation/sun.json',
                    //             width: 70,
                    //             height: 70,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //  ),
                    // ),
                    SliverAppBar(
                      expandedHeight: 150,
                      automaticallyImplyLeading: true,
                      stretch: true,
                      backgroundColor: SilverAppBarbg,
                      elevation: 0,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Align(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Visibility(
                                    visible: true,
                                    child: Text(
                                      AppBloc.get(context)
                                              .currentWeatherModel!
                                              .location
                                              .region +
                                          ", " +
                                          AppBloc.get(context)
                                              .currentWeatherModel!
                                              .location
                                              .name,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              // const Icon(
                              //   Icons.location_on,
                              //   size: 20,
                              //   color: Colors.white,
                              // )
                            ],
                          ),
                        ),
                      ),
                      pinned: true,
                    ),

                    SliverList(
                        delegate: SliverChildListDelegate([
                      StickyHeader(
                        header: Container(
                          color: bg,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(30, topPading, 10, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppBloc.get(context)
                                          .currentWeatherModel!
                                          .current
                                          .tempC
                                          .toStringAsFixed(0) +
                                      "\u00B0",
                                  style: const TextStyle(
                                      fontSize: 56, color: Colors.white),
                                ),
                                Visibility(
                                  visible: !visble,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            AppBloc.get(context)
                                                    .currentWeatherModel!
                                                    .forecast
                                                    .forecastday[0]
                                                    .maxtempC
                                                    .toStringAsFixed(0) +
                                                "\u00B0 / " +
                                                AppBloc.get(context)
                                                    .currentWeatherModel!
                                                    .forecast
                                                    .forecastday[0]
                                                    .mintempC
                                                    .toStringAsFixed(0) +
                                                "\u00B0",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '$_localtimeOfDay, $_localtimehour',
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Lottie.asset(
                                  'assets/lottie_animation/sun.json',
                                  width: 100,
                                  height: 100,
                                ),
                              ],
                            ),
                          ),
                        ),
                        content: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(30, 0, 10, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Visibility(
                                    visible: visble,
                                    child: Text(
                                      AppBloc.get(context)
                                              .currentWeatherModel!
                                              .forecast
                                              .forecastday[0]
                                              .maxtempC
                                              .toStringAsFixed(0) +
                                          "\u00B0 / " +
                                          AppBloc.get(context)
                                              .currentWeatherModel!
                                              .forecast
                                              .forecastday[0]
                                              .mintempC
                                              .toStringAsFixed(0) +
                                          "\u00B0" +
                                          " Feels like " +
                                          AppBloc.get(context)
                                              .currentWeatherModel!
                                              .current
                                              .feelslikeC
                                              .toStringAsFixed(0) +
                                          "\u00B0",
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            Visibility(
                              visible: visble,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${_localtimeOfDay!}, ${_localtimehour!}',
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 50),
                            const MyWidget(),
                            const SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  20,
                                ),
                                border: Border.all(
                                  color: const Color(0xffB2D6FF),
                                  width: 1,
                                ),
                                color:
                                    const Color(0xffB2D6FF).withOpacity(0.30),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Today's Weather Status",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      "is: " +
                                          AppBloc.get(context)
                                              .currentWeatherModel!
                                              .current
                                              .condition,
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.white)),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            const ThirdPart(),
                            const SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              //height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  20,
                                ),
                                border: Border.all(
                                  color: const Color(0xffB2D6FF),
                                  width: 1,
                                ),
                                color:
                                    const Color(0xffB2D6FF).withOpacity(0.30),
                              ),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  //crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 20, 10, 0),
                                      child: Column(children: [
                                        const Text("Sunrise",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                            )),
                                        SizedBox(height: 5),
                                        Text(
                                            AppBloc.get(context)
                                                .currentWeatherModel!
                                                .forecast
                                                .forecastday[0]
                                                .sunrise
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                        Image.asset(
                                          "assets/images/sunrise.png",
                                          width: 150,
                                          height: 90,
                                        )
                                      ]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Column(children: [
                                        const Text("Sunset",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                            )),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                            AppBloc.get(context)
                                                .currentWeatherModel!
                                                .forecast
                                                .forecastday[0]
                                                .sunset
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Image.asset(
                                          "assets/images/sunset.png",
                                          width: 130,
                                          height: 80,
                                        )
                                      ]),
                                    ),
                                  ]),
                            ),
                            const SizedBox(height: 10),
                            Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    20,
                                  ),
                                  border: Border.all(
                                    color: const Color(0xffB2D6FF),
                                    width: 1,
                                  ),
                                  color:
                                      const Color(0xffB2D6FF).withOpacity(0.30),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(children: [
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ),
                                          border: Border.all(
                                            color: const Color(0xffFCE29B),
                                            width: 4,
                                          ),
                                          color: const Color(0xffFEC72B),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 9,
                                      ),
                                      const Text("Uv index",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                          AppBloc.get(context)
                                              .currentWeatherModel!
                                              .forecast
                                              .forecastday[0]
                                              .uv
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                          )),
                                    ]),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Container(
                                        width: 1,
                                        height: 80,
                                        color: Colors.white.withOpacity(0.40),
                                      ),
                                    ),
                                    Column(children: [
                                      Image.asset(
                                        color: Colors.white,
                                        colorBlendMode: BlendMode.colorBurn,
                                        "assets/images/wind.png",
                                        width: 50,
                                        height: 50,
                                      ),
                                      const Text('wind',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                          AppBloc.get(context)
                                                  .currentWeatherModel!
                                                  .current
                                                  .tempC
                                                  .toStringAsFixed(0) +
                                              ' km/h',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                          )),
                                    ]),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Container(
                                        width: 1,
                                        height: 80,
                                        color: Colors.white.withOpacity(0.40),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 19),
                                      child: Column(children: [
                                        Image.asset(
                                          "assets/images/dropwater.png",
                                          width: 50,
                                          height: 50,
                                        ),
                                        const Text('Humidity',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                            AppBloc.get(context)
                                                    .currentWeatherModel!
                                                    .current
                                                    .humidity
                                                    .toStringAsFixed(0) +
                                                '%',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                            )),
                                      ]),
                                    ),
                                  ],
                                )),
                            SizedBox(height: 30),
                            //HourlyChart(),
                          ]),
                        ),
                      ),
                    ])),
                    // SliverFixedExtentList(
                    //   itemExtent:20,
                    //   delegate:SliverChildListDelegate(
                    //     (BuildContext context) {
                    //       return Column();
                    //     },
                    //   ),
                    // ),
                  ],
                ),
                drawer: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 550,
                      child: Drawer(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                        ),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xff2F3943),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.settings_outlined,
                                        color: Colors.white.withOpacity(0.65),
                                      )),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.star_rate_rounded,
                                          color: Colors.white)),
                                  Text(
                                    'Favourite location',
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.65)),
                                  ),
                                  const SizedBox(
                                    width: 58,
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.info_outlined,
                                        color: Colors.white.withOpacity(0.65),
                                      )),
                                ]),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                      Text(
                                          AppBloc.get(context)
                                              .cityEditController!
                                              .text
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(
                                        width: 55,
                                      ),
                                      const Icon(
                                        Icons.circle,
                                        size: 20,
                                        color: Colors.yellow,
                                      ),
                                      Text(
                                          AppBloc.get(context)
                                                  .currentWeatherModel!
                                                  .current
                                                  .tempC
                                                  .toStringAsFixed(0) +
                                              "\u00B0",
                                          style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.65),
                                            fontSize: 14,
                                          ))
                                    ]),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    '.........................................'
                                    '..................',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.45),
                                    )),
                                Row(children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.add_location_outlined,
                                        size: 24,
                                        color: Colors.white.withOpacity(0.65),
                                      )),
                                  Text('Other locations',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.65),
                                      )),
                                ]),
                                const SizedBox(
                                  height: 25,
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('saint Cathrine',
                                          style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.65),
                                          )),
                                      const SizedBox(
                                        width: 100,
                                      ),
                                      const Icon(
                                        Icons.circle,
                                        size: 20,
                                        color: Colors.yellow,
                                      ),
                                      Text(' 29\u00B0',
                                          style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.65),
                                          ))
                                    ]),
                                const SizedBox(
                                  height: 25,
                                ),
                                MaterialButton(
                                  minWidth: double.infinity,
                                  height: 45,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              manageLocations()),
                                    );
                                  },
                                  color: const Color(0xff555D6A),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24)),
                                  child: Center(
                                      child: Text(
                                    'Manage locations',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white.withOpacity(0.75)),
                                  )),
                                ),
                                Text(
                                    '.........................................'
                                    '..................',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.45),
                                    )),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.error_outline_sharp,
                                      color: Colors.white.withOpacity(0.45),
                                    ),
                                    const SizedBox(
                                      width: 25,
                                    ),
                                    Text('Report wrong location',
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.65),
                                            fontSize: 16)),
                                  ],
                                ),
                                const SizedBox(height: 25),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ContactUs()),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.headset_mic_outlined,
                                        color: Colors.white.withOpacity(0.45),
                                      ),
                                      const SizedBox(
                                        width: 25,
                                      ),
                                      Text('Contact us',
                                          style: TextStyle(
                                              color: Colors.white
                                                  .withOpacity(0.65),
                                              fontSize: 16)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

//   showDialogBox() => showCupertinoDialog<String>(
//   context: context,
//  builder: (BuildContext context) => CupertinoAlertDialog(
//   title: const Text('No internet'),
//   content: const Text('Please check your internect connection'),
//   actions: <Widget>[
//     TextButton(onPressed: ()async{
//       Navigator.pop(context, 'Cancel');
//       setState(() {
//         isAlertSet = false;
//       });
//       isDeviceConnected = await InternetConnectionChecker().hasConnection;
//       if (!isDeviceConnected){
//         showDialogBox();
//         setState(() {
//           isAlertSet = true;
//         });
//       }
//     },
//      child: const Text('OK'))
//   ],
//  ));

}


