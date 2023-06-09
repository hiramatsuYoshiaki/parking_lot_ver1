import 'package:flutter/material.dart';
import 'package:parking_lot_ver1/pages/contractor_detail.dart';
import 'package:parking_lot_ver1/pages/lot_location.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'application_state.dart';
import 'pages/arrangement.dart';
import 'pages/auth.dart';
// import 'pages/contractor.dart';
import 'pages/contractor_list.dart';
import 'pages/home_page.dart';
import 'pages/logout.dart';
import 'pages/not_found_page.dart';
import 'pages/parking_lot_detail.dart';
import 'pages/parking_lot_list.dart';
import 'pages/parking_lot_user.dart';
import 'auth_guard.dart';

void main() {
//splash
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
//--------splash

  runApp(ChangeNotifierProvider(
      create: (context) => ApplicationState(), child: const MyApp()));
  //
  //splash
  FlutterNativeSplash.remove();
  //--------splash
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
        // '/': (content) => const HomePage(),
        '/': ((context) => Consumer<ApplicationState>(
              builder: ((context, appState, _) => AuthGuard(
                    loginState: appState.loginState,
                    guard: const Auth(),
                    child: const HomePage(),
                  )),
            )),
        // '/home': (context) => const HomePage(),
        '/home': ((context) => Consumer<ApplicationState>(
              builder: ((context, appState, _) => AuthGuard(
                    loginState: appState.loginState,
                    guard: const Auth(),
                    child: const HomePage(),
                  )),
            )),
        //駐車場区画一覧
        '/parking_lot_list': ((context) => Consumer<ApplicationState>(
              builder: ((context, appState, _) => AuthGuard(
                    loginState: appState.loginState,
                    guard: const Auth(),
                    child: const ParkingLotList(),
                  )),
            )),
        //駐車場区画詳細情報
        '/parking_lot_detail': ((context) => Consumer<ApplicationState>(
              builder: ((context, appState, _) => AuthGuard(
                    loginState: appState.loginState,
                    guard: const Auth(),
                    child: const ParkingLotDetail(),
                  )),
            )),

        //駐車場配置
        '/arrangement': ((context) => Consumer<ApplicationState>(
              builder: ((context, appState, _) => AuthGuard(
                    loginState: appState.loginState,
                    guard: const Auth(),
                    child: const Arrangement(),
                  )),
            )),
        //契約者
        '/contractor_list': ((context) => Consumer<ApplicationState>(
              builder: ((context, appState, _) => AuthGuard(
                    loginState: appState.loginState,
                    guard: const Auth(),
                    child: const ContractorList(),
                  )),
            )),
        //区画使用、修正、登録、解約
        '/parking_lot_user': ((context) => Consumer<ApplicationState>(
              builder: ((context, appState, _) => AuthGuard(
                    loginState: appState.loginState,
                    guard: const Auth(),
                    child: const ParkingLotUser(),
                  )),
            )),
        //区画の場所表示
        '/lot_location': ((context) => Consumer<ApplicationState>(
              builder: ((context, appState, _) => AuthGuard(
                    loginState: appState.loginState,
                    guard: const Auth(),
                    child: const LotLocation(),
                  )),
            )),
        //契約者
        '/contractor_detail': ((context) => Consumer<ApplicationState>(
              builder: ((context, appState, _) => AuthGuard(
                    loginState: appState.loginState,
                    guard: const Auth(),
                    child: const ContractorDetail(),
                  )),
            )),

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
