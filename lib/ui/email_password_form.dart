import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

import '../model/status.dart';
import '../pages/home_page.dart';

class EmailPasswordForm extends StatefulWidget {
  const EmailPasswordForm({
    Key? key,
    required this.login,
    required this.setLoginState,
  }) : super(key: key);
  final void Function(String email, String password) login;
  final void Function(LoginState status) setLoginState;

  @override
  _EmailPasswordFormState createState() => _EmailPasswordFormState();
}

class _EmailPasswordFormState extends State<EmailPasswordForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_EmailPasswordFormState');
  final _emailController = TextEditingController(text: 'hworksdev@gmail.com');
  final _passwordController = TextEditingController(text: 'Pass0000');
  @override
  Widget build(BuildContext context) {
    return Expanded(child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstrains) {
      return SingleChildScrollView(
          child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: viewportConstrains.maxHeight),
              child: IntrinsicHeight(
                  child: Column(
                children: <Widget>[
                  //header
                  Container(
                    height: 400,
                    alignment: Alignment.center,
                    child: const Text('LOGINしてください'),
                  ),
                  //Form
                  Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: TextFormField(
                                      controller: _emailController,
                                      decoration: const InputDecoration(
                                          labelText: 'メールアドレス',
                                          hintText: 'メールアドレスを入力してください'),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'メールアドレスは必須です';
                                        }
                                        if (!EmailValidator.validate(value)) {
                                          return 'メールの形式が正しくありません';
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: TextFormField(
                                      controller: _passwordController,
                                      decoration: const InputDecoration(
                                        labelText: 'パスワード',
                                        hintText: 'パスワードを入力してください',
                                        helperText: '8文字以上、大文字と数字を1つ以上使ってください',
                                      ),
                                      // obscureText: true,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'パスワードは必須です';
                                        }
                                        String pattern1 =
                                            r'^[a-zA-Z0-9.?/-]{8,}$';
                                        RegExp regExp1 = RegExp(pattern1);
                                        if (!regExp1.hasMatch(value)) {
                                          return '8文字以上の英数字を入力してください';
                                        }
                                        String pattern2 = r'(?=.*[A-Z])';
                                        RegExp regExp2 = RegExp(pattern2);
                                        if (!regExp2.hasMatch(value)) {
                                          return '少なくとも大文字を1つ以上使ってください';
                                        }
                                        String pattern3 = r'(?=.*[0-9])';
                                        RegExp regExp3 = RegExp(pattern3);
                                        if (!regExp3.hasMatch(value)) {
                                          return '少なくとも数字を1つ以上使ってください';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const SizedBox(width: 16),
                                        ElevatedButton(
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              widget.login(
                                                _emailController.text,
                                                _passwordController.text,
                                                //       'hworksdev@gmail.com',
                                                //       'Pass0000',
                                              );
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                builder: (context) {
                                                  return const HomePage();
                                                },
                                              ));
                                            }
                                          },
                                          child: const Text('ログイン'),
                                        ),
                                        const SizedBox(width: 30),
                                        ElevatedButton(
                                            onPressed: () {
                                              // widget
                                              //     .setLoginState(ApplicationLoginState.loggedOut);
                                              Navigator.pop(context);
                                              // Navigator.of(context).pushNamed("/home");
                                              // Navigator.of(context)
                                              //     .push(MaterialPageRoute(builder: (context) {
                                              //   return HomePage();
                                              // }));
                                            },
                                            child: const Text('キャンセル')),
                                      ],
                                    ),
                                  ),
                                ],
                              ))))
                ],
              ))));
    }));
  }
}
