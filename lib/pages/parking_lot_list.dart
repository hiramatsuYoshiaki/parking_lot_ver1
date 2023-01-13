import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../application_state.dart';
import '../model/status.dart';

class ParkingLotList extends StatefulWidget {
  const ParkingLotList({Key? key}) : super(key: key);

  @override
  _ParkingLotListState createState() => _ParkingLotListState();
}

class _ParkingLotListState extends State<ParkingLotList> {
  // List<Map<String, dynamic>> listItems = [
  //   {
  //     'id': '１',
  //     'used': true,
  //     'contractor': 'レムコ　エメネプール',
  //     'car_no': '岡山333あ1234',
  //     'car_name': '',
  //   },
  //   {
  //     'id': '２',
  //     'used': false,
  //     'contractor': '',
  //     'car_no': '',
  //     'car_name': '',
  //   },
  //   {
  //     'id': '３',
  //     'used': true,
  //     'contractor': 'タデイ　ポガチャル',
  //     'car_no': '倉敷555い5678',
  //     'car_name': 'ホンダCRV',
  //   },
  // ];
  @override
  Widget build(BuildContext context) {
    print('parking_lot_list');
    return Scaffold(
      appBar: AppBar(title: const Text('Parkign Lot List')),
      body: Consumer<ApplicationState>(
          builder: (BuildContext context, appState, _) {
        return appState.lodingState == LoadState.waiting
            ? ListView.builder(
                itemCount: appState.parking.length,
                itemBuilder: (context, index) {
                  return Container(
                      padding: const EdgeInsets.all(8),
                      height: 50,
                      alignment: Alignment.centerLeft,
                      color: appState.parking[index].used
                          ? Colors.green[200]
                          : Colors.grey[200],
                      child: Wrap(children: <Widget>[
                        Text(appState.parking[index].id),
                        const SizedBox(width: 10),
                        Text(appState.parking[index].contractor),
                        const SizedBox(width: 10),
                        Text(appState.parking[index].carNo),
                        const SizedBox(width: 10),
                        Text(appState.parking[index].carName),
                        const SizedBox(width: 10),
                      ])
                      // child: Text(listItems[index]['text']),
                      );
                },
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text('Now Loding ... Parling Lot List'),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                    CircularProgressIndicator(),
                  ],
                ),
              );
      }),
    );
  }
}
