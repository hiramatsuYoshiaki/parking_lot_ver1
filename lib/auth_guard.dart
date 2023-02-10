import 'package:flutter/material.dart';

import 'model/status.dart';

class AuthGuard extends StatelessWidget {
  const AuthGuard(
      {Key? key,
      required this.loginState,
      required this.guard,
      required this.child})
      : super(key: key);
  final LoginState loginState;
  final Widget guard;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    print(LoginState.loggedIn);
    if (loginState == LoginState.loggedIn) {
      return child;
    }
    return guard;
  }
}
