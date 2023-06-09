import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../application_state.dart';
import '../component/loading_screen.dart';
import '../model/contractor.dart';
import '../model/parking.dart';
import '../model/status.dart';
import '../ui/app_bar_bottom.dart';

enum PopUpMenue { location, detail, contractor }

class ParkingLotList extends StatefulWidget {
  const ParkingLotList({Key? key}) : super(key: key);

  @override
  _ParkingLotListState createState() => _ParkingLotListState();
}

class _ParkingLotListState extends State<ParkingLotList> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text('Parkign Lot List')),
      bottomNavigationBar: Consumer<ApplicationState>(
        builder: (BuildContext context, appState, _) => const AppBarBottom(),
      ),
      // body: FilterMenu(screenWidth: screenWidth),
      body: Consumer<ApplicationState>(
          builder: (BuildContext context, appState, _) {
        return appState.loadingState == LoadState.waiting
            ? FilterMenu(
                screenWidth: screenWidth,
                parking: appState.parking,
                contracts: appState.contracts,
                setSelectedParking:
                    appState.setSelectedParking, //選択した区画情報をステートに保持
                setSelectedContract:
                    appState.setSelectedContract, //選択した契約者情報をステートに保持
                setSelectedParkingLot:
                    appState.setSelectedParkingLot, //選択した契約者情報の区画情報をステートに保持
                setParkingLotUserState:
                    appState.setParkingLotUserState) //処理ステータス（追加）をステートに保持 )
            : const LoadingScreen(title: 'Now Loding ...  Lot List');
      }),

      // body: Consumer<ApplicationState>(
      //     builder: (BuildContext context, appState, _) {
      //   return appState.loadingState == LoadState.waiting
      // ListView.builder(
      //     itemCount: appState.parking.length,
      //     itemBuilder: (context, index) {
      //       return Container(
      //           padding: const EdgeInsets.all(8),
      //           height: 100,
      //           alignment: Alignment.centerLeft,
      //           color: appState.parking[index].used
      //               ? Colors.green[200]
      //               : Colors.grey[200],
      //           child: appState.parking[index].used
      //               ? Wrap(
      //                   crossAxisAlignment: WrapCrossAlignment.center,
      //                   spacing: 8,
      //                   children: <Widget>[
      //                       Text(appState.parking[index].lotNo.toString(),
      //                           style: const TextStyle(fontSize: 24)),
      //                       // const SizedBox(width: 10),
      //                       Text(appState.parking[index].contractor),
      //                       // const SizedBox(width: 10),
      //                       Text(appState.parking[index].carNo),
      //                       // const SizedBox(width: 10),
      //                       Text(appState.parking[index].carName),
      //                       // const SizedBox(width: 10),
      //                       TextButton(
      //                         child: const Text('詳細'),
      //                         onPressed: () {
      //                           //選択した駐車場区画情報をステートに保持
      //                           appState.setSelectedParking(
      //                               appState.parking[index]);
      //                           //選択した契約者情報をステートに保持
      //                           appState.setParkingLotUserState(
      //                               ParkingLotUserState.display);
      //                           //選択した契約者情報をステートに保持
      //                           Contract selectedContract = appState
      //                               .contracts
      //                               .firstWhere((element) =>
      //                                   element.id ==
      //                                   appState
      //                                       .parking[index].contractorId);
      //                           appState.setSelectedContract(
      //                               selectedContract);
      //                           ParkingLot selectedParlingLot =
      //                               selectedContract.parkingLot!
      //                                   .firstWhere((element) =>
      //                                       appState
      //                                           .parking[index].lotNo ==
      //                                       element.lotNo);
      //                           appState.setSelectedParkingLot(
      //                               selectedParlingLot);
      //                           Navigator.of(context)
      //                               .pushNamed('/parking_lot_user');
      //                         },
      //                       ),
      //                       TextButton(
      //                         child: const Text('修正'),
      //                         onPressed: () {
      //                           appState.setSelectedParking(
      //                               appState.parking[index]);
      //                           appState.setParkingLotUserState(
      //                               ParkingLotUserState.modification);
      //                           Navigator.of(context)
      //                               .pushNamed('/parking_lot_user');
      //                         },
      //                       ),
      //                       TextButton(
      //                         child: const Text('解約'),
      //                         onPressed: () {
      //                           appState.setSelectedParking(
      //                               appState.parking[index]);
      //                           appState.setParkingLotUserState(
      //                               ParkingLotUserState.cancel);
      //                           Navigator.of(context)
      //                               .pushNamed('/parking_lot_user');
      //                         },
      //                       ),
      //                     ])
      //               : Wrap(children: <Widget>[
      //                   Text(appState.parking[index].lotNo.toString()),
      //                   const SizedBox(width: 10),
      //                   Text('空き'),
      //                   const SizedBox(width: 10),
      //                   Text(''),
      //                   const SizedBox(width: 10),
      //                   Text(''),
      //                   const SizedBox(width: 10),
      //                   TextButton(
      //                     child: const Text('登録'),
      //                     onPressed: () {
      //                       print('push button add');
      //                       //ステータス add,modification,cansel,display,replace,list
      //                       //add
      //                       appState.setParkingLotUserState(
      //                           ParkingLotUserState.add);
      //                       //駐車場区画の情報
      //                       appState.setSelectedParking(
      //                           appState.parking[index]);
      //                       appState.getContract();
      //                       Navigator.of(context)
      //                           .pushNamed('/parking_lot_user');
      //                     },
      //                   ),
      //                 ])
      //           // child: Text(listItems[index]['text']),
      //           );
      //     },
      //   )
      // : const LoadingScreen(title: 'Now Loding ...  Lot List');
      // }
      // ),
    );
  }
}

class FilterMenu extends StatefulWidget {
  const FilterMenu({
    Key? key,
    required this.screenWidth,
    required this.parking,
    required this.contracts,
    required this.setSelectedParking,
    required this.setParkingLotUserState,
    required this.setSelectedContract,
    required this.setSelectedParkingLot,
  }) : super(key: key);
  final double screenWidth;
  final List<Parking> parking;
  // setSelectedParking setSelectedContract setSelectedParkingLot setParkingLotUserState
  final List<Contract> contracts;
  final void Function(Parking parking) setSelectedParking;
  final void Function(Contract contract) setSelectedContract;
  final void Function(ParkingLot parkingLot) setSelectedParkingLot;
  final void Function(ParkingLotUserState status) setParkingLotUserState;
  @override
  _FilterMenuState createState() => _FilterMenuState();
}

class _FilterMenuState extends State<FilterMenu> {
  bool isAll = true;
  bool isUsed = false;
  bool isUnused = false;
  String serchName = '';
  List<Parking> filterIsUsedParking = <Parking>[];
  List<Parking> filterParking = <Parking>[];
  final _formKey = GlobalKey<FormState>(debugLabel: '_EmailPasswordFormState');
  // final _serchController = TextEditingController(text: 'Serch');
  final _serchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filterParking = widget.parking;
  }

  Widget build(BuildContext context) {
    return CustomScrollView(slivers: <Widget>[
      SliverToBoxAdapter(
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width >= 600
                      ? (MediaQuery.of(context).size.width - 600) / 2
                      : 8),
              child: Align(
                  alignment: Alignment.center,
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 8,
                    child: ExpansionTile(
                      title: Wrap(
                        alignment: WrapAlignment.start,
                        children: const [Icon(Icons.search), Text('Serch')],
                      ),
                      // subtitle: const Text('Trailing expansion arrow icon'),
                      children: <Widget>[
                        // const ListTile(title: Text('Select ')),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            alignment: Alignment.centerLeft,
                            child: Form(
                                key: _formKey,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: TextFormField(
                                            controller: _serchController,
                                            decoration: const InputDecoration(
                                                // labelText: '検索',
                                                hintText: '検索名を入力してください'),
                                            // validator: (value) {
                                            //   if (value!.isEmpty) {
                                            //     return 'メールアドレスは必須です';
                                            //   }
                                            //   if (!EmailValidator.validate(value)) {
                                            //     return 'メールの形式が正しくありません';
                                            //   }
                                            // },
                                            onChanged: (value) {
                                              if (isAll) {
                                                filterIsUsedParking =
                                                    widget.parking;
                                              }
                                              if (isUsed) {
                                                filterIsUsedParking = widget
                                                    .parking
                                                    .where((value) =>
                                                        value.used == true)
                                                    .toList();
                                                ;
                                              }
                                              if (isUnused) {
                                                filterIsUsedParking = widget
                                                    .parking
                                                    .where((value) =>
                                                        value.used == false)
                                                    .toList();
                                              }

                                              setState(() {
                                                serchName = value;
                                                filterParking =
                                                    filterIsUsedParking
                                                        .where((element) =>
                                                            element
                                                                .contractor
                                                                .contains(
                                                                    value) ==
                                                            true)
                                                        .toList();
                                              });
                                            }),
                                      ),
                                    ]))),
                        const SizedBox(height: 8),
                        CheckboxListTile(
                          // tileColor: Colors.red,
                          title: const Text('All'),
                          value: isAll,
                          onChanged: (bool? value) {
                            setState(() {
                              isAll = value!;
                              isUsed = false;
                              isUnused = false;
                              if (serchName == '') {
                                filterParking = widget.parking;
                              } else {
                                filterParking = widget.parking
                                    .where((element) =>
                                        element.contractor
                                            .contains(serchName) ==
                                        true)
                                    .toList();
                              }
                            });
                          },
                        ),

                        CheckboxListTile(
                          // tileColor: Colors.red,
                          title: const Text('Used'),
                          value: isUsed,
                          onChanged: (bool? value) {
                            setState(() {
                              isAll = false;
                              isUsed = value!;
                              isUnused = false;
                              filterIsUsedParking = widget.parking
                                  .where((value) => value.used == true)
                                  .toList();
                              if (serchName == '') {
                                filterParking = filterIsUsedParking;
                              } else {
                                filterParking = filterIsUsedParking
                                    .where((element) =>
                                        element.contractor
                                            .contains(serchName) ==
                                        true)
                                    .toList();
                              }
                            });
                          },
                        ),
                        CheckboxListTile(
                          // tileColor: Colors.red,
                          title: const Text('UnUsed'),
                          value: isUnused,
                          onChanged: (bool? value) {
                            setState(() {
                              isAll = false;
                              isUsed = false;
                              isUnused = value!;
                              filterIsUsedParking = widget.parking
                                  .where((value) => value.used == false)
                                  .toList();
                              if (serchName == '') {
                                filterParking = filterIsUsedParking;
                              } else {
                                filterParking = filterIsUsedParking
                                    .where((element) =>
                                        element.contractor
                                            .contains(serchName) ==
                                        true)
                                    .toList();
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  )))),
      ParkingLotFilter(
          isAll: isAll,
          isUsed: isUsed,
          isUnused: isUnused,
          // serchName: _serchController.text
          serchName: serchName,
          parking: filterParking,
          contracts: widget.contracts,
          setSelectedParking: widget.setSelectedParking, //選択した区画情報をステートに保持
          setSelectedContract: widget.setSelectedContract, //選択した契約者情報をステートに保持
          setSelectedParkingLot:
              widget.setSelectedParkingLot, //選択した契約者情報の区画情報をステートに保持
          setParkingLotUserState: widget.setParkingLotUserState
          // parking: widget.parking,
          ),
    ]);
  }
}

class ParkingLotFilter extends StatefulWidget {
  const ParkingLotFilter({
    Key? key,
    required this.isAll,
    required this.isUsed,
    required this.isUnused,
    required this.serchName,
    required this.parking,
    required this.contracts,
    required this.setSelectedParking,
    required this.setParkingLotUserState,
    required this.setSelectedContract,
    required this.setSelectedParkingLot,
  }) : super(key: key);
  final bool isAll;
  final bool isUsed;
  final bool isUnused;
  final String serchName;
  final List<Parking> parking;
  final List<Contract> contracts;
  final void Function(Parking parking) setSelectedParking;
  final void Function(Contract contract) setSelectedContract;
  final void Function(ParkingLot parkingLot) setSelectedParkingLot;
  final void Function(ParkingLotUserState status) setParkingLotUserState;
  @override
  _ParkingLotFilterState createState() => _ParkingLotFilterState();
}

class _ParkingLotFilterState extends State<ParkingLotFilter> {
  // enum PopUpMenue { location, detail, contractor }
  PopUpMenue? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return SliverFixedExtentList(
      itemExtent: 100, //高さ
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            alignment: Alignment.centerLeft,
            color:
                widget.parking[index].used ? Colors.green[100] : Colors.black12,
            child: ListTile(
              leading: Text(
                widget.parking[index].lotNo.toString(),
                style: const TextStyle(fontSize: 24),
                overflow: TextOverflow.ellipsis,
              ),
              title: Text(
                widget.parking[index].contractor,
                style: const TextStyle(fontSize: 24),
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                '${widget.parking[index].carNo} ${widget.parking[index].carName}',
                style: const TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
              // trailing: Icon(Icons.more_vert),
              trailing: PopupMenuButton<PopUpMenue>(
                initialValue: selectedMenu,
                // Callback that sets the selected popup menu item.
                onSelected: (PopUpMenue item) {
                  setState(() {
                    selectedMenu = item;
                    if (item == PopUpMenue.location) {
                      Navigator.of(context).pushNamed('/lot_location');
                    }
                    if (item == PopUpMenue.detail) {
                      // widget.parking[index].used
                      //     ? Navigator.of(context).pushNamed('/home')
                      //     : null;
                      if (widget.parking[index].used) {
                        //選択した区画情報をステートに保持
                        widget.setSelectedParking(widget.parking[index]);
                        //選択した契約者情報をステートに保持
                        Contract selectedContract = widget.contracts.firstWhere(
                            (element) =>
                                element.id ==
                                widget.parking[index].contractorId);
                        widget.setSelectedContract(selectedContract);
                        ParkingLot selectedParlingLot =
                            selectedContract.parkingLot!.firstWhere((element) =>
                                widget.parking[index].lotNo == element.lotNo);
                        widget.setSelectedParkingLot(selectedParlingLot);
                        Navigator.of(context).pushNamed('/parking_lot_detail');
                      } else {
                        widget.setSelectedParking(widget.parking[index]);
                        // print('push button add');
                        widget.setParkingLotUserState(ParkingLotUserState.add);
                        // widget.getContract();
                        Navigator.of(context).pushNamed('/parking_lot_user');
                      }
                    }

                    if (item == PopUpMenue.contractor) {
                      // widget.parking[index].used
                      //     ? Navigator.of(context).pushNamed('/contractor')
                      //     : null;
                      if (widget.parking[index].used) {
                        //選択した区画情報をステートに保持
                        widget.setSelectedParking(widget.parking[index]);
                        //選択した契約者情報をステートに保持
                        Contract selectedContract = widget.contracts.firstWhere(
                            (element) =>
                                element.id ==
                                widget.parking[index].contractorId);
                        widget.setSelectedContract(selectedContract);
                        ParkingLot selectedParlingLot =
                            selectedContract.parkingLot!.firstWhere((element) =>
                                widget.parking[index].lotNo == element.lotNo);
                        widget.setSelectedParkingLot(selectedParlingLot);
                        Navigator.of(context).pushNamed('/contractor_detail');
                      }
                    }
                  });
                },
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<PopUpMenue>>[
                  PopupMenuItem<PopUpMenue>(
                    value: PopUpMenue.location,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const <Widget>[
                            Icon(
                              Icons.widgets,
                              size: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('location'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<PopUpMenue>(
                    value: PopUpMenue.detail,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: <Widget>[
                            const Icon(
                              Icons.garage,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            widget.parking[index].used
                                ? const Text('detail')
                                : const Text('add')
                          ],
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<PopUpMenue>(
                    value: PopUpMenue.contractor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const <Widget>[
                            Icon(
                              Icons.person,
                              size: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('contractor')
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              isThreeLine: true,
            ),

            // child: Text(
            //     '${widget.parking[index].lotNo}: ${widget.parking[index].contractor}'));
          );
        },
        childCount: widget.parking.length,
      ),
    );
  }
}
