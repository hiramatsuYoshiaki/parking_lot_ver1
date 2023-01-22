import 'package:flutter/material.dart';
import 'package:parking_lot_ver1/model/parking.dart';
import 'package:provider/provider.dart';

import '../application_state.dart';
import '../component/loading_screen.dart';
import '../model/status.dart';

class UserAdd extends StatelessWidget {
  const UserAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Add User')),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.topCenter,
              child: Consumer<ApplicationState>(
                  builder: (BuildContext context, appState, _) {
                return appState.loadingState == LoadState.waiting
                    ? UserAddForm(
                        selectedParking: appState.selectedParking,
                        // addParking: appState.addParking,
                        getParking: appState.getParking)
                    : const LoadingScreen(
                        title: 'Now Loding ...Use Mofidication');
              }),
            ),
          ),
        ));
  }
}

class UserAddForm extends StatefulWidget {
  const UserAddForm(
      {Key? key,
      required this.selectedParking,
      // required this.addParking,
      required this.getParking})
      : super(key: key);
  final Parking selectedParking;
  // final void Function(Parking parking) addParking;
  final void Function() getParking;

  @override
  _UserAddFormState createState() => _UserAddFormState();
}

class _UserAddFormState extends State<UserAddForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_userAddForm');
  TextEditingController _contractorController = TextEditingController(text: '');
  TextEditingController _carNoController = TextEditingController(text: '');
  TextEditingController _carNameController = TextEditingController(text: '');
  // @override
  // void initState() {
  //   super.initState();
  //   _contractorController.text = widget.selectedParking.contractor;
  //   _carNoController.text = widget.selectedParking.carNo;
  //   _carNameController.text = widget.selectedParking.carName;
  // }

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton.extended(
                    onPressed: () {
                      // if (_formKey.currentState!.validate()) {
                      //   print('modification User');
                      //   print(widget.selectedParking.id);
                      //   print(widget.selectedParking.used ? 'true' : 'false');
                      //   print(widget.selectedParking.contractor);
                      //   print(widget.selectedParking.contractorId);
                      //   print(widget.selectedParking.carNo);
                      //   print(widget.selectedParking.carName);
                      //   print(widget.selectedParking.lotNo);

                      //   widget.updateParking(Parking(
                      //     id: widget.selectedParking.id,
                      //     used: true,
                      //     contractor: _contractorController.text,
                      //     contractorId: widget.selectedParking.contractorId,
                      //     carNo: _carNoController.text,
                      //     carName: _carNameController.text,
                      //     lotNo: widget.selectedParking.lotNo,
                      //   ));
                      //   widget.getParking();
                      // }
                    },
                    label: const Text('登録', style: TextStyle(fontSize: 12)),
                    icon: const Icon(Icons.add),
                    backgroundColor: Colors.blue,
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              child: const Text('もどる'),
              onPressed: () {
                Navigator.of(context).pushNamed('/parking_lot_list');
              },
            ),
            const SizedBox(height: 16),
          ],
        ));
  }
}
