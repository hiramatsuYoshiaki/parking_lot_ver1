import 'package:flutter/material.dart';
import 'package:parking_lot_ver1/application_state.dart';
import 'package:parking_lot_ver1/model/status.dart';
import 'package:parking_lot_ver1/switch/auth_switch.dart';
import 'package:provider/provider.dart';

import '../component/loading_screen.dart';
import '../ui/app_bar_auth.dart';

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarAuth(titleText: 'Auth'),
      body: Center(
          child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.green[100],
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Expanded(child: Consumer<ApplicationState>(
                        builder: (BuildContext context, appState, _) {
                          // return appState.loadingState != LoadState.loading
                          //     ? AuthSwitch(
                          //         loginState: appState.loginState,
                          //         // email: appState.email,
                          //         // verifyEmail: appState.verifyEmail,
                          //         signInWithEmailAndPassword:
                          //             appState.signInWithEmailAndPassword,
                          //         // registerAccount: appState.registerAccount,
                          //         signOut: appState.signOut,
                          //         setLoginState: appState.setLoginState,
                          //         getCurrentUser: appState.getCurrentUser,
                          //         // sendEmailVerification:
                          //         //     appState.sendEmailVerification,
                          //         // passReset: appState.passReset,
                          //       )
                          //     : const LoadingScreen(
                          //         title: 'Now Loding ... Authentication');
                          return AuthSwitch(
                            loginState: appState.loginState,
                            // email: appState.email,
                            // verifyEmail: appState.verifyEmail,
                            signInWithEmailAndPassword:
                                appState.signInWithEmailAndPassword,
                            // registerAccount: appState.registerAccount,
                            signOut: appState.signOut,
                            setLoginState: appState.setLoginState,
                            getCurrentUser: appState.getCurrentUser,
                            // sendEmailVerification:
                            //     appState.sendEmailVerification,
                            // passReset: appState.passReset,
                          );
                        },
                      ))
                    ],
                  )))),
    );
  }
}
