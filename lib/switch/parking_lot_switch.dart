import 'package:flutter/material.dart';

import '../model/status.dart';
import '../parkign_lot_user/user_add.dart';
import '../parkign_lot_user/user_cancel.dart';
import '../parkign_lot_user/user_display.dart';
import '../parkign_lot_user/user_list.dart';
import '../parkign_lot_user/user_modification.dart';
import '../parkign_lot_user/user_replace.dart';

class ParkingLotSwitch extends StatelessWidget {
  const ParkingLotSwitch({Key? key, required this.state}) : super(key: key);
  final ParkingLotUserState state;
  @override
  Widget build(BuildContext context) {
    // 契約userAdd,
    // 解約userCancel,
    // 契約者リストから選択userList,
    // 区画変更userReplace,
    // 修正userModification,
    switch (state) {
      case ParkingLotUserState.display:
        return UserDisplay();
      case ParkingLotUserState.add:
        return UserAdd();
      case ParkingLotUserState.cancel:
        return UserCancel();
      case ParkingLotUserState.list:
        return UserList();
      case ParkingLotUserState.replace:
        return UserReplace();
      case ParkingLotUserState.modification:
        return UserModification();
    }
  }
}
