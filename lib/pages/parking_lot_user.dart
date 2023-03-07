import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../application_state.dart';
import '../component/loading_screen.dart';
import '../model/status.dart';
import '../switch/parking_lot_switch.dart';

class ParkingLotUser extends StatefulWidget {
  const ParkingLotUser({Key? key}) : super(key: key);

  @override
  _ParkingLotUserState createState() => _ParkingLotUserState();
}

class _ParkingLotUserState extends State<ParkingLotUser> {
  @override
  Widget build(BuildContext context) {
    print('ParkingLotUser');
    return Consumer<ApplicationState>(
      builder: (BuildContext context, appState, _) {
        return ParkingLotSwitch(
          state: appState.parkingLotUserState,
          // setHomeState: appState.setHomeState,
          // 契約userAdd,
          // 解約userCancel,
          // 契約者リストから選択userList,
          // 区画変更userReplace,
          // 修正userModification,
        );
      },
    );
    //           ))),
    // );
  }
}
