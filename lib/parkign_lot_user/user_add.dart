import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../application_state.dart';
import '../component/loading_screen.dart';
import '../model/status.dart';

class UserAdd extends StatelessWidget {
  const UserAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Add User')),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 1200),
            child: Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.topCenter,
              child: Consumer<ApplicationState>(
                  builder: (BuildContext context, appState, _) {
                return appState.loadingState == LoadState.waiting
                    ? Container(
                        child: Column(children: <Widget>[
                        Text('Edit User'),
                        Text('Modification User')
                      ]))
                    : const LoadingScreen(
                        title: 'Now Loding ...Use Mofidication');
              }),
            ),
          ),
        ));
  }
}
