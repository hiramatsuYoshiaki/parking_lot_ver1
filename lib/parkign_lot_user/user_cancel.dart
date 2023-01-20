import 'package:flutter/material.dart';
import 'package:parking_lot_ver1/component/loading_screen.dart';
import 'package:parking_lot_ver1/model/status.dart';
import 'package:provider/provider.dart';

import '../application_state.dart';

class UserCancel extends StatelessWidget {
  const UserCancel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Container(child: Text('User Cancel'));
    return Scaffold(
      appBar: AppBar(title: Text('Cansel User')),
      body: SingleChildScrollView(
          child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1200),
              child: Consumer<ApplicationState>(
                builder: (BuildContext context, appState, _) {
                  return appState.loadingState == LoadState.waiting
                      ? Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: <Widget>[
                              Text('Camsel User'),
                            ],
                          ))
                      : const LoadingScreen(
                          title: 'Now Loading ... Cansel User');
                },
              ))),
    );
  }
}
