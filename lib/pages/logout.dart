import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../application_state.dart';
import '../model/status.dart';
import 'home_page.dart';

class Logout extends StatelessWidget {
  const Logout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<ApplicationState>(builder: (context, appState, _) {
            return ElevatedButton(
                onPressed: () {
                  appState.signOut();
                  appState.setLoginState(LoginState.loggedOut);
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return HomePage();
                    },
                  ));
                },
                child: const Text('LOGOUT'));
          }),
        ],
      ),
    );
  }
}
