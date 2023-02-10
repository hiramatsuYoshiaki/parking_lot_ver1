import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parking_lot_ver1/ui/email_password_form.dart';

import '../model/status.dart';
import '../pages/home_page.dart';

class AuthSwitch extends StatelessWidget {
  const AuthSwitch({
    Key? key,
    required this.loginState,
    required this.signInWithEmailAndPassword,
    required this.signOut,
    required this.setLoginState,
    required this.getCurrentUser,
  }) : super(key: key);
  final LoginState loginState;
  final void Function(
    String email,
    String password,
    void Function(Exception e) error,
  ) signInWithEmailAndPassword;
  final void Function() signOut;
  final void Function(LoginState status) setLoginState;
  final User? getCurrentUser;
  @override
  Widget build(BuildContext context) {
    // print('Authentication.dart 2');
    // print('loginState: $loginState');
    // update  SingleChildScrollView ok
    switch (loginState) {
      case LoginState.loggedOut:
        return Column(
          children: [
            EmailPasswordForm(
              login: (email, password) {
                signInWithEmailAndPassword(email, password,
                    (e) => _showErrorDialog(context, 'Failed to sign in', e));
              },
              // login: signInWithEmailAndPassword,
              setLoginState: setLoginState,
            ),
          ],
        );

      default:
        return Column(
          children: [
            TextButton(
              onPressed: () {
                // signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: const Text('Error go home'),
            ),
          ],
        );
    }
  }
}

void _showErrorDialog(BuildContext context, String title, Exception e) {
  showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(fontSize: 24),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  '${(e as dynamic).message}',
                  style: const TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      });
}
