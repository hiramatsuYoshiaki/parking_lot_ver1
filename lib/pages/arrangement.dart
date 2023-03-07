import 'package:flutter/material.dart';
import 'package:parking_lot_ver1/model/contractor.dart';
import 'package:parking_lot_ver1/model/parking.dart';
import 'package:provider/provider.dart';

import '../application_state.dart';
import '../model/status.dart';
import '../ui/app_bar_bottom.dart';

class Arrangement extends StatefulWidget {
  const Arrangement({Key? key}) : super(key: key);

  @override
  _ArrangementState createState() => _ArrangementState();
}

class _ArrangementState extends State<Arrangement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Parkign Lot List')),
        bottomNavigationBar: const AppBarBottom(),
        body: Consumer<ApplicationState>(
            builder: (BuildContext context, appState, _) {
          List<Parking> arrengmentParking = <Parking>[];
          List<Parking> oddList = <Parking>[]; //奇数
          List<Parking> evenList = <Parking>[]; //偶数

          appState.parking.asMap().forEach(
            (index, element) {
              if (index < 19) {
                evenList.add(element);
              } else {
                oddList.add(element);
              }
            },
          );
          evenList.asMap().forEach(
            (index, element) {
              arrengmentParking.add(element);
              arrengmentParking.add(oddList[index]);
            },
          );

          return lotLayout(
            parking: arrengmentParking,
            setSelectedParking: appState.setSelectedParking,
            setParkingLotUserState: appState.setParkingLotUserState,
            contracts: appState.contracts,
            setSelectedContract: appState.setSelectedContract,
            setSelectedParkingLot: appState.setSelectedParkingLot,
          );
        }));
  }
}

class lotLayout extends StatefulWidget {
  const lotLayout({
    Key? key,
    required this.parking,
    required this.setSelectedParking,
    required this.setParkingLotUserState,
    required this.contracts,
    required this.setSelectedContract,
    required this.setSelectedParkingLot,
  }) : super(key: key);
  final List<Parking> parking;
  final void Function(Parking parking) setSelectedParking;
  final void Function(ParkingLotUserState status) setParkingLotUserState;
  final List<Contract> contracts;
  final void Function(Contract contract) setSelectedContract;
  final void Function(ParkingLot parkingLot) setSelectedParkingLot;

  @override
  _lotLayoutState createState() => _lotLayoutState();
}

class _lotLayoutState extends State<lotLayout> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 4 / 3, //横幅:高さ = 4:2
        ),
        itemCount: widget.parking.length,
        itemBuilder: (BuildContext context, int index) {
          return SingleChildScrollView(
              child: Center(
                  child: GestureDetector(
            onTap: () {
              if (widget.parking[index].used) {
                widget.setSelectedParking(widget.parking[index]);
                widget.setParkingLotUserState(ParkingLotUserState.display);
                //選択した契約者情報をステートに保持
                Contract selectedContract = widget.contracts.firstWhere(
                    (element) =>
                        element.id == widget.parking[index].contractorId);
                widget.setSelectedContract(selectedContract);
                ParkingLot selectedParlingLot = selectedContract.parkingLot!
                    .firstWhere((element) =>
                        widget.parking[index].lotNo == element.lotNo);
                widget.setSelectedParkingLot(selectedParlingLot);
                Navigator.of(context).pushNamed('/parking_lot_user');
              } else {
                widget.setSelectedParking(widget.parking[index]);
                // print('push button add');
                widget.setParkingLotUserState(ParkingLotUserState.add);
                // widget.getContract();
                Navigator.of(context).pushNamed('/parking_lot_user');
              }
            },
            child: Container(
                margin: const EdgeInsets.fromLTRB(4, 8, 4, 8),
                padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
                color: widget.parking[index].used
                    ? Colors.green[200]
                    : Colors.grey[200],
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(widget.parking[index].lotNo.toString(),
                        style: const TextStyle(
                            color: Colors.black87, fontSize: 24)),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.end,
                      spacing: 8,
                      children: [
                        Text(widget.parking[index].contractor),
                      ],
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.end,
                      spacing: 8,
                      children: [
                        Text(widget.parking[index].carNo),
                      ],
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.end,
                      spacing: 8,
                      children: [
                        Text(widget.parking[index].carName),
                      ],
                    ),
                  ],
                )
                // child: ListTile(
                //   leading: Text(widget.parking[index].lotNo.toString(),
                //       style:
                //           const TextStyle(color: Colors.black87, fontSize: 24)),
                //   title: Text(widget.parking[index].contractor),
                //   subtitle: Wrap(
                //     crossAxisAlignment: WrapCrossAlignment.end,
                //     spacing: 8,
                //     children: [
                //       Text(widget.parking[index].carNo),
                //       Text(widget.parking[index].carName),
                //     ],

                //   ),
                //   // trailing: const Icon(Icons.more_vert),
                // )
                ),
          )));
        });
  }
}

class FontSize {}
