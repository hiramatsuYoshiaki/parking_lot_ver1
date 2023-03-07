// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../application_state.dart';
import '../model/status.dart';
import '../ui/app_bar_bottom.dart';

class ContractorList extends StatefulWidget {
  const ContractorList({Key? key}) : super(key: key);

  @override
  _ContractorListState createState() => _ContractorListState();
}

class _ContractorListState extends State<ContractorList> {
  @override
  Widget build(BuildContext context) {
    print('parking_contractor_list');
    return Scaffold(
      appBar: AppBar(title: const Text('Contractor List')),
      bottomNavigationBar: Consumer<ApplicationState>(
        builder: (BuildContext context, appState, _) => AppBarBottom(
            // homeState: appState.homeState,
            // setHomeState: appState.setHomeState,
            // activityState: appState.activityState,
            // setActivityState: appState.setActivityState,
            ),
      ),
      body: Consumer<ApplicationState>(
          builder: (BuildContext context, appState, _) {
        return appState.loadingState == LoadState.waiting
            ? ListView.builder(
                itemCount: appState.contracts.length,
                itemBuilder: ((context, index) {
                  return Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.all(8),
                    height: 280,
                    alignment: Alignment.topLeft,
                    // color: Colors.green[200],
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: appState.contracts[index].parkingLot!.length,
                        itemBuilder: (BuildContext context, int idx) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              idx == 0
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Wrap(
                                          children: [
                                            Text(appState.contracts[index].name,
                                                style: const TextStyle(
                                                    fontSize: 24)),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Wrap(children: [
                                          Text(appState
                                              .contracts[index].address),
                                        ]),
                                        const SizedBox(width: 16),
                                        Text(appState.contracts[index].tel),
                                        const SizedBox(width: 32),
                                        const Divider(
                                          height: 16,
                                          thickness: 1,
                                          indent: 8,
                                          endIndent: 8,
                                          color: Colors.black26,
                                        ),
                                      ],
                                    )
                                  : const SizedBox(height: 0),

                              //区画情報--------------
                              Container(
                                alignment: Alignment.bottomLeft,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.end,
                                    spacing: 8,
                                    children: [
                                      Text(
                                        '${appState.contracts[index].parkingLot![idx].lotNo.toString()}区画 ',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color: Colors.black87),
                                      ),
                                      appState.contracts[index].parkingLot![idx]
                                              .used
                                          ? const Text('契約中',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  color: Colors.blueAccent))
                                          : const Text('解約',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  color: Colors.redAccent)),
                                      appState.contracts[index].parkingLot![idx]
                                                  .contractType ==
                                              'person'
                                          ? const Text('個人契約')
                                          : const Text('ダイワリビング契約'),
                                    ]),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    spacing: 8,
                                    children: [
                                      Text(
                                          '${appState.contracts[index].parkingLot![idx].carNo} '),
                                      Text(
                                          '${appState.contracts[index].parkingLot![idx].carName} '),
                                      const SizedBox(width: 8),
                                    ]),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Wrap(children: [
                                  Text(appState.contracts[index]
                                      .parkingLot![idx].carOwner),
                                  const SizedBox(width: 8),
                                ]),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    spacing: 8,
                                    children: [
                                      Text(DateFormat('契約：yyyy年M月d日').format(
                                          appState.contracts[index]
                                              .parkingLot![idx].contractDate)),
                                      Text(
                                          appState
                                                      .contracts[index]
                                                      .parkingLot![idx]
                                                      .cancelDate ==
                                                  null
                                              ? ''
                                              : DateFormat('解約：yyyy年M月d日')
                                                  .format(appState
                                                      .contracts[index]
                                                      .parkingLot![idx]
                                                      .cancelDate!),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Colors.redAccent)),
                                    ]),
                              ),
                              const SizedBox(height: 8),
                            ],
                          );
                        }),
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
