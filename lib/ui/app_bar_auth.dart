import 'package:flutter/material.dart';
import 'package:parking_lot_ver1/pages/auth.dart';
import 'package:parking_lot_ver1/pages/logout.dart';
import 'package:provider/provider.dart';

import '../application_state.dart';

class AppBarAuth extends StatelessWidget implements PreferredSizeWidget {
  const AppBarAuth({Key? key, required this.titleText})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);
  final String titleText;

  @override
  final Size preferredSize; //default is 56.0
  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(titleText,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    ?.copyWith(color: Colors.white))),
        actions: <Widget>[
          Consumer<ApplicationState>(builder: (context, appState, _) {
            return (appState.getCurrentUser != null)
                ? TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Logout()));
                    },
                    child: const Text('LOGOUT',
                        style: TextStyle(color: Colors.white)))
                : TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Auth()));
                    },
                    child: const Text('LOGIN',
                        style: TextStyle(color: Colors.white)));
          })
        ]);
  }
}
