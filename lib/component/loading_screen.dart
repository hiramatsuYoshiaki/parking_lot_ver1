import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$title...'),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
        ),
        const CircularProgressIndicator(),
      ],
    ));
  }
}
