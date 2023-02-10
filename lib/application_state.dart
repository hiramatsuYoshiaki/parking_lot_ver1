// ignore_for_file: invalid_return_type_for_catch_error

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'firebase_options.dart';
import 'model/contractor.dart';
import 'model/status.dart';
import 'model/parking.dart';

class ApplicationState extends ChangeNotifier {
  //Authentication user
  User? _currentUser;
  User? get getCurrentUser => _currentUser;

  //loginstate
  LoginState _loginState = LoginState.loggedOut;
  LoginState get loginState => _loginState;
  void setLoginState(LoginState status) {
    _loginState = status;
    notifyListeners();
  }

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
  //駐車場区画情報
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
  void clearParking() {
    parking.clear();
    notifyListeners();
  }

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

  //契約者情報
  late final List<Contract> _contracts = <Contract>[];
  List<Contract> get contracts => _contracts;

  Contract _selectedContract = Contract(
      id: '',
      name: '',
      address: '',
      tel: '',
      parkingLot: <ParkingLot>[],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now());
  Contract get selectedContract => _selectedContract;
  void setSelectedContract(Contract contract) {
    _selectedContract = contract;
    notifyListeners();
  }

  ApplicationState() {
    print('ApplicationState start $_loadingState');
    init();
    print('ApplicationState end  $_loadingState');
  }

  Future<void> init() async {
    print('init start-------');
    setloadingState(LoadState.loading);
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseAuth.instance.userChanges().listen((user) async {
      print('ApplicationState init userChanges------ start ');

      if (user != null) {
        print('userChanges logged in');
        _currentUser = user;
        getParking();
        // setloadingState(LoadState.waiting);
        notifyListeners();
        print('userChanges logged in');
        print(user.uid);
        print(user.email);
        print(user.displayName);
        print(user.emailVerified);
        print('photoURL: ${user.photoURL}');
      } else {
        _loginState = LoginState.loggedOut;
        _currentUser = null;
        print('user logged out ');
        // print(user);
        clearParking();
        setloadingState(LoadState.waiting);
        notifyListeners();
      }
    });
    //--
    //--初期設定　駐車場区画番号36までを空ですべて作る。
    //--firestore のコレクションparkingを削除してから実行する。
    // initialSetParking();
    //--
    //駐車場情報
    // getParking();
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

  //契約者情報をすべて取得
  Future<void> getContract() async {
    debugPrint('getContract()----start!!!');
    //ローディング画面表示
    setloadingState(LoadState.loading);
    _contracts.clear();

    final ref = FirebaseFirestore.instance
        .collection('contractor')
        .withConverter<Contract>(
          fromFirestore: Contract.fromFirestore,
          toFirestore: (Contract contract, _) => contract.toFirestore(),
        );
    debugPrint('getContract()----ref.get');
    await ref
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                debugPrint('id ${doc['id']} ');
                debugPrint('name ${doc['name']} ');
                //parkingLot
                debugPrint(doc['parkingLot'][0]?['lotNo'].toString());
                debugPrint(doc['parkingLot'][0]?['id'].toString());
                debugPrint(doc['parkingLot'][0]?['carOwner'].toString());
                // debugPrint(doc['parkingLot'].longth.toString());
                // List<Map<String, dynamic>> lots =
                //     List<Map<String, dynamic>>.from(doc['parkingLot']);

                // List<ParkingLot> parkingLotList = List<ParkingLot>.from(lots);

                doc['parkingLot'].forEach((value) {
                  debugPrint('parkingLot list forEach ');
                  debugPrint('lotNo ${value['lotNo']} ');
                  debugPrint('id ${value['id']} ');
                  debugPrint('carOwner ${value['carOwner']} ');
                  //
                  Contract contract = Contract(
                    id: doc['id'],
                    name: doc['name'],
                    address: doc['address'],
                    tel: doc['tel'],
                    // parkingLot: [],
                    // parkingLot: List<ParkingLot>.from(doc['parkingLot']),
                    parkingLot: List<ParkingLot>.from(doc['parkingLot']
                        .map(
                          (value) => ParkingLot(
                            id: value['id'],
                            used: value['used'],
                            carNo: value['carNo'],
                            carName: value['carName'],
                            carOwner: value['carOwner'],
                            lotNo: value['lotNo'],
                            // contractDate: value?['contractDate'] == null
                            //     ? value['contractDate'].toDate()
                            //     : value?['createdAt'].toDate(),
                            // cancelDate: value?['cancelDate'] == null
                            //     ? value['cancelDate'].toDate()
                            //     : value?['createdAt'].toDate(),
                            // contractDate: DateTime.now(),
                            contractDate: value['contractDate'].toDate(),
                            // cancelDate: DateTime.now(),
                            cancelDate: value['cancelDate'].toDate(),
                            contractType: value['contractType'],
                            // createdAt: value?['createdAt'].toDate(),
                            // updatedAt: value?['updatedAt'].toDate(),
                            // createdAt: DateTime.now(),
                            createdAt: value['createdAt'].toDate(),
                            // updatedAt: DateTime.now(),
                            updatedAt: value?['updatedAt'].toDate(),
                          ),
                        )
                        .toList()),
                    createdAt: doc['createdAt'].toDate(),
                    updatedAt: doc['updatedAt'].toDate(),
                  );
                  _contracts.add(contract);
                });
                // doc['parkingLot'].map((value) {
                //   debugPrint('parkingLot list map ');
                //   debugPrint('lotNo ${value['lotNo']} ');
                //   debugPrint('id ${value['id']} ');
                //   debugPrint('carOwner ${value['carOwner']} ');
                // }).toList();
              })
            })
        .catchError((error) => debugPrint("Failed to parking: $error"));
    setloadingState(LoadState.waiting);
    debugPrint('getContract end <<<<');
    notifyListeners();
  }

  // Future<void> getContract() async {
  //   debugPrint('getContract  start >>>>>!!!!');
  //   setloadingState(LoadState.loading);
  //   _contracts.clear();

  //   try {
  //     final ref = FirebaseFirestore.instance
  //         .collection('contractor')
  //         // .orderBy('name')
  //         .withConverter<Contract>(
  //           fromFirestore: Contract.fromFirestore,
  //           toFirestore: (Contract contract, _) => contract.toFirestore(),
  //         );
  //     debugPrint('get Contract  -------');
  //     final docSnap = await ref.get();
  //     final List<Contract> city =
  //         List<Contract>.from(docSnap.docs as List<Contract>);
  //     debugPrint('docSnap.docs.map-----');

  //     docSnap.docs.map((doc) {
  //       // `withConverter()`でContract型にデコードする関数を定義しているため
  //       // Contractクラスが得られる
  //       debugPrint('docSnap.docs.map *******');
  //       debugPrint(doc.id);
  //       Contract contract = Contract(
  //         id: doc['id'],
  //         name: doc['name'],
  //         address: doc['address'],
  //         tel: doc['tel'],
  //         // parkingLot: [ParkingLot.from(doc['parkingLot'])],
  //         // parkingLot: doc['parkingLot'] as List<ParkingLot>,
  //         parkingLot: List<ParkingLot>.from(doc['parkingLot']
  //                 .map(
  //                   (value) => ParkingLot(
  //                     id: value['id'],
  //                     used: value['used'],
  //                     carNo: value['carNo'],
  //                     carName: value['carName'],
  //                     carOwner: value['carOwner'],
  //                     lotNo: value['lotNo'],
  //                     // contractDate: value?['contractDate'] == null
  //                     //     ? value['contractDate'].toDate()
  //                     //     : value?['createdAt'].toDate(),
  //                     // cancelDate: value?['cancelDate'] == null
  //                     //     ? value['cancelDate'].toDate()
  //                     //     : value?['createdAt'].toDate(),
  //                     contractDate: DateTime.now(),
  //                     cancelDate: DateTime.now(),
  //                     contractType: value?['contractType'],
  //                     // createdAt: value?['createdAt'].toDate(),
  //                     // updatedAt: value?['updatedAt'].toDate(),
  //                     createdAt: DateTime.now(),
  //                     updatedAt: DateTime.now(),
  //                   ),
  //                 )
  //                 .toList() ??
  //             []),
  //         createdAt: doc['createdAt'].toDate(),
  //         updatedAt: doc['updateAt'].toDate(),
  //       );
  //       // Contract contract = Contract(
  //       //   id: doc.id,
  //       //   name: doc.name,
  //       //   address: doc.address,
  //       //   tel: doc.tel,
  //       //   // parkingLot: [ParkingLot.from(doc['parkingLot'])],
  //       //   parkingLot: doc.parkingLot,
  //       //   createdAt: doc.createdAt,
  //       //   updatedAt: doc.updatedAt,
  //       // );
  //       _contracts.add(contract);
  //       debugPrint('contract length ${_contracts.length.toString()}');
  //       _contracts.map((value) =>
  //           debugPrint('contract: ${value.parkingLot![0].carOwner}'));
  //     });

  //     setloadingState(LoadState.waiting);
  //     debugPrint('getContract end <<<<');
  //     notifyListeners();
  //   } on FirebaseException catch (e) {
  //     // Caught an exception from Firebase.
  //     debugPrint("Failed with error '${e.code}': ${e.message}");
  //   }
  //   debugPrint('getContract  end <<<<<<');
  // }

  // Future<void> getContract() async {
  //   debugPrint('getContract  start >>>>>');
  //   setloadingState(LoadState.loading);

  //   _contracts.clear();
  //   final ref = FirebaseFirestore.instance
  //       .collection('contractor')
  //       // .orderBy('name')
  //       .withConverter<Contract>(
  //         fromFirestore: Contract.fromFirestore,
  //         toFirestore: (Contract contract, _) => contract.toFirestore(),
  //       );
  //   await ref.get().then((((QuerySnapshot querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //       // Map<String,dynamic>? data = doc.data();
  //       // customObjects: List<CustomObject>.from(doc.data["custom_objects"].map((item) {
  //       //   return new CustomObject(
  //       //     title: item["title"] ?? '',
  //       //       );
  //       //     },
  //       //   ),
  //       // ) ?? [],
  //       debugPrint('querySnapshot.docs.forEach');
  //       debugPrint('id ${doc['id']} ');
  //       debugPrint('Name ${doc['name']} ');
  //       Contract contract = Contract(
  //         id: doc['id'],
  //         name: doc['name'],
  //         address: doc['address'],
  //         tel: doc['tel'],
  //         // parkingLot: doc['parkingLot'],
  //         parkingLot: List<ParkingLot>.from(doc['parkingLot']),
  //         // parkingLot: List<ParkingLot>.from(doc['parkingLot']
  //         //         .map(
  //         //           (value) => ParkingLot(
  //         //             id: value['id'],
  //         //             used: value['used'],
  //         //             carNo: value['carNo'],
  //         //             carName: value['carName'],
  //         //             carOwner: value['carOwner'],
  //         //             lotNo: value['lotNo'],
  //         //             // contractDate: value?['contractDate'] == null
  //         //             //     ? value['contractDate'].toDate()
  //         //             //     : value?['createdAt'].toDate(),
  //         //             // cancelDate: value?['cancelDate'] == null
  //         //             //     ? value['cancelDate'].toDate()
  //         //             //     : value?['createdAt'].toDate(),
  //         //             contractDate: DateTime.now(),
  //         //             cancelDate: DateTime.now(),
  //         //             contractType: value?['contractType'],
  //         //             // createdAt: value?['createdAt'].toDate(),
  //         //             // updatedAt: value?['updatedAt'].toDate(),
  //         //             createdAt: DateTime.now(),
  //         //             updatedAt: DateTime.now(),
  //         //           ),
  //         //         )
  //         //         .toList() ??
  //         //     []),
  //         // parkingLot: [
  //         //   ParkingLot(
  //         //       id: doc['parkingLot'][0]['id'],
  //         //       used: doc['parkingLot'][0]['used'],
  //         //       carNo: doc['parkingLot'][0]['carNo'],
  //         //       carName: doc['parkingLot'][0]['carName'],
  //         //       carOwner: doc['parkingLot'][0]['carOwner'],
  //         //       lotNo: doc['parkingLot'][0]['lotNo'],
  //         //       contractDate: doc['parkingLot'][0]['contractDate'].toDate(),
  //         //       cancelDate: doc['parkingLot'][0]['cancelDate'].toDate(),
  //         //       contractType: doc['parkingLot'][0]['contractType'],
  //         //       createdAt: doc['parkingLot'][0]['createdAt'].toDate(),
  //         //       updatedAt: doc['parkingLot'][0]['updatedAt'].toDate())
  //         // ],
  //         createdAt: doc['createdAt'].toDate(),
  //         updatedAt: doc['updateAt'].toDate(),
  //       );
  //       _contracts.add(contract);
  //       debugPrint('contract length ${_contracts.length.toString()}');
  //       _contracts.map((value) =>
  //           debugPrint('contract: ${value.parkingLot![0].carOwner}'));
  //       debugPrint('contract---->');
  //     });
  //   }))).catchError((error) => debugPrint("Failed to get contract: $error"));
  //   // await ref
  //   //     .get()
  //   //     .then(
  //   //         ((QuerySnapshot querySnapshot) => querySnapshot.docs.forEach((doc) {
  //   //               debugPrint('querySnapshot.docs.forEach');
  //   //               debugPrint('id ${doc['id']} ');
  //   //               debugPrint('Name ${doc['name']} ');
  //   //               debugPrint('carOwner ${doc['parkingLot'][0]['carOwner']} ');
  //   //               doc['parkingLot'].map((value) {
  //   //                 debugPrint('carOwner ${value} ');
  //   //                 // debugPrint('carOwner ${value['carOwner']} ');
  //   //               });
  //   //             })))
  //   //     .catchError((error) => debugPrint("Failed to get contract: $error"));
  //   // await ref
  //   //     .get()
  //   //     .then((QuerySnapshot querySnapshot) => {
  //   //           querySnapshot.docs.forEach((doc) {
  //   //             debugPrint('id ${doc['id']} ');
  //   //             debugPrint('Name ${doc['name']} ');
  //   //             debugPrint('address ${doc['address']} ');
  //   //             debugPrint('tel ${doc['tel']} ');
  //   //             debugPrint('createdAT ${doc['createdAT']} ');
  //   //             debugPrint('updateAT ${doc['updatedAT']} ');
  //   // List<dynamic> userList =
  //   //     doc['parkingLot'].map((value) {
  //   //   return ParkingLot(
  //   //     id: value?['id'],
  //   //     used: value?['used'],
  //   //     carNo: value?['carNo'],
  //   //     carName: value?['carName'],
  //   //     carOwner: value?['carOwner'],
  //   //     lotNo: value?['lotNo'],
  //   //     // contractDate: value?['contractDate'] == null
  //   //     //     ? value['contractDate'].toDate()
  //   //     //     : value?['createdAt'].toDate(),
  //   //     // cancelDate: value?['cancelDate'] == null
  //   //     //     ? value['cancelDate'].toDate()
  //   //     //     : value?['createdAt'].toDate(),
  //   //     contractDate: DateTime.now(),
  //   //     cancelDate: DateTime.now(),
  //   //     contractType: value?['contractType'],
  //   //     // createdAt: value?['createdAt'].toDate(),
  //   //     // updatedAt: value?['updatedAt'].toDate(),
  //   //     createdAt: DateTime.now(),
  //   //     updatedAt: DateTime.now(),
  //   //   );
  //   // }).toList();

  //   // Contract contract = Contract(
  //   //   id: doc['id'],
  //   //   name: doc['name'],
  //   //   address: doc['address'],
  //   //   tel: doc['tel'],
  //   //   parkingLot: List<ParkingLot>.from(doc['parkingLot']
  //   //       .map(
  //   //         (value) =>
  //   //             ParkingLot(
  //   //           id: value?['id'],
  //   //           used: value?['used'],
  //   //           carNo: value?['carNo'],
  //   //           carName: value?['carName'],
  //   //           carOwner: value?['carOwner'],
  //   //           lotNo: value?['lotNo'],
  //   //           // contractDate: value?['contractDate'] == null
  //   //           //     ? value['contractDate'].toDate()
  //   //           //     : value?['createdAt'].toDate(),
  //   //           // cancelDate: value?['cancelDate'] == null
  //   //           //     ? value['cancelDate'].toDate()
  //   //           //     : value?['createdAt'].toDate(),
  //   //           contractDate: DateTime.now(),
  //   //           cancelDate: DateTime.now(),
  //   //           contractType: value?['contractType'],
  //   //           // createdAt: value?['createdAt'].toDate(),
  //   //           // updatedAt: value?['updatedAt'].toDate(),
  //   //           createdAt: DateTime.now(),
  //   //           updatedAt: DateTime.now(),
  //   //         ),
  //   //       )
  //   //       .toList()),
  //   //   // parkingLot: ParkingLot(
  //   //   //     id: doc['parkingLot.id'],
  //   //   //     used: doc['parkingLot.id'],
  //   //   //     carNo: doc['parkingLot.id'],
  //   //   //     carName: doc['parkingLot.id'],
  //   //   //     carOwner: doc['parkingLot.id'],
  //   //   //     lotNo: doc['parkingLot.id'],
  //   //   //     contractDate: doc['parkingLot.id'],
  //   //   //     cancelDate: doc['parkingLot.id'],
  //   //   //     contractType: doc['parkingLot.id'],
  //   //   //     createdAt: doc['parkingLot.id'],
  //   //   //     updatedAt: doc['parkingLot.id']),

  //   //   createdAt: doc['createdAt'].toDate(),
  //   //   updatedAt: doc['updateAt'].toDate(),
  //   // );
  //   // _contracts.add(contract);
  //   //       })
  //   //     })
  //   // .catchError((error) => debugPrint("Failed to get contract: $error"));

  //   setloadingState(LoadState.waiting);
  //   debugPrint('getContract end <<<<');
  //   notifyListeners();
  // }

  // 駐車場区画情報をすべて取得
  Future<void> getParking() async {
    debugPrint('getParking()----start!!!');
    //ローディング画面表示
    setloadingState(LoadState.loading);

    // debugPrint('setloadingState start : $_loadingState');
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
                // debugPrint(
                //     'lotNo ${doc['lotNo']} contractor:${doc['contractor']}');
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
        .catchError((error) {
      debugPrint("Failed to parking: $error");
      setloadingState(LoadState.waiting);
    });
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

  ///----
  ///aut
  ///----
  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
    void Function(FirebaseAuthException e) errorCallback, //_showErrorDialogs
  ) async {
    debugPrint('sign In-------');
    try {
      print('signInWithEmailAndPassword');
      print('email:$email');
      print('password:$password');
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      _loginState = LoginState.loggedIn;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
      print('firebase auhentication error!');
      print('createUserWithEmailPassword Error:$e');
    }
  }

  void signOut() {
    debugPrint('sign out-------');
    FirebaseAuth.instance.signOut();
    _loginState = LoginState.loggedOut;
    notifyListeners();
  }
}
