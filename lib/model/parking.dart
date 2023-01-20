import 'package:cloud_firestore/cloud_firestore.dart';

class Parking {
  final String id;
  final bool used;
  final String contractorId;
  final String contractor;
  final String carNo;
  final String carName;
  final String lotNo;
  Parking({
    required this.id,
    required this.used,
    required this.contractor,
    required this.contractorId,
    required this.carNo,
    required this.carName,
    required this.lotNo,
  });
  //カスタム　オブジェクト
  factory Parking.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Parking(
        id: data?['id'],
        used: data?['used'],
        contractorId: data?['contractorId'],
        contractor: data?['contractor'],
        carNo: data?['carNo'],
        carName: data?['carName'],
        lotNo: data?['lotNo']);
  }
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'used': used,
      'contractorId': contractorId,
      'contractor': contractor,
      'carNo': carNo,
      'carName': carName,
      'lotNo': lotNo,
    };
  }
}
