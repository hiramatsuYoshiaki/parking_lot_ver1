import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../application_state.dart';
import '../component/loading_screen.dart';
import '../model/status.dart';
import '../ui/app_bar_bottom.dart';

class ParkingLotDetail extends StatelessWidget {
  const ParkingLotDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Lot Detail')),
        bottomNavigationBar: const AppBarBottom(),
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
                                        // color: widget.parking[index].used
                                        //       ? Colors.teal[100]
                                        //       : Colors.grey[200],
                                        padding: const EdgeInsets.all(8),
                                        color: Colors.teal[200],
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          appState.selectedParking.lotNo
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600),
                                        )),
                                    const SizedBox(height: 16),
                                    const Text(
                                      '契約者',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black38),
                                    ),
                                    Text(
                                      appState.selectedParking.contractor,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      '車番',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black38),
                                    ),
                                    Text(
                                      appState.selectedParking.carNo,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      '車種',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black38),
                                    ),
                                    Text(
                                      appState.selectedParking.carName,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      '所有者',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black38),
                                    ),
                                    Text(
                                      appState.selectedParking.carOwner,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    //契約者情報--------------------------------
                                    const Text(
                                      '契約者名',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black38),
                                    ),
                                    Text(
                                      appState.selectedContract.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      '住所',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black38),
                                    ),
                                    Text(
                                      appState.selectedContract.address,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      '電話番号',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black38),
                                    ),
                                    Text(
                                      appState.selectedContract.tel,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      '契約日',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black38),
                                    ),
                                    Text(
                                        DateFormat('yyyy年M月d日').format(appState
                                            .selectedParkingLot.contractDate),
                                        style: const TextStyle(
                                          fontSize: 16,
                                        )),

                                    const SizedBox(height: 16),
                                    const Text(
                                      '解約日',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black38),
                                    ),
                                    Text(
                                        appState.selectedParkingLot
                                                    .cancelDate ==
                                                null
                                            ? '契約中'
                                            : DateFormat('yyyy年M月d日').format(
                                                appState.selectedParkingLot
                                                    .cancelDate!),
                                        style: const TextStyle(
                                          fontSize: 16,
                                        )),
                                    const SizedBox(height: 16),
                                    Container(
                                      width: double.infinity,
                                      child: Wrap(
                                        alignment: WrapAlignment.start,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        spacing: 16,
                                        children: [
                                          ElevatedButton(
                                              onPressed: () {
                                                appState.setSelectedParking(
                                                    appState.selectedParking);
                                                appState.setParkingLotUserState(
                                                    ParkingLotUserState
                                                        .modification);
                                                Navigator.of(context).pushNamed(
                                                    '/parking_lot_user');
                                              },
                                              child: const Text('修正')),
                                          ElevatedButton(
                                              onPressed: () {
                                                appState.setSelectedParking(
                                                    appState.selectedParking);
                                                appState.setParkingLotUserState(
                                                    ParkingLotUserState.cancel);
                                                Navigator.of(context).pushNamed(
                                                    '/parking_lot_user');
                                              },
                                              child: const Text('解約')),
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('もどる')),
                                        ],
                                      ),
                                    ),

                                    //修正---------
                                    // TextButton(
                                    //   child: const Text('修正'),
                                    //   onPressed: () {
                                    //     appState.setSelectedParking(
                                    //         appState.selectedParking);
                                    //     appState.setParkingLotUserState(
                                    //         ParkingLotUserState.modification);
                                    //     Navigator.of(context)
                                    //         .pushNamed('/parking_lot_user');
                                    //   },
                                    // ),
                                    //解約------------
                                    // TextButton(
                                    //   child: const Text('解約'),
                                    //   onPressed: () {
                                    //     appState.setSelectedParking(
                                    //         appState.selectedParking);
                                    //     appState.setParkingLotUserState(
                                    //         ParkingLotUserState.cancel);
                                    //     Navigator.of(context)
                                    //         .pushNamed('/parking_lot_user');
                                    //   },
                                    // ),
                                    // TextButton(
                                    //   child: const Text('もどる'),
                                    //   onPressed: () {
                                    //     Navigator.of(context).pop();
                                    //     // Navigator.of(context)
                                    //     //     .pushNamed('/parking_lot_list');
                                    //   },
                                    // ),
                                  ]))
                            : const LoadingScreen(
                                title: 'Now Loding ... Parkign Lot Detail');
                      },
                    )))));
  }
}
