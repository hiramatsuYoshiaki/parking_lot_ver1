import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parking_lot_ver1/model/parking.dart';
import 'package:parking_lot_ver1/model/status.dart';
import 'package:provider/provider.dart';

import '../application_state.dart';
import '../component/loading_screen.dart';

class UserModification extends StatelessWidget {
  const UserModification({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // final _formKey = GlobalKey<FormState>(debugLabel: '_UserModification');
    // TextEditingController _contractorController = TextEditingController();
    // _contractorController.text = "";
    return Scaffold(
        appBar: AppBar(title: const Text('Modification')),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.topCenter,
              child: Consumer<ApplicationState>(
                  builder: (BuildContext context, appState, _) {
                return appState.loadingState == LoadState.waiting
                    ? UserModificationForm(
                        selectedParking: appState.selectedParking,
                        updateParking: appState.updateParking,
                        getParking: appState.getParking,
                      )
                    : const LoadingScreen(
                        title: 'Now Loding ...Use Mofidication');
              }),
            ),
          ),
        ));
  }
}

class UserModificationForm extends StatefulWidget {
  const UserModificationForm(
      {Key? key,
      required this.selectedParking,
      required this.updateParking,
      required this.getParking})
      : super(key: key);
  final Parking selectedParking;
  final void Function(Parking parking) updateParking;
  final void Function() getParking;
  @override
  _UserModificationFormState createState() => _UserModificationFormState();
}

class _UserModificationFormState extends State<UserModificationForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_userModificationForm');
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
                  "??????????????? ${widget.selectedParking.lotNo}",
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                )),
            const SizedBox(height: 16),
            TextFormField(
              enabled: false,
              controller: _contractorController,
              decoration: const InputDecoration(
                labelText: '?????????',
                hintText: '????????????????????????????????????',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return '????????????????????????';
                }
                if (value.length > 31) {
                  return '????????????31??????????????????';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _carNoController,
              decoration: const InputDecoration(
                labelText: '????????????',
                hintText: '???????????????????????????????????????',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return '???????????????????????????';
                }
                if (value.length > 31) {
                  return '???????????????31??????????????????';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _carNameController,
              decoration: const InputDecoration(
                labelText: '??????',
                hintText: '?????????????????????????????????',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return '?????????????????????';
                }
                if (value.length > 31) {
                  return '?????????31??????????????????';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _carOwnerController,
              decoration: const InputDecoration(
                labelText: '?????????',
                hintText: '????????????????????????????????????',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return '????????????????????????';
                }
                if (value.length > 31) {
                  return '????????????31??????????????????';
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
                        print('modification User');
                        print(widget.selectedParking.id);
                        print(widget.selectedParking.used ? 'true' : 'false');
                        print(widget.selectedParking.contractor);
                        print(widget.selectedParking.contractorId);
                        print(widget.selectedParking.carNo);
                        print(widget.selectedParking.carName);
                        print(widget.selectedParking.carOwner);
                        print(widget.selectedParking.lotNo);

                        widget.updateParking(Parking(
                          id: widget.selectedParking.id,
                          used: true,
                          contractor: _contractorController.text,
                          contractorId: widget.selectedParking.contractorId,
                          carNo: _carNoController.text,
                          carName: _carNameController.text,
                          carOwner: _carOwnerController.text,
                          lotNo: widget.selectedParking.lotNo,
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                        ));
                        widget.getParking();
                        Navigator.of(context).pushNamed('/parking_lot_list');
                      }
                    },
                    label: const Text('??????', style: TextStyle(fontSize: 12)),
                    icon: const Icon(Icons.build),
                    backgroundColor: Colors.blue,
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              child: const Text('???????????????'),
              onPressed: () {
                Navigator.of(context).pushNamed('/parking_lot_list');
              },
            ),
            const SizedBox(height: 16),
          ],
        ));
  }
}
