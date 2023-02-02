import 'package:flutter/material.dart';
import 'package:parking_lot_ver1/component/loading_screen.dart';
import 'package:parking_lot_ver1/model/parking.dart';
import 'package:parking_lot_ver1/model/status.dart';
import 'package:provider/provider.dart';

import '../application_state.dart';

class UserCancel extends StatelessWidget {
  const UserCancel({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Cansel User')),
        body: SingleChildScrollView(
          child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1200),
              child: Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.topCenter,
                  child: Consumer<ApplicationState>(
                    builder: (BuildContext context, appState, _) {
                      return appState.loadingState == LoadState.waiting
                          ? UserCancelForm(
                              selectedParking: appState.selectedParking,
                              cancelParking: appState.cancelParking,
                              getParking: appState.getParking,
                            )
                          // Container(
                          //     alignment: Alignment.topCenter,
                          //     padding: EdgeInsets.all(8),
                          //     child: Column(
                          //       children: <Widget>[
                          //         Text('Camsel User'),
                          //         FloatingActionButton.extended(
                          //           onPressed: () {

                          //           },
                          //           label: const Text('解約',
                          //               style: TextStyle(fontSize: 12)),
                          //           icon: const Icon(Icons.close),
                          //           backgroundColor: Colors.blue,
                          //         )
                          //       ],
                          //     ))
                          : const LoadingScreen(
                              title: 'Now Loading ... Cansel User');
                    },
                  ))),
        ));
  }
}

class UserCancelForm extends StatefulWidget {
  const UserCancelForm(
      {Key? key,
      required this.selectedParking,
      required this.cancelParking,
      required this.getParking})
      : super(key: key);
  final Parking selectedParking;
  final void Function(Parking parking) cancelParking;
  final void Function() getParking;

  @override
  _UserCancelFormState createState() => _UserCancelFormState();
}

class _UserCancelFormState extends State<UserCancelForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_userCanselForm');
  TextEditingController _contractorController = TextEditingController(text: '');
  TextEditingController _carNoController = TextEditingController(text: '');
  TextEditingController _carNameController = TextEditingController(text: '');
  TextEditingController _carOwnerController = TextEditingController(text: '');
  @override
  void initState() {
    super.initState();
    _contractorController.text = widget.selectedParking.contractor;
    _carNoController.text = widget.selectedParking.carNo;
    _carNameController.text = widget.selectedParking.carName;
    _carOwnerController.text = widget.selectedParking.carOwner;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 16),
            Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "区画番号： ${widget.selectedParking.lotNo}",
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                )),
            const SizedBox(height: 16),
            TextFormField(
              enabled: false,
              controller: _contractorController,
              decoration: const InputDecoration(
                labelText: '契約者',
                hintText: '契約者を入力してください',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return '契約者は必須です';
                }
                if (value.length > 31) {
                  return '契約者は31文字以内です';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              enabled: false,
              controller: _carNoController,
              decoration: const InputDecoration(
                labelText: '車両番号',
                hintText: '車両番号を入力してください',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return '車両番号は必須です';
                }
                if (value.length > 31) {
                  return '車両番号は31文字以内です';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              enabled: false,
              controller: _carNameController,
              decoration: const InputDecoration(
                labelText: '車種',
                hintText: '車種を入力してください',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return '車種は必須です';
                }
                if (value.length > 31) {
                  return '車種は31文字以内です';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              enabled: false,
              controller: _carOwnerController,
              decoration: const InputDecoration(
                labelText: '所有者',
                hintText: '所有者を入力してください',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return '所有者は必須です';
                }
                if (value.length > 31) {
                  return '所有者は31文字以内です';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton.extended(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print('cansel User');
                        print(widget.selectedParking.id);
                        print(widget.selectedParking.used ? 'true' : 'false');
                        print(widget.selectedParking.contractor);
                        print(widget.selectedParking.contractorId);
                        print(widget.selectedParking.carNo);
                        print(widget.selectedParking.carName);
                        print(widget.selectedParking.carOwner);
                        print(widget.selectedParking.lotNo);

                        widget.cancelParking(Parking(
                          id: widget.selectedParking.id,
                          used: false,
                          contractor: "",
                          contractorId: "",
                          carNo: "",
                          carName: "",
                          lotNo: widget.selectedParking.lotNo,
                          carOwner: "",
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                          // contractor: widget.selectedParking.contractor,
                          // contractorId: widget.selectedParking.contractorId,
                          // carNo: widget.selectedParking.carNo,
                          // carName: widget.selectedParking.carName,
                          // lotNo: widget.selectedParking.lotNo,
                        ));
                        widget.getParking();
                        Navigator.of(context).pushNamed('/parking_lot_list');
                      }
                    },
                    label: const Text('解約', style: TextStyle(fontSize: 12)),
                    icon: const Icon(Icons.close),
                    backgroundColor: Colors.blue,
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              child: const Text('キャンセル'),
              onPressed: () {
                Navigator.of(context).pushNamed('/parking_lot_list');
              },
            ),
            const SizedBox(height: 16),
          ],
        ));
  }
}
