import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:parking_lot_ver1/pages/parking_lot_user.dart';
import 'package:parking_lot_ver1/parkign_lot_user/user_display.dart';

import 'firebase_options.dart';
import 'model/status.dart';
import 'model/parking.dart';

class ApplicationState extends ChangeNotifier {
  // loading state
  LoadState? _loadingState = LoadState.loading;
  LoadState? get loadingState => _loadingState;
  // parkign lot user state

  ParkingLotUserState _parkingLotUserState = ParkingLotUserState.display;
  ParkingLotUserState get parkingLotUserState => _parkingLotUserState;
  void setParkingLotUserState(ParkingLotUserState status) {
    _parkingLotUserState = status;
    notifyListeners();
  }

  // late List<Parking> _parking = <Parking>[
  //   Parking(id: '1', used: false, contractor: '', carNo: '', carName: ''),
  //   Parking(id: '2', used: false, contractor: '', carNo: '', carName: ''),
  //   Parking(id: '3', used: false, contractor: '', carNo: '', carName: ''),
  //   Parking(id: '4', used: false, contractor: '', carNo: '', carName: ''),
  // ];

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
  late List<Parking> _parking = <Parking>[];
  List<Parking> get parking => _parking;

  Parking _selectdParking = Parking(
      id: '',
      used: false,
      contractor: '',
      contractorId: '',
      carNo: '',
      carName: '',
      lotNo: '');
  Parking get selectedParking => _selectdParking;
  void setSelectedParking(Parking parking) {
    _selectdParking = parking;
    notifyListeners();
  }

  ApplicationState() {
    print('ApplicationState start $_loadingState');
    init();
    print('ApplicationState end  $_loadingState');
  }

  Future<void> init() async {
    print('init start-------');
    // setloadingState(LoadState.loading);
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    //駐車場情報
    getParking();
    //契約者情報
    // getContractor();

    //-------
    // print('setloadingState start : $_loadingState');
    // Future.delayed(Duration(seconds: 2), () {
    //   setloadingState(LoadState.waiting);
    //   print('setloadingState start : $_loadingState');
    //   notifyListeners();
    // });
    // notifyListeners();
  }

  void setloadingState(LoadState status) {
    _loadingState = status;
  }

  Future<void> getParking() async {
    debugPrint('getParking()----start');
    //ローディング画面表示
    setloadingState(LoadState.loading);

    debugPrint('setloadingState start : $_loadingState');
    _parking.clear();
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
    // setloadingState(LoadState.waiting);

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
    //   setlaodingState(LoadState.waiting);
    // }).catchError((error) => debugPrint("Failed to get parking: $error"));
    //カスタムオオブジェクト
    final ref = FirebaseFirestore.instance
        .collection('parking')
        // .orderBy('id', descending: true)
        .orderBy('lotNo')
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
                  contractorId: doc['contractorId'] as String,
                  contractor: doc['contractor'] as String,
                  carNo: doc['carNo'] as String,
                  carName: doc['carName'] as String,
                  lotNo: doc['lotNo'] as String,
                );
                _parking.add(parkingDoc);
              })
            })
        .catchError((error) => debugPrint("Failed to parking: $error"));
    notifyListeners();
    setloadingState(LoadState.waiting);
    // debugPrint('getParking _parking: $_parking');

    debugPrint('getParking()----end');
  }

  Future<void> updateParking(Parking parking) async {
    debugPrint('updateParking()----start');
    //ローディング画面表示
    setloadingState(LoadState.loading);
    try {
      await FirebaseFirestore.instance.collection("parking").doc(parking.id)
          // .withConverter(
          //   fromFirestore: Activities.fromFirestore,
          //   toFirestore: (Activities docData, options) => docData.toFirestore(),
          // )
          // .update({"plan.done": true,"actual.rideURL":RideLinkURL});
          .update({
        "contractor": parking.contractor,
        // "plan.done": activity.plan.done,
        // "plan.date": activity.plan.date,
        // "actual.rideURL": activity.actual.rideURL,
        // "actual.rideURL": 'https://aaa',
        // "actual.ridePhotos": activity.actual.ridePhotos,
        // "updateAt": DateTime.now(),
      });
      debugPrint('parking update ok!!!!!!!!');
      notifyListeners();
      setloadingState(LoadState.waiting);
    } on FirebaseException catch (e) {
      debugPrint('firebase Firestore parking update Error: $e');
    }
  }
}
