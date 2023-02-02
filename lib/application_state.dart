// ignore_for_file: invalid_return_type_for_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'firebase_options.dart';
import 'model/contractor.dart';
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
  late final List<Parking> _parking = <Parking>[];
  List<Parking> get parking => _parking;

  Parking _selectdParking = Parking(
    id: '',
    used: false,
    contractor: '',
    contractorId: '',
    carNo: '',
    carName: '',
    lotNo: 0,
    carOwner: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
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
    //--
    //--初期設定　駐車場区画番号36までを空ですべて作る。
    //--firestore のコレクションparkingを削除してから実行する。
    // initialSetParking();
    //--
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
                debugPrint(
                    'lotNo ${doc['lotNo']} contractor:${doc['contractor']}');
                Parking parkingDoc = Parking(
                  id: doc['id'] as String,
                  used: doc['used'] as bool,
                  contractorId: doc['contractorId'] as String,
                  contractor: doc['contractor'] as String,
                  carNo: doc['carNo'] as String,
                  carName: doc['carName'] as String,
                  carOwner: doc['carOwner'] as String,
                  lotNo: doc['lotNo'] as int,
                  createdAt: doc['createdAt'].toDate(),
                  updatedAt: doc['updatedAt'].toDate(),
                );
                _parking.add(parkingDoc);
              })
            })
        .catchError((error) => debugPrint("Failed to parking: $error"));
    notifyListeners();
    setloadingState(LoadState.waiting);
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
        "carNo": parking.carNo,
        "carName": parking.carName,
        "carOwner": parking.carOwner,
        "updatedAt": DateTime.now(),
      });
      debugPrint('lot no : ${parking.lotNo} --->  parking update ok!!!!!!!!');
      getParking();
      notifyListeners();
      setloadingState(LoadState.waiting);
    } on FirebaseException catch (e) {
      debugPrint('firebase Firestore parking update Error: $e');
    }
  }

  Future<void> addParking(Parking parking, Contract contract) async {
    debugPrint('addParking()----start');
    setloadingState(LoadState.loading);
    Contract docContractor = Contract(
      id: contract.id,
      name: contract.name,
      address: contract.address,
      tel: contract.tel,
      parkingLot: contract.parkingLot,
      createdAt: contract.createdAt,
      updatedAt: contract.updatedAt,
    );
    try {
      // contractor add----
      await FirebaseFirestore.instance
          .collection("contractor")
          .withConverter(
            fromFirestore: Contract.fromFirestore,
            toFirestore: (Contract docContractor, options) =>
                docContractor.toFirestore(),
          )
          .add(docContractor)
          .then((documentSnapshot) => {
                debugPrint("Added Data with ID: ${documentSnapshot.id}"),
                FirebaseFirestore.instance
                    .collection("contractor")
                    .doc(documentSnapshot.id)
                    .update({
                  "id": documentSnapshot.id,
                })
              });
      //parking update------
      await FirebaseFirestore.instance.collection("parking").doc(parking.id)
          // .withConverter(
          //   fromFirestore: Activities.fromFirestore,
          //   toFirestore: (Activities docData, options) => docData.toFirestore(),
          // )
          // .update({"plan.done": true,"actual.rideURL":RideLinkURL});
          .update({
        "used": parking.used,
        "contractor": parking.contractor,
        "carNo": parking.carNo,
        "carName": parking.carName,
        "carOwner": parking.carOwner,
        "updatedAt": DateTime.now(),
      });
      debugPrint('lot no : ${parking.lotNo} ---> parking update ok!');
      getParking();
      notifyListeners();
      setloadingState(LoadState.waiting);
    } on FirebaseException catch (e) {
      debugPrint('firebase Firestore parking update Error: $e');
    }
  }

  Future<void> cancelParking(Parking parking) async {
    debugPrint('cancelParking()----start');
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
        // "id": parking.id,
        "used": parking.used,
        "contractor": parking.contractor,
        "contractorId": parking.contractorId,
        "carNo": parking.carNo,
        "carName": parking.carName,
        // "lotNo": parking.lotNo,
        "updatedAt": DateTime.now(),
      });
      debugPrint('lot no : ${parking.lotNo} --->  parking cancel ok!!!!!!!!');
      getParking();
      notifyListeners();
      setloadingState(LoadState.waiting);
    } on FirebaseException catch (e) {
      debugPrint('firebase Firestore parking cancel Error: $e');
    }
  }

//初期設定　駐車場区画番号36までを空ですべて作る。
//firestore のコレクションparkingを削除してから実行する。
  Future<void> initialSetParking() async {
    debugPrint('initialSetParking()----start');
    List<int> lotIds = [
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
      19,
      20,
      21,
      22,
      23,
      24,
      25,
      26,
      27,
      28,
      29,
      30,
      31,
      32,
      33,
      34,
      35,
      36,
      37,
      38
    ];

    try {
      for (var lotid in lotIds) {
        Parking docData = Parking(
          id: "",
          used: false,
          contractor: "",
          contractorId: "",
          carNo: "",
          carName: "",
          carOwner: "",
          lotNo: lotid,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        FirebaseFirestore.instance
            .collection("parking")
            .withConverter(
              fromFirestore: Parking.fromFirestore,
              toFirestore: (Parking docData, options) => docData.toFirestore(),
            )
            .add(docData)
            .then((documentSnapshot) => {
                  debugPrint("Added Data with ID: ${documentSnapshot.id}"),
                  FirebaseFirestore.instance
                      .collection("parking")
                      .doc(documentSnapshot.id)
                      .update({
                    "id": documentSnapshot.id,
                  })
                });
        debugPrint('lotid:$lotid initialSetParking add ok!!!!!!!!');
      }

      notifyListeners();
      setloadingState(LoadState.waiting);
    } on FirebaseException catch (e) {
      debugPrint('firebase Firestore initialSetParking add Error: $e');
    }
  }
}
