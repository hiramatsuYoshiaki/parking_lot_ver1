import 'package:flutter/material.dart';

import '../ui/app_bar_bottom.dart';

class LotLocation extends StatefulWidget {
  const LotLocation({Key? key}) : super(key: key);

  @override
  _LotLocationState createState() => _LotLocationState();
}

class _LotLocationState extends State<LotLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contractor')),
      bottomNavigationBar: const AppBarBottom(),
      body: const Text('Lot Location'),
    );
  }
}
