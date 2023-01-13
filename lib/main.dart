import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'application_state.dart';
import 'pages/arrangement.dart';
import 'pages/contractor.dart';
import 'pages/contractor_list.dart';
import 'pages/home_page.dart';
import 'pages/not_found_page.dart';
import 'pages/parking_lot_list.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => ApplicationState(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parking Lot Version1',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        // primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/home',
      routes: {
        '/': (content) => const HomePage(),
        '/home': (context) => const HomePage(),
        '/parking_lot_list': (context) => const ParkingLotList(), //駐車場区画一覧
        '/arrangement': (context) => const Arrangement(), //駐車場配置
        '/contractor_list': (context) => const ContractorList(), //契約者
        '/contractor': (context) => const Contractor(), //契約者
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute<void>(
            settings: settings,
            builder: ((BuildContext context) => const NotFoundPage()));
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
