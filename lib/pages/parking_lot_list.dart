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
        return appState.loadingState == LoadState.waiting
            ? ListView.builder(
                itemCount: appState.parking.length,
                itemBuilder: (context, index) {
                  return Container(
                      padding: const EdgeInsets.all(8),
                      height: 100,
                      alignment: Alignment.centerLeft,
                      color: appState.parking[index].used
                          ? Colors.green[200]
                          : Colors.grey[200],
                      child: appState.parking[index].used
                          ? Wrap(children: <Widget>[
                              Text(appState.parking[index].lotNo.toString()),
                              const SizedBox(width: 10),
                              Text(appState.parking[index].contractor),
                              const SizedBox(width: 10),
                              Text(appState.parking[index].carNo),
                              const SizedBox(width: 10),
                              Text(appState.parking[index].carName),
                              const SizedBox(width: 10),
                              TextButton(
                                child: const Text('詳細'),
                                onPressed: () {
                                  appState.setSelectedParking(
                                      appState.parking[index]);
                                  appState.setParkingLotUserState(
                                      ParkingLotUserState.display);
                                  Navigator.of(context)
                                      .pushNamed('/parking_lot_user');
                                  // widget.setSelectedActivity(
                                  //     widget.selectedActivity,
                                  //     ActivityState.activityDetail);
                                },
                              ),
                              TextButton(
                                child: const Text('修正'),
                                onPressed: () {
                                  appState.setSelectedParking(
                                      appState.parking[index]);
                                  appState.setParkingLotUserState(
                                      ParkingLotUserState.modification);
                                  Navigator.of(context)
                                      .pushNamed('/parking_lot_user');
                                  // widget.setSelectedActivity(
                                  //     widget.selectedActivity,
                                  //     ActivityState.activityDetail);
                                },
                              ),
                              TextButton(
                                child: const Text('解約'),
                                onPressed: () {
                                  appState.setSelectedParking(
                                      appState.parking[index]);
                                  appState.setParkingLotUserState(
                                      ParkingLotUserState.cancel);
                                  Navigator.of(context)
                                      .pushNamed('/parking_lot_user');
                                },
                              ),
                            ])
                          : Wrap(children: <Widget>[
                              Text(appState.parking[index].lotNo.toString()),
                              const SizedBox(width: 10),
                              Text('空き'),
                              const SizedBox(width: 10),
                              Text(''),
                              const SizedBox(width: 10),
                              Text(''),
                              const SizedBox(width: 10),
                              TextButton(
                                child: const Text('登録'),
                                onPressed: () {
                                  print('push button add');
                                  //ステータス add,modification,cansel,display,replace,list
                                  appState.setParkingLotUserState(
                                      ParkingLotUserState.add);
                                  //駐車場区画の情報
                                  appState.setSelectedParking(
                                      appState.parking[index]);
                                  appState.getContract();
                                  Navigator.of(context)
                                      .pushNamed('/parking_lot_user');
                                },
                              ),
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
