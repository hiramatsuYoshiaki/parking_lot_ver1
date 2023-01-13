import 'package:flutter/material.dart';
import 'package:parking_lot_ver1/pages/arrangement.dart';
import 'package:provider/provider.dart';

import '../application_state.dart';
import '../model/status.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Parking Lot Ver1'),
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Colors.green[100],
              alignment: Alignment.center,
              // child: Consumer<ApplicationState>(
              //   builder: (BuildContext context, appState, _) {
              //     return const Text('Home !!');
              //   },
              // )
              // child: const Text('home'),
              child: Column(children: [
                Expanded(child: Consumer<ApplicationState>(
                  builder: (BuildContext context, appState, _) {
                    return appState.lodingState == LoadState.waiting
                        // ? HomeSwitch(
                        //     homeState: appState.homeState,
                        //     setHomeState: appState.setHomeState,
                        //   )
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    padding: const EdgeInsets.only(bottom: 24),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushNamed('/arrangement');
                                        },
                                        child: const Text('arrangement'))),
                                Container(
                                    padding: const EdgeInsets.only(bottom: 24),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushNamed('/parking_lot_list');
                                        },
                                        child: const Text('parking lot list'))),
                                Container(
                                    padding: const EdgeInsets.only(bottom: 24),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushNamed('/contractor');
                                        },
                                        child: const Text('contractor'))),
                                Container(
                                    padding: const EdgeInsets.only(bottom: 24),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushNamed('/contractor_list');
                                        },
                                        child: const Text('contractor list'))),
                              ],
                            ),
                          )
                        // : const LoadingScreenAddText(
                        //     title: 'Now Loding ... Home');
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Text('Now Loding ... Home'),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                ),
                                CircularProgressIndicator(),
                              ],
                            ),
                          );
                  },
                ))
              ]),
            ),
          ),
        ));
  }
}
