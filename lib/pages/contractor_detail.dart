import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../application_state.dart';
import '../component/loading_screen.dart';
import '../model/status.dart';
import '../ui/app_bar_bottom.dart';
import 'package:intl/intl.dart';

class ContractorDetail extends StatefulWidget {
  const ContractorDetail({Key? key}) : super(key: key);

  @override
  _ContractorDetailState createState() => _ContractorDetailState();
}

class _ContractorDetailState extends State<ContractorDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Contractor')),
        bottomNavigationBar: const AppBarBottom(),
        body: SingleChildScrollView(
            child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.topLeft,
                    child: Consumer<ApplicationState>(
                        builder: (BuildContext context, appState, _) {
                      return appState.loadingState == LoadState.waiting
                          ? Container(
                              child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const SizedBox(height: 8),
                                Container(
                                    padding: const EdgeInsets.all(8),
                                    color: Colors.teal[200],
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      appState.selectedContract.name,
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                const SizedBox(height: 8),
                                const Text(
                                  '住所',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black38),
                                ),
                                Wrap(
                                  children: [
                                    Text(
                                      appState.selectedContract.address,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'TEL',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black38),
                                ),
                                Text(
                                  appState.selectedContract.tel,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Divider(
                                  thickness: 2,
                                  height: 6,
                                  color: Colors.black26,
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  '区画',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black38),
                                ),
                                Text(
                                  appState.selectedParkingLot.lotNo.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  '車番',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black38),
                                ),
                                Text(
                                  appState.selectedParkingLot.carNo,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  '車種',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black38),
                                ),
                                Text(
                                  appState.selectedParkingLot.carName,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  '所有者',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black38),
                                ),
                                Text(
                                  appState.selectedParkingLot.carOwner,
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
                                    appState.selectedParkingLot.cancelDate ==
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
                                            // appState.setSelectedParking(
                                            //     appState.selectedParking);
                                            // appState.setParkingLotUserState(
                                            //     ParkingLotUserState
                                            //         .modification);
                                            // Navigator.of(context)
                                            //     .pushNamed('/parking_lot_user');
                                          },
                                          child: const Text('修正')),
                                      ElevatedButton(
                                          onPressed: () {
                                            // appState.setSelectedParking(
                                            //     appState.selectedParking);
                                            // appState.setParkingLotUserState(
                                            //     ParkingLotUserState.cancel);
                                            // Navigator.of(context)
                                            //     .pushNamed('/parking_lot_user');
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
                              ],
                            ))
                          : const LoadingScreen(
                              title: 'Now Loding ...  Contractor Detail');
                    })))));
  }
}
