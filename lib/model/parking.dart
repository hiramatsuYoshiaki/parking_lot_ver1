import 'package:cloud_firestore/cloud_firestore.dart';

class Parking {
  final String id;
  final bool used;
  final String contractor;
  final String carNo;
  final String carName;
  Parking({
    required this.id,
    required this.used,
    required this.contractor,
    required this.carNo,
    required this.carName,
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
        contractor: data?['contractor'],
        carNo: data?['carNo'],
        carName: data?['carName']);
  }
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'used': used,
      'contractor': contractor,
      'carNo': carNo,
      'carName': carName,
    };
  }
}
