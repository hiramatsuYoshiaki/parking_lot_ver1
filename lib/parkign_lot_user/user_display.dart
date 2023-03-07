import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../application_state.dart';
import '../component/loading_screen.dart';
import '../model/status.dart';
import '../ui/app_bar_bottom.dart';

class UserDisplay extends StatelessWidget {
  const UserDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('User Dispaly')),
        bottomNavigationBar: Consumer<ApplicationState>(
          builder: (BuildContext context, appState, _) => AppBarBottom(
              // homeState: appState.homeState,
              // setHomeState: appState.setHomeState,
              // activityState: appState.activityState,
              // setActivityState: appState.setActivityState,
              ),
        ),
        body: SingleChildScrollView(
            child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Container(
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.topLeft,
                    child: Consumer<ApplicationState>(
                      builder: (BuildContext context, appState, _) {
                        return appState.loadingState == LoadState.waiting
                            ? Container(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                    const SizedBox(height: 16),
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "区画番号： ${appState.selectedParking.lotNo}",
                                          style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    const SizedBox(height: 16),
                                    // Text('id ${appState.selectedParking.id}'),
                                    Text(
                                        appState.selectedParking.used
                                            ? '契約中'
                                            : '解約',
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 16),
                                    const Text('契約者'),
                                    Text(
                                      appState.selectedParking.contractor,
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 16),
                                    const Text('車番'),
                                    Text(
                                      appState.selectedParking.carNo,
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 16),
                                    const Text('車種'),
                                    Text(
                                      appState.selectedParking.carName,
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 16),
                                    const Text('所有者'),
                                    Text(
                                      appState.selectedParking.carOwner,
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 16),
                                    //契約者情報--------------------------------
                                    const Text('契約者名'),
                                    Text(
                                      appState.selectedContract.name,
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 16),
                                    const Text('住所住所'),
                                    Text(
                                      appState.selectedContract.address,
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 16),
                                    const Text('電話番号'),
                                    Text(
                                      appState.selectedContract.tel,
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 16),
                                    const Text('契約日'),
                                    Text(
                                        DateFormat('yyyy年M月d日').format(appState
                                            .selectedParkingLot.contractDate),
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold)),

                                    const SizedBox(height: 16),
                                    const Text('解約日'),
                                    Text(
                                        appState.selectedParkingLot
                                                    .cancelDate ==
                                                null
                                            ? '契約中'
                                            : DateFormat('yyyy年M月d日').format(
                                                appState.selectedParkingLot
                                                    .cancelDate!),
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 16),
//修正---------
                                    TextButton(
                                      child: const Text('修正'),
                                      onPressed: () {
                                        appState.setSelectedParking(
                                            appState.selectedParking);
                                        appState.setParkingLotUserState(
                                            ParkingLotUserState.modification);
                                        Navigator.of(context)
                                            .pushNamed('/parking_lot_user');
                                      },
                                    ),
                                    //解約------------
                                    TextButton(
                                      child: const Text('解約'),
                                      onPressed: () {
                                        appState.setSelectedParking(
                                            appState.selectedParking);
                                        appState.setParkingLotUserState(
                                            ParkingLotUserState.cancel);
                                        Navigator.of(context)
                                            .pushNamed('/parking_lot_user');
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('もどる'),
                                      onPressed: () {
                                        // appState.setSelectedParking(
                                        //     appState.parking[index]);
                                        // appState.setParkingLotUserState(
                                        //     ParkingLotUserState.display);
                                        Navigator.of(context).pop();
                                        // Navigator.of(context)
                                        //     .pushNamed('/parking_lot_list');
                                      },
                                    ),
                                  ]))
                            : const LoadingScreen(
                                title: 'Now Loding ... Parkign Lot User');
                      },
                    ))))
        // Consumer<ApplicationState>(
        //   builder: (BuildContext context, appState, _) {
        //     return appState.loadingState == LoadState.waiting
        //         ? Text('display')
        //         : const LoadingScreen(title: 'Now Loding ... Parkign Lot User');
        //   },
        // )
        );
  }
  // return Consumer<ApplicationState>(
  //     builder: (BuildContext context, appState, _) {
  //   return Container(
  //       child: Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text('id ${appState.selectedParking.id}'),
  //       Text('契約者 ${appState.selectedParking.contractor}'),
  //       Text('車番 ${appState.selectedParking.carNo}'),
  //       Text('車種 ${appState.selectedParking.carName}'),
  //       // Text('契約日 ${appState.selectedParking.id}'),
  //       // Text('解約日 ${appState.selectedParking.id}'),
  //       // Text('料金 ${appState.selectedParking.id}'),
  //       // Text('契約種別 ${appState.selectedParking.id}'),
  //       TextButton(
  //         child: const Text('修正'),
  //         onPressed: () {
  //           // appState.setSelectedParking(
  //           //     appState.parking[index]);
  //           appState.setParkingLotUserState(ParkingLotUserState.modification);
  //           Navigator.of(context).pushNamed('/parking_lot_user');
  //         },
  //       ),
  //       TextButton(
  //         child: const Text('解約'),
  //         onPressed: () {
  //           // appState.setSelectedParking(
  //           //     appState.parking[index]);
  //           appState.setParkingLotUserState(ParkingLotUserState.cancel);
  //           Navigator.of(context).pushNamed('/parking_lot_user');
  //         },
  //       ),
  //     ],
  //   ));
  // });
}
