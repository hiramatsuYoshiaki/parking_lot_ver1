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
    final _formKey = GlobalKey<FormState>(debugLabel: '_UserModification');
    TextEditingController _contractorController = TextEditingController();
    _contractorController.text = "";
    return Scaffold(
        appBar: AppBar(title: Text('Modification')),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 1200),
            child: Container(
              padding: EdgeInsets.all(8),
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
  @override
  void initState() {
    super.initState();
    _contractorController.text = widget.selectedParking.contractor;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 16),
            TextFormField(
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
                        print(widget.selectedParking.lotNo);

                        widget.updateParking(Parking(
                          id: widget.selectedParking.id,
                          used: true,
                          contractor: _contractorController.text,
                          contractorId: widget.selectedParking.contractorId,
                          carNo: widget.selectedParking.carNo,
                          carName: widget.selectedParking.carName,
                          lotNo: widget.selectedParking.lotNo,
                        ));
                        widget.getParking();
                      }
                    },
                    label: const Text('修正', style: TextStyle(fontSize: 12)),
                    icon: const Icon(Icons.build),
                    backgroundColor: Colors.blue,
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              child: const Text('もどる'),
              onPressed: () {
                // appState.setSelectedParking(
                //     appState.parking[index]);
                // appState.setParkingLotUserState(
                //     ParkingLotUserState.display);
                // Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/parking_lot_list');
              },
            ),
            const SizedBox(height: 16),
          ],
        )
        // TextFormField(
        //   decoration: const InputDecoration(
        //     labelText: '契約者',
        //     hintText: '契約者を入力してください',
        //     // helperText: '必須'
        //   ),
        //   controller: _contractorController,
        //   // controller: _contractorController,
        //   // initialValue: 'appState.selectedParking.contractor',
        //   // initialValue: 'Title',
        // )
        );
  }
}
