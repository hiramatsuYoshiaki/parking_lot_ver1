import 'package:flutter/material.dart';

class Contractor extends StatefulWidget {
  const Contractor({Key? key}) : super(key: key);

  @override
  _ContractorState createState() => _ContractorState();
}

class _ContractorState extends State<Contractor> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Contractor'));
  }
}
