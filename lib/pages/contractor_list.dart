import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

import '../application_state.dart';
import '../model/status.dart';

class ContractorList extends StatefulWidget {
  const ContractorList({Key? key}) : super(key: key);

  @override
  _ContractorListState createState() => _ContractorListState();
}

class _ContractorListState extends State<ContractorList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contractor List')),
      body: Consumer<ApplicationState>(
          builder: (BuildContext context, appState, _) {
        return appState.loadingState == LoadState.waiting
            ? ListView.builder(
                itemCount: 10,
                itemBuilder: ((context, index) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    height: 50,
                    alignment: Alignment.centerLeft,
                    child: Text('Contractor: $index'),
                  );
                }))
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text('Now Loding ... Parling Lot List'),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                    CircularProgressIndicator(),
                  ],
                ),
              );
      }),
    );
  }
}
