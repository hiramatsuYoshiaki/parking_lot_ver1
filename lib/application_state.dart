import 'package:flutter/foundation.dart';

import 'model/status.dart';
import 'model/parking.dart';

class ApplicationState extends ChangeNotifier {
  LoadState? _lodingState = LoadState.loading;
  LoadState? get lodingState => _lodingState;

  late List<Parking> _parking = <Parking>[
    Parking(id: '1', used: false, contractor: '', carNo: '', carName: ''),
    Parking(id: '2', used: false, contractor: '', carNo: '', carName: ''),
    Parking(id: '3', used: false, contractor: '', carNo: '', carName: ''),
    Parking(id: '4', used: false, contractor: '', carNo: '', carName: ''),
  ];
  // final List<Parking> _parking = <Parking>[
  //   Parking(
  //       id: '1',
  //       used: true,
  //       contractor: 'レムコ　エメネプール',
  //       carNo: '岡山333あ1234',
  //       carName: 'BMW320d'),
  //   Parking(
  //       id: '2',
  //       used: true,
  //       contractor: 'タデイ　ポガチャル',
  //       carNo: '岡山555あ5678',
  //       carName: 'ホンダシビックタイプR'),
  //   Parking(
  //       id: '3',
  //       used: true,
  //       contractor: 'ヨナス　ビンゲゴー',
  //       carNo: '岡山555あ1000',
  //       carName: 'レクサスLC500'),
  //   Parking(id: '4', used: false, contractor: '', carNo: '', carName: ''),
  // ];
  List<Parking> get parking => _parking;

  ApplicationState() {
    print('ApplicationState start $_lodingState');
    init();
    print('ApplicationState end  $_lodingState');
  }

  Future<void> init() async {
    print('init');
    // setlodingState(LoadState.loading);
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
    //駐車場情報
    getParking();
    //契約者情報
    // getContractor();

    //-------
    // print('setlodingState start : $_lodingState');
    // Future.delayed(Duration(seconds: 2), () {
    //   setlodingState(LoadState.waiting);
    //   print('setlodingState start : $_lodingState');
    //   notifyListeners();
    // });
    // notifyListeners();
  }

  void setlodingState(LoadState status) {
    _lodingState = status;
  }

  Future<void> getParking() async {
    debugPrint('getParking()----start');
    //ローディング画面表示
    setlodingState(LoadState.loading);

    Future.delayed(const Duration(seconds: 3), () {
      print('setlodingState start : $_lodingState');
      _parking.clear();
      _parking = <Parking>[
        Parking(
            id: '1',
            used: true,
            contractor: 'レムコ　エメネプール',
            carNo: '岡山333あ1234',
            carName: 'BMW320d'),
        Parking(
            id: '2',
            used: true,
            contractor: 'タデイ　ポガチャル',
            carNo: '岡山555あ5678',
            carName: 'ホンダシビックタイプR'),
        Parking(
            id: '3',
            used: true,
            contractor: 'ヨナス　ビンゲゴー',
            carNo: '岡山555あ1000',
            carName: 'レクサスLC500'),
        Parking(id: '4', used: false, contractor: '', carNo: '', carName: ''),
      ];
      debugPrint('getActivities _activities: $_parking');
      notifyListeners();
      setlodingState(LoadState.waiting);
      debugPrint('getParking()----end');
    });
  }
}
