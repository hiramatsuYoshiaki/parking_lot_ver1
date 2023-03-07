import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../application_state.dart';
import '../model/contractor.dart';
import '../model/status.dart';
import '../ui/app_bar_bottom.dart';

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
    return Scaffold(
      appBar: AppBar(title: const Text('Parkign Lot List')),
      bottomNavigationBar: Consumer<ApplicationState>(
        builder: (BuildContext context, appState, _) => AppBarBottom(
            // homeState: appState.homeState,
            // setHomeState: appState.setHomeState,
            // activityState: appState.activityState,
            // setActivityState: appState.setActivityState,
            ),
      ),
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
                          ? Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 8,
                              children: <Widget>[
                                  Text(appState.parking[index].lotNo.toString(),
                                      style: const TextStyle(fontSize: 24)),
                                  // const SizedBox(width: 10),
                                  Text(appState.parking[index].contractor),
                                  // const SizedBox(width: 10),
                                  Text(appState.parking[index].carNo),
                                  // const SizedBox(width: 10),
                                  Text(appState.parking[index].carName),
                                  // const SizedBox(width: 10),
                                  TextButton(
                                    child: const Text('詳細'),
                                    onPressed: () {
                                      //選択した駐車場区画情報をステートに保持
                                      appState.setSelectedParking(
                                          appState.parking[index]);
                                      //選択した契約者情報をステートに保持
                                      appState.setParkingLotUserState(
                                          ParkingLotUserState.display);
                                      //選択した契約者情報をステートに保持
                                      Contract selectedContract = appState
                                          .contracts
                                          .firstWhere((element) =>
                                              element.id ==
                                              appState
                                                  .parking[index].contractorId);
                                      appState.setSelectedContract(
                                          selectedContract);
                                      ParkingLot selectedParlingLot =
                                          selectedContract.parkingLot!
                                              .firstWhere((element) =>
                                                  appState
                                                      .parking[index].lotNo ==
                                                  element.lotNo);
                                      appState.setSelectedParkingLot(
                                          selectedParlingLot);
                                      Navigator.of(context)
                                          .pushNamed('/parking_lot_user');
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
                                  //add
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
