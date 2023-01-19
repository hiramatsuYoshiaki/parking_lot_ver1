import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../application_state.dart';
import '../component/loading_screen.dart';
import '../model/status.dart';

class UserDisplay extends StatelessWidget {
  const UserDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Parking Lot User')),
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
                                    children: [
                                    Text('id ${appState.selectedParking.id}'),
                                    Text(
                                        '契約者 ${appState.selectedParking.contractor}'),
                                    Text(
                                        '車番 ${appState.selectedParking.carNo}'),
                                    Text(
                                        '車種 ${appState.selectedParking.carName}'),
                                    // Text('契約日 ${appState.selectedParking.id}'),
                                    // Text('解約日 ${appState.selectedParking.id}'),
                                    // Text('料金 ${appState.selectedParking.id}'),
                                    // Text('契約種別 ${appState.selectedParking.id}'),
                                    TextButton(
                                      child: const Text('修正'),
                                      onPressed: () {
                                        // appState.setSelectedParking(
                                        //     appState.parking[index]);
                                        appState.setParkingLotUserState(
                                            ParkingLotUserState.modification);
                                        Navigator.of(context)
                                            .pushNamed('/parking_lot_user');
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('解約'),
                                      onPressed: () {
                                        // appState.setSelectedParking(
                                        //     appState.parking[index]);
                                        appState.setParkingLotUserState(
                                            ParkingLotUserState.cancel);
                                        Navigator.of(context)
                                            .pushNamed('/parking_lot_user');
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
