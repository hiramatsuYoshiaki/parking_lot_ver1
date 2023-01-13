// import 'package:cloud_firestore/cloud_firestore.dart';
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
}
