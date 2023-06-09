import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../application_state.dart';
import '../component/loading_screen.dart';
import '../model/room.dart';
import '../model/status.dart';
import '../ui/app_bar_auth.dart';
import '../ui/app_bar_bottom.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String parkingName = '平松駐車場';
    String parkingAdress = '岡山県岡山市南区大福６７７−７';
    String apartmentName = 'コスメティクスオオフク';
    String apartmentAdress = '岡山県岡山市南区大福６２３－２';
    //アパート
    int room = 34;
    int vacancy = 5;
    int movingIn = 29;
    List<Room> roomInUse = <Room>[];
    // final roomList = ['A101', 'B101', 'Peach'];
    // List<Map<String, dynamic>> rooms = [
    //   {
    //     "name": "A101",
    //     "building": "A",
    //     "floor": 1,
    //     "floorPlan": "3DK",
    //     "rent": 48000,
    //     "used": true,
    //     "exist": true,
    //   },
    //   {
    //     "name": "A102",
    //     "building": "A",
    //     "floor": 1,
    //     "floorPlan": "3DK",
    //     "rent": 48000,
    //     "used": true,
    //     "exist": true,
    //   },
    //   {
    //     "name": "A201",
    //     "building": "A",
    //     "floor": 1,
    //     "floorPlan": "3DK",
    //     "rent": 48000,
    //     "used": true,
    //     "exist": true,
    //   },
    //   {
    //     "name": "A202",
    //     "building": "A",
    //     "floor": 1,
    //     "floorPlan": "3DK",
    //     "rent": 48000,
    //     "used": true,
    //     "exist": true,
    //   },
    //   {
    //     "name": "----",
    //     "building": "-",
    //     "floor": 0,
    //     "floorPlan": "---",
    //     "rent": 0,
    //     "used": true,
    //     "exist": false,
    //   },
    //   {
    //     "name": "----",
    //     "building": "-",
    //     "floor": 0,
    //     "floorPlan": "---",
    //     "rent": 0,
    //     "used": true,
    //     "exist": false,
    //   },
    //   {
    //     "name": "B101",
    //     "building": "B",
    //     "floor": 1,
    //     "floorPlan": "3DK",
    //     "rent": 48000,
    //     "used": false,
    //     "exist": true,
    //   },
    //   {
    //     "name": "B102",
    //     "building": "B",
    //     "floor": 1,
    //     "floorPlan": "3DK",
    //     "rent": 48000,
    //     "used": false,
    //     "exist": true,
    //   },
    //   {
    //     "name": "B103",
    //     "building": "B",
    //     "floor": 1,
    //     "floorPlan": "3DK",
    //     "rent": 48000,
    //     "used": true,
    //     "exist": true,
    //   },
    //   {
    //     "name": "B201",
    //     "building": "B",
    //     "floor": 1,
    //     "floorPlan": "3DK",
    //     "rent": 48000,
    //     "used": true,
    //     "exist": true,
    //   },
    //   {
    //     "name": "B202",
    //     "building": "B",
    //     "floor": 1,
    //     "floorPlan": "3DK",
    //     "rent": 48000,
    //     "used": true,
    //     "exist": true,
    //   },
    //   {
    //     "name": "B203",
    //     "building": "B",
    //     "floor": 1,
    //     "floorPlan": "3DK",
    //     "rent": 48000,
    //     "used": true,
    //     "exist": true,
    //   },
    //   {
    //     "name": "C101",
    //     "building": "C",
    //     "floor": 1,
    //     "floorPlan": "3DK",
    //     "rent": 48000,
    //     "used": true,
    //     "exist": true,
    //   },
    //   {
    //     "name": "C102",
    //     "building": "A",
    //     "floor": 1,
    //     "floorPlan": "3DK",
    //     "rent": 48000,
    //     "used": true,
    //     "exist": true,
    //   },
    //   {
    //     "name": "C201",
    //     "building": "A",
    //     "floor": 1,
    //     "floorPlan": "3DK",
    //     "rent": 48000,
    //     "used": true,
    //     "exist": true,
    //   },
    //   {
    //     "name": "C202",
    //     "building": "A",
    //     "floor": 1,
    //     "floorPlan": "3DK",
    //     "rent": 48000,
    //     "used": true,
    //     "exist": true,
    //   },
    //   {
    //     "name": "----",
    //     "building": "-",
    //     "floor": 0,
    //     "floorPlan": "---",
    //     "rent": 0,
    //     "used": true,
    //     "exist": false,
    //   },
    //   {
    //     "name": "----",
    //     "building": "-",
    //     "floor": 0,
    //     "floorPlan": "---",
    //     "rent": 0,
    //     "used": true,
    //     "exist": false,
    //   },
    // ];

    //駐車場
    int parkignLotQuantity = 38;
    int crossCount = 18;
    int mainColumn = 2;
    double ScreenWidth = MediaQuery.of(context).size.width;
    // double sliverPaddingWidth = MediaQuery.of(context).size.width >= 1200
    //     ? (MediaQuery.of(context).size.width - 1200) / 2
    //     : 0;

    return Scaffold(
      appBar: const AppBarAuth(titleText: 'Parking Lot Ver1'),
      bottomNavigationBar: const AppBarBottom(),
      body: Consumer<ApplicationState>(
          builder: (BuildContext context, appState, _) {
        return appState.loadingState == LoadState.waiting
            ? CustomScrollView(
                slivers: <Widget>[
                  // const SliverAppBar(
                  //   pinned: true,
                  //   expandedHeight: 250.0,
                  //   flexibleSpace: FlexibleSpaceBar(
                  //     title: Text('Demo'),
                  //   ),
                  // ),
                  //アパート--------------------------
                  SliverToBoxAdapter(
                      child: Container(
                    padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
                    alignment: Alignment.center,
                    color: Colors.indigoAccent,
                    child: ScreenWidth < 600
                        ? FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              apartmentName,
                              style: const TextStyle(
                                  fontSize: 32, color: Colors.white),
                            ),
                          )
                        : FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              apartmentName,
                              style: const TextStyle(
                                  fontSize: 58, color: Colors.white),
                            ),
                          ),
                  )),
                  SliverToBoxAdapter(
                      child: Container(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                    alignment: Alignment.center,
                    child: ScreenWidth < 600
                        ? FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              apartmentAdress,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black87),
                            ),
                          )
                        : FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              apartmentAdress,
                              style: const TextStyle(
                                  fontSize: 24, color: Colors.black87),
                            ),
                          ),
                  )),
                  SliverToBoxAdapter(
                      child: Container(
                          child: Stack(alignment: Alignment.center, children: [
                    Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          // color: Colors.black54,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black54, width: 4),
                        )),
                    Container(
                      width: 100,
                      height: 100,
                      alignment: Alignment.center,
                      child: Text(room.toString(),
                          style: const TextStyle(
                              fontSize: 34, color: Colors.black54)),
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      padding: const EdgeInsets.only(bottom: 12),
                      alignment: Alignment.bottomCenter,
                      child: const Text('部屋',
                          style:
                              TextStyle(fontSize: 14, color: Colors.black54)),
                    ),
                  ]))),
                  //-------------

                  SliverToBoxAdapter(
                      child: Container(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                    Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.green, width: 4),
                                        )),
                                    Container(
                                      width: 100,
                                      height: 100,
                                      alignment: Alignment.center,
                                      child: Text(movingIn.toString(),
                                          // appState
                                          //     .getNumberOfContract()
                                          //     .toString(),
                                          style: const TextStyle(fontSize: 32)),
                                    ),
                                    Container(
                                      width: 100,
                                      height: 100,
                                      padding: const EdgeInsets.only(top: 8),
                                      alignment: Alignment.topCenter,
                                      child: const Text('契約',
                                          style: TextStyle(fontSize: 14)),
                                    ),
                                    Container(
                                      width: 100,
                                      height: 100,
                                      padding:
                                          const EdgeInsets.only(bottom: 12),
                                      alignment: Alignment.bottomCenter,
                                      child: const Text('部屋',
                                          style: TextStyle(fontSize: 14)),
                                    ),
                                  ])),
                              const SizedBox(width: 18),
                              Container(
                                  child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                    Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.orange, width: 4),
                                        )),
                                    Container(
                                      width: 100,
                                      height: 100,
                                      alignment: Alignment.center,
                                      child: Text(vacancy.toString(),
                                          // (parkignLotQuantity -
                                          //         appState
                                          //             .getNumberOfContract())
                                          //     .toString(),
                                          style: const TextStyle(fontSize: 32)),
                                    ),
                                    Container(
                                      width: 100,
                                      height: 100,
                                      padding: const EdgeInsets.only(top: 8),
                                      alignment: Alignment.topCenter,
                                      child: const Text('空き',
                                          style: TextStyle(fontSize: 14)),
                                    ),
                                    Container(
                                      width: 100,
                                      height: 100,
                                      padding:
                                          const EdgeInsets.only(bottom: 12),
                                      alignment: Alignment.bottomCenter,
                                      child: const Text('部屋',
                                          style: TextStyle(fontSize: 14)),
                                    ),
                                  ])),
                              const SizedBox(width: 18),
                              Stack(alignment: Alignment.center, children: [
                                Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.purple, width: 4),
                                    )),
                                Container(
                                  width: 100,
                                  height: 100,
                                  alignment: Alignment.center,
                                  child: Text(
                                      ((room - vacancy) / room * 100)
                                          .toStringAsFixed(1),
                                      // (appState.getNumberOfContract() /
                                      //         parkignLotQuantity *
                                      //         100)
                                      //     .toStringAsFixed(1),
                                      style: const TextStyle(fontSize: 32)),
                                ),
                                Container(
                                  width: 100,
                                  height: 100,
                                  padding: const EdgeInsets.only(top: 8),
                                  alignment: Alignment.topCenter,
                                  child: const Text('使用',
                                      style: TextStyle(fontSize: 14)),
                                ),
                                Container(
                                  width: 100,
                                  height: 100,
                                  padding: const EdgeInsets.only(bottom: 12),
                                  alignment: Alignment.bottomCenter,
                                  child: const Text('%',
                                      style: TextStyle(fontSize: 14)),
                                ),
                              ])
                            ],
                          ))),
                  SliverToBoxAdapter(
                      child: Container(
                          padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
                          alignment: Alignment.center,
                          child: const Text(
                            '入居状況',
                            style:
                                TextStyle(fontSize: 16, color: Colors.black87),
                          ))),
                  SliverPadding(
                    padding: ScreenWidth < 600
                        ? const EdgeInsets.fromLTRB(16, 4, 16, 32)
                        : ScreenWidth < 1200
                            ? EdgeInsets.fromLTRB(
                                ScreenWidth * 0.12, 4, ScreenWidth * 0.12, 32)
                            : EdgeInsets.fromLTRB(
                                ScreenWidth * 0.3, 4, ScreenWidth * 0.3, 32),
                    sliver: SliverGrid.count(
                      crossAxisCount: 6,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      childAspectRatio: 8 / 4,
                      children:
                          List.generate(appState.roomInUse.length, (index) {
                        // return Center(
                        //     child: Container(
                        //   height: double.infinity,
                        //   width: double.infinity,
                        //   color: appState.roomInUse[index].exist
                        //       ? appState.roomInUse[index].used
                        //           ? Colors.teal
                        //           : Colors.grey
                        //       : Colors.white,
                        //   alignment: Alignment.center,
                        return Center(
                            child: Container(
                          height: double.infinity,
                          width: ScreenWidth,
                          color: appState.roomInUse[index].exist
                              ? appState.roomInUse[index].used
                                  ? Colors.teal
                                  : Colors.grey
                              : Color(0xfffafafa), //default background white
                          alignment: Alignment.center,
                          child: ScreenWidth < 600
                              ? Center(
                                  child: Text(
                                    appState.roomInUse[index].name,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: appState.roomInUse[index].used
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    appState.roomInUse[index].name,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: appState.roomInUse[index].used
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                ),
                          // ? FittedBox(
                          //     fit: BoxFit.fitWidth,
                          //     child: Text(
                          //       appState.roomInUse[index].name,
                          //       style: TextStyle(
                          //           fontSize: 16,
                          //           color: appState
                          //                   .roomInUse[index].used
                          //               ? Colors.white
                          //               : Colors.black),
                          //     ),
                          //   )
                          // : FittedBox(
                          //     fit: BoxFit.fitWidth,
                          //     child: Text(
                          //       appState.roomInUse[index].name,
                          //       style: TextStyle(
                          //           fontSize: 16,
                          //           color: appState
                          //                   .roomInUse[index].used
                          //               ? Colors.white
                          //               : Colors.black),
                          //     ),
                          //   ),
                        ));
                      }),
                    ),
                  ),
                  //-------------
                  //駐車場--------------------------
                  SliverToBoxAdapter(
                      child: Container(
                    padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
                    alignment: Alignment.center,
                    color: Colors.indigoAccent,
                    child: ScreenWidth < 600
                        ? FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              parkingName,
                              style: const TextStyle(
                                  fontSize: 32, color: Colors.white),
                            ),
                          )
                        : FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              parkingName,
                              style: const TextStyle(
                                  fontSize: 58, color: Colors.white),
                            ),
                          ),
                  )),
                  SliverToBoxAdapter(
                      child: Container(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                    alignment: Alignment.center,
                    child: ScreenWidth < 600
                        ? FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              parkingAdress,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black87),
                            ),
                          )
                        : FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              parkingAdress,
                              style: const TextStyle(
                                  fontSize: 24, color: Colors.black87),
                            ),
                          ),
                  )),
                  SliverToBoxAdapter(
                      child: Container(
                          child: Stack(alignment: Alignment.center, children: [
                    Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          // color: Colors.black54,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black54, width: 4),
                        )),
                    Container(
                      width: 100,
                      height: 100,
                      alignment: Alignment.center,
                      child: Text(parkignLotQuantity.toString(),
                          style: const TextStyle(
                              fontSize: 32, color: Colors.black54)),
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      padding: const EdgeInsets.only(bottom: 12),
                      alignment: Alignment.bottomCenter,
                      child: const Text('区画',
                          style:
                              TextStyle(fontSize: 14, color: Colors.black54)),
                    ),
                  ]))),

                  SliverToBoxAdapter(
                      child: Container(
                          padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
                          alignment: Alignment.center,
                          child: const Text(
                            '駐車場レイアウト',
                            style:
                                TextStyle(fontSize: 16, color: Colors.black87),
                          ))),
                  SliverPadding(
                    // padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
                    padding: ScreenWidth < 600
                        ? const EdgeInsets.fromLTRB(16, 4, 16, 32)
                        : ScreenWidth < 1200
                            ? EdgeInsets.fromLTRB(
                                ScreenWidth * 0.12, 4, ScreenWidth * 0.12, 32)
                            : EdgeInsets.fromLTRB(
                                ScreenWidth * 0.3, 4, ScreenWidth * 0.3, 32),
                    sliver: SliverGrid.count(
                      crossAxisCount: 19,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      childAspectRatio: 8 / 19,
                      children: List.generate(appState.parking.length, (index) {
                        return Center(
                            child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          color: appState.parking[index].used
                              ? Colors.teal
                              : Colors.grey,
                          alignment: Alignment.center,
                          child: ScreenWidth < 600
                              ? Center(
                                  child: Text(
                                    "${index + 1}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    "${index + 1}",
                                    style: const TextStyle(
                                        fontSize: 28, color: Colors.white),
                                  ),
                                ),
                          // ? FittedBox(
                          //     fit: BoxFit.fitWidth,
                          //     child: Text(
                          //       "${index + 1}",
                          //       style: const TextStyle(fontSize: 16),
                          //     ),
                          //   )
                          // : FittedBox(
                          //     fit: BoxFit.fitWidth,
                          //     child: Text(
                          //       "${index + 1}",
                          //       style: const TextStyle(
                          //           fontSize: 28, color: Colors.white),
                          //     ),
                          //   ),
                        ));
                      }),
                    ),
                  ),
                  SliverToBoxAdapter(
                      child: Container(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                    Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.green, width: 4),
                                        )),
                                    Container(
                                      width: 100,
                                      height: 100,
                                      alignment: Alignment.center,
                                      child: Text(
                                          appState
                                              .getNumberOfContract()
                                              .toString(),
                                          style: const TextStyle(fontSize: 32)),
                                    ),
                                    Container(
                                      width: 100,
                                      height: 100,
                                      padding: const EdgeInsets.only(top: 8),
                                      alignment: Alignment.topCenter,
                                      child: const Text('契約',
                                          style: TextStyle(fontSize: 14)),
                                    ),
                                    Container(
                                      width: 100,
                                      height: 100,
                                      padding:
                                          const EdgeInsets.only(bottom: 12),
                                      alignment: Alignment.bottomCenter,
                                      child: const Text('区画',
                                          style: TextStyle(fontSize: 14)),
                                    ),
                                  ])),
                              SizedBox(width: 18),
                              Container(
                                  child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                    Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.orange, width: 4),
                                        )),
                                    Container(
                                      width: 100,
                                      height: 100,
                                      alignment: Alignment.center,
                                      child: Text(
                                          (parkignLotQuantity -
                                                  appState
                                                      .getNumberOfContract())
                                              .toString(),
                                          style: const TextStyle(fontSize: 32)),
                                    ),
                                    Container(
                                      width: 100,
                                      height: 100,
                                      padding: const EdgeInsets.only(top: 8),
                                      alignment: Alignment.topCenter,
                                      child: const Text('空き',
                                          style: TextStyle(fontSize: 14)),
                                    ),
                                    Container(
                                      width: 100,
                                      height: 100,
                                      padding:
                                          const EdgeInsets.only(bottom: 12),
                                      alignment: Alignment.bottomCenter,
                                      child: const Text('区画',
                                          style: TextStyle(fontSize: 14)),
                                    ),
                                  ])),
                              const SizedBox(width: 18),
                              Stack(alignment: Alignment.center, children: [
                                Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.purple, width: 4),
                                    )),
                                Container(
                                  width: 100,
                                  height: 100,
                                  alignment: Alignment.center,
                                  child: Text(
                                      (appState.getNumberOfContract() /
                                              parkignLotQuantity *
                                              100)
                                          .toStringAsFixed(1),
                                      style: const TextStyle(fontSize: 32)),
                                ),
                                Container(
                                  width: 100,
                                  height: 100,
                                  padding: const EdgeInsets.only(top: 8),
                                  alignment: Alignment.topCenter,
                                  child: const Text('使用',
                                      style: TextStyle(fontSize: 14)),
                                ),
                                Container(
                                  width: 100,
                                  height: 100,
                                  padding: const EdgeInsets.only(bottom: 12),
                                  alignment: Alignment.bottomCenter,
                                  child: const Text('%',
                                      style: TextStyle(fontSize: 14)),
                                ),
                              ])
                            ],
                          ))),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width >= 600
                            ? (MediaQuery.of(context).size.width - 600) / 2
                            : 8),
                    sliver: SliverToBoxAdapter(
                      child: Card(
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 8,
                        child: ListTile(
                          leading: const Icon(
                            Icons.grid_view,
                          ),
                          title: const Text('レイアウト詳細を表示'),
                          // trailing: Icon(Icons.arrow_forward),
                          trailing: IconButton(
                            tooltip: 'レイアウト詳細を表示',
                            icon: const Icon(Icons.arrow_forward),
                            onPressed: () {
                              Navigator.of(context).pushNamed('/arrangement');
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width >= 600
                            ? (MediaQuery.of(context).size.width - 600) / 2
                            : 8),
                    sliver: SliverToBoxAdapter(
                      child: Card(
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 8,
                        child: ListTile(
                          leading: const Icon(
                            Icons.list,
                          ),
                          title: const Text('区画情報を表示'),
                          // trailing: Icon(Icons.arrow_forward),
                          trailing: IconButton(
                            tooltip: 'レイアウト詳細を表示',
                            icon: const Icon(Icons.arrow_forward),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed('/parking_lot_list');
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width >= 600
                            ? (MediaQuery.of(context).size.width - 600) / 2
                            : 8),
                    sliver: SliverToBoxAdapter(
                      child: Card(
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 8,
                        child: ListTile(
                          leading: const Icon(
                            // Icons.settings,
                            Icons.person,
                          ),
                          title: const Text('契約者情報を表示'),
                          // trailing: Icon(Icons.arrow_forward),
                          trailing: IconButton(
                            tooltip: 'レイアウト詳細を表示',
                            icon: const Icon(Icons.arrow_forward),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed('/contractor_list');
                            },
                          ),
                        ),
                      ),
                    ),
                  ),

                  // SliverToBoxAdapter(
                  //     child: Padding(
                  //         padding: EdgeInsets.symmetric(
                  //             horizontal: MediaQuery.of(context).size.width >=
                  //                     600
                  //                 ? (MediaQuery.of(context).size.width - 600) /
                  //                     2
                  //                 : 8),
                  //         child: Align(
                  //           alignment: Alignment.center,
                  //           child: Card(
                  //             margin: const EdgeInsets.symmetric(vertical: 16),
                  //             elevation: 8,
                  //             child: ListTile(
                  //               leading: const Icon(
                  //                 // Icons.settings,
                  //                 Icons.person,
                  //               ),
                  //               title: const Text('契約者情報を表示'),
                  //               // trailing: Icon(Icons.arrow_forward),
                  //               trailing: IconButton(
                  //                 tooltip: 'レイアウト詳細を表示',
                  //                 icon: const Icon(Icons.arrow_forward),
                  //                 onPressed: () {
                  //                   Navigator.of(context)
                  //                       .pushNamed('/contractor_list');
                  //                 },
                  //               ),
                  //             ),
                  //           ),
                  //         ))),
                ],
              )
            : const LoadingScreen(title: 'Now Loding ... Home');
      }),
    );
  }
}
