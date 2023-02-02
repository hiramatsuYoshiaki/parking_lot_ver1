import 'package:cloud_firestore/cloud_firestore.dart';

class Parking {
  final String id;
  final bool used;
  final String contractorId;
  final String contractor;
  final String carNo;
  final String carName;
  final String carOwner;
  final int lotNo;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  Parking({
    required this.id,
    required this.used,
    required this.contractor,
    required this.contractorId,
    required this.carNo,
    required this.carName,
    required this.carOwner,
    required this.lotNo,
    required this.createdAt,
    required this.updatedAt,
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
      carOwner: data?['carOwner'],
      lotNo: data?['lotNo'],
      createdAt: data?['createdAt'],
      updatedAt: data?['updatedAt'],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'used': used,
      'contractorId': contractorId,
      'contractor': contractor,
      'carNo': carNo,
      'carName': carName,
      'carOwner': carOwner,
      'lotNo': lotNo,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
