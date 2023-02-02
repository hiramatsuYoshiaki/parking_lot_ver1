import 'package:cloud_firestore/cloud_firestore.dart';

class Contract {
  final String id;
  final String name;
  final String address;
  final String tel;
  final List<ParkingLot>? parkingLot;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  Contract({
    required this.id,
    required this.name,
    required this.address,
    required this.tel,
    required this.parkingLot,
    required this.createdAt,
    required this.updatedAt,
  });
  //カスタム　オブジェクト
  factory Contract.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Contract(
      id: data?['id'],
      name: data?['name'],
      address: data?['address'],
      tel: data?['tel'],
      // parkingLot: data?['parkingLot'] is Iterable
      //     ? List<ParkingLot>.from(data?['parkingLot'])
      //     : null,
      // parkingLot: data?['parkingLot'].map((value) => value).toList(),
      parkingLot: data?['parkingLot']
          .map((value) => {
                ParkingLot(
                  id: value?['id'],
                  used: value?['used'],
                  carNo: value?['carNo'],
                  carName: value?['carName'],
                  carOwner: value?['carOwner'],
                  lotNo: value?['lotNo'],
                  contractDate: value?['contractDate'],
                  cancelDate: value?['cancelDate'],
                  contractType: value?['contractType'],
                  createdAt: value?['createdAt'],
                  updatedAt: value?['updatedAt'],
                ),
              })
          .toList(),
      // parkingLot: [
      //   ParkingLot(
      //     id: data?['parkingLot'][0]?['id'],
      //     used: data?['parkingLot'][0]?['used'],
      //     carNo: data?['parkingLot'][0]?['carNo'],
      //     carName: data?['parkingLot'][0]?['carName'],
      //     carOwner: data?['parkingLot'][0]?['carOwner'],
      //     lotNo: data?['parkingLot'][0]?['lotNo'],
      //     contractDate: data?['parkingLot'][0]?['contractDate'],
      //     cancelDate: data?['parkingLot'][0]?['cancelDate'],
      //     contractType: data?['parkingLot'][0]?['contractType'],
      //     createdAt: data?['parkingLot'][0]?['createdAt'],
      //     updatedAt: data?['parkingLot'][0]?['updatedAt'],
      //   ),
      //   ParkingLot(
      //     id: data?['parkingLot'][1]?['id'],
      //     used: data?['parkingLot'][1]?['used'],
      //     carNo: data?['parkingLot'][1]?['carNo'],
      //     carName: data?['parkingLot'][1]?['carName'],
      //     carOwner: data?['parkingLot'][1]?['carOwner'],
      //     lotNo: data?['parkingLot'][1]?['lotNo'],
      //     contractDate: data?['parkingLot'][1]?['contractDate'],
      //     cancelDate: data?['parkingLot'][1]?['cancelDate'],
      //     contractType: data?['parkingLot'][1]?['contractType'],
      //     createdAt: data?['parkingLot'][1]?['createdAt'],
      //     updatedAt: data?['parkingLot'][1]?['updatedAt'],
      //   ),
      // ],

      createdAt: data?['createdAt'],
      updatedAt: data?['updatedAt'],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'tel': tel,
      if (parkingLot != null)
        'parkingLot': parkingLot!
            .map((lot) => {
                  'id': lot.id,
                  'used': lot.used,
                  'carNo': lot.carNo,
                  'carName': lot.carName,
                  'carOwner': lot.carOwner,
                  'lotNo': lot.lotNo,
                  'contractDate': lot.contractDate,
                  'cancelDate': lot.cancelDate,
                  'contractType': lot.contractType,
                  'createdAt': lot.createdAt,
                  'updatedAt': lot.updatedAt,
                })
            .toList(),
      // 'parkingLot': [
      //   {
      //     'id': parkingLot?[0].id,
      //     'used': parkingLot?[0].used,
      //     'carNo': parkingLot?[0].carNo,
      //     'carName': parkingLot?[0].carName,
      //     'carOwner': parkingLot?[0].carOwner,
      //     'lotNo': parkingLot?[0].lotNo,
      //     'contractDate': parkingLot?[0].contractDate,
      //     'cancelDate': parkingLot?[0].cancelDate,
      //     'contractType': parkingLot?[0].contractType,
      //     'createdAt': parkingLot?[0].createdAt,
      //     'updatedAt': parkingLot?[0].updatedAt,
      //   },
      //   {
      //     'id': parkingLot?[1].id,
      //     'used': parkingLot?[1].used,
      //     'carNo': parkingLot?[1].carNo,
      //     'carName': parkingLot?[1].carName,
      //     'carOwner': parkingLot?[1].carOwner,
      //     'lotNo': parkingLot?[1].lotNo,
      //     'contractDate': parkingLot?[1].contractDate,
      //     'cancelDate': parkingLot?[1].cancelDate,
      //     'contractType': parkingLot?[1].contractType,
      //     'createdAt': parkingLot?[1].createdAt,
      //     'updatedAt': parkingLot?[1].updatedAt,
      //   },
      // ],
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class ParkingLot {
  final String id;
  final bool used;
  final String carNo;
  final String carName;
  final String carOwner;
  final int lotNo;
  final DateTime contractDate;
  final DateTime? cancelDate;
  final String contractType;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  ParkingLot({
    required this.id,
    required this.used,
    required this.carNo,
    required this.carName,
    required this.carOwner,
    required this.lotNo,
    required this.contractDate,
    required this.cancelDate,
    required this.contractType,
    required this.createdAt,
    required this.updatedAt,
  });
}
