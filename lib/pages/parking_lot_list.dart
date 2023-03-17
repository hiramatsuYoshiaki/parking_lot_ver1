import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../application_state.dart';
import '../component/loading_screen.dart';
import '../model/contractor.dart';
import '../model/status.dart';
import '../ui/app_bar_bottom.dart';

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
      body: CustomScrollView(
        slivers: <Widget>[
          FilterMenu(screenWidth: screenWidth),
        ],
      ),

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
  const FilterMenu({Key? key, required this.screenWidth}) : super(key: key);
  final double screenWidth;
  @override
  _FilterMenuState createState() => _FilterMenuState();
}

class _FilterMenuState extends State<FilterMenu> {
  bool isAll = true;
  bool isUsed = false;
  bool isUnused = false;
  bool isSerch = false;
  final _formKey = GlobalKey<FormState>(debugLabel: '_EmailPasswordFormState');
  // final _serchController = TextEditingController(text: 'Serch');
  final _serchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
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
                      children: [Icon(Icons.search), Text('Serch')],
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      ),
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
                          });
                        },
                      ),
                    ],
                  ),
                ))));
  }
}

class ParkingLotFilter extends StatefulWidget {
  const ParkingLotFilter({Key? key}) : super(key: key);

  @override
  _ParkingLotFilterState createState() => _ParkingLotFilterState();
}

class _ParkingLotFilterState extends State<ParkingLotFilter> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: Text('Filter')));
  }
}
