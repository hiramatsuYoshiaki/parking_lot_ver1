import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'firebase_options.dart';
import 'model/status.dart';
import 'model/parking.dart';

class ApplicationState extends ChangeNotifier {
  LoadState? _lodingState = LoadState.loading;
  LoadState? get lodingState => _lodingState;

  // late List<Parking> _parking = <Parking>[
  //   Parking(id: '1', used: false, contractor: '', carNo: '', carName: ''),
  //   Parking(id: '2', used: false, contractor: '', carNo: '', carName: ''),
  //   Parking(id: '3', used: false, contractor: '', carNo: '', carName: ''),
  //   Parking(id: '4', used: false, contractor: '', carNo: '', carName: ''),
  // ];
  late List<Parking> _parking = <Parking>[];
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
    print('init start-------');
    // setlodingState(LoadState.loading);
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
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

    debugPrint('setlodingState start : $_lodingState');
    // _parking.clear();
    // _parking = <Parking>[
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
    // notifyListeners();
    // setlodingState(LoadState.waiting);

    //コレクションのすべてのドキュメントを取得する
    //firestore get ----------------------------------
    // FirebaseFirestore.instance.collection('parking').get().then((value) {
    //   for (var doc in value.docs) {
    //     debugPrint("firestore get activities ${doc.id} => ${doc.data()}");
    //     Parking _parkingDoc = Parking(
    //       id: doc.data()['id'] as String,
    //       used: doc.data()['used'] as bool,
    //       contractor: doc.data()['contractor'] as String,
    //       carNo: doc.data()['carNo'] as String,
    //       carName: doc.data()['carName'] as String,
    //     );
    //     _parking.add(_parkingDoc);
    //   }
    //   notifyListeners();
    //   setlodingState(LoadState.waiting);
    // }).catchError((error) => debugPrint("Failed to get parking: $error"));
    //カスタムオオブジェクト
    final ref = FirebaseFirestore.instance
        .collection('parking')
        .orderBy('id', descending: true)
        .withConverter<Parking>(
          fromFirestore: Parking.fromFirestore,
          toFirestore: (Parking parking, _) => parking.toFirestore(),
        );
    await ref
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                debugPrint('dic:${doc['contractor']}');
                Parking parkingDoc = Parking(
                  id: doc['id'] as String,
                  used: doc['used'] as bool,
                  contractor: doc['contractor'] as String,
                  carNo: doc['carNo'] as String,
                  carName: doc['carName'] as String,
                );
                _parking.add(parkingDoc);
              })
            })
        .catchError((error) => debugPrint("Failed to parking: $error"));
    notifyListeners();
    setlodingState(LoadState.waiting);
    // debugPrint('getParking _parking: $_parking');

    debugPrint('getParking()----end');
  }
}
