import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'application_state.dart';
import 'pages/arrangement.dart';
import 'pages/auth.dart';
// import 'pages/contractor.dart';
import 'pages/contractor_list.dart';
import 'pages/home_page.dart';
import 'pages/logout.dart';
import 'pages/not_found_page.dart';
import 'pages/parking_lot_list.dart';
import 'pages/parking_lot_user.dart';
import 'auth_guard.dart';

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
        //駐車場区画一覧
        '/parking_lot_list': ((context) => Consumer<ApplicationState>(
              builder: ((context, appState, _) => AuthGuard(
                    loginState: appState.loginState,
                    guard: const Auth(),
                    child: const ParkingLotList(),
                  )),
            )),
        //区画使用者
        // '/parking_lot_user': (context) => const ParkingLotUser(),
        '/parking_lot_user': ((context) => Consumer<ApplicationState>(
              builder: ((context, appState, _) => AuthGuard(
                    loginState: appState.loginState,
                    guard: const Auth(),
                    child: const ParkingLotUser(),
                  )),
            )),
        //駐車場配置
        // '/arrangement': (context) => const Arrangement(),
        '/arrangement': ((context) => Consumer<ApplicationState>(
              builder: ((context, appState, _) => AuthGuard(
                    loginState: appState.loginState,
                    guard: const Auth(),
                    child: const Arrangement(),
                  )),
            )),
        //契約者
        // '/contractor_list': (context) => const ContractorList(),
        '/contractor_list': ((context) => Consumer<ApplicationState>(
              builder: ((context, appState, _) => AuthGuard(
                    loginState: appState.loginState,
                    guard: const Auth(),
                    child: const ContractorList(),
                  )),
            )),
        //契約者
        // '/contractor': (context) => const Contractor(),
        // '/contractor': ((context) => Consumer<ApplicationState>(
        //       builder: ((context, appState, _) => AuthGuard(
        //             loginState: appState.loginState,
        //             guard: const Auth(),
        //             child: const Contractor(),
        //           )),
        //     )),
        //
        '/login': (context) => const Auth(), //ログイン
        '/logout': (context) => const Logout(), //ログアウト
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
