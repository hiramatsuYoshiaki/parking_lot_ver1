import 'package:flutter/material.dart';

class Arrangement extends StatefulWidget {
  const Arrangement({Key? key}) : super(key: key);

  @override
  _ArrangementState createState() => _ArrangementState();
}

class _ArrangementState extends State<Arrangement> {
  List<Map<String, dynamic>> listItems = [
    {
      'id': '１',
      'used': true,
      'contractor': 'レムコ　エメネプール',
      'car_no': '岡山333あ1234',
      'car_name': '',
    },
    {
      'id': '２',
      'used': false,
      'contractor': '',
      'car_no': '',
      'car_name': '',
    },
    {
      'id': '３',
      'used': true,
      'contractor': 'タデイ　ポガチャル',
      'car_no': '倉敷555い5678',
      'car_name': 'ホンダCRV',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Parkign Lot List')),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: listItems.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: listItems[index]['used']
                  ? Colors.green[200]
                  : Colors.grey[200],
              child: Wrap(children: <Widget>[
                Text(listItems[index]['id']),
                const SizedBox(width: 10),
                Text(listItems[index]['contractor']),
                const SizedBox(width: 10),
                Text(listItems[index]['car_no']),
                const SizedBox(width: 10),
                Text(listItems[index]['car_name']),
                const SizedBox(width: 10),
              ]),
            );
          }),
    );
  }
}
