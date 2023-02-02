import 'package:flutter/material.dart';
import 'package:parking_lot_ver1/model/parking.dart';
import 'package:provider/provider.dart';

import '../application_state.dart';
import '../component/loading_screen.dart';
import '../model/contractor.dart';
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
                        addParking: appState.addParking,
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
      required this.addParking,
      required this.getParking})
      : super(key: key);
  final Parking selectedParking;
  final void Function(Parking parking, Contract contract) addParking;
  final void Function() getParking;

  @override
  _UserAddFormState createState() => _UserAddFormState();
}

class _UserAddFormState extends State<UserAddForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_userAddForm');
  TextEditingController _contractorController = TextEditingController(text: '');
  TextEditingController _addressController = TextEditingController(text: '');
  TextEditingController _telController = TextEditingController(text: '');

  TextEditingController _carNoController = TextEditingController(text: '');
  TextEditingController _carNameController = TextEditingController(text: '');
  TextEditingController _carOwnerController = TextEditingController(text: '');
  // @override
  // void initState() {
  //   super.initState();
  //   _contractorController.text = widget.selectedParking.contractor;
  //   _carNoController.text = widget.selectedParking.carNo;
  //   _carNameController.text = widget.selectedParking.carName;
  //   _carOwnerController.text = widget.selectedParking.carOwner;
  // }
  final List<String> list = <String>[
    'タデイ　ポガチャル',
    'ヨナス　ビンゲゴー',
    'レムコ　エメネプール',
    'ゲラント　トーマス'
  ];

  bool isNew = true;

  @override
  Widget build(BuildContext context) {
    String dropdownValue = list.first;
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
            Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    isNew
                        ? const Text(
                            "新規契約者",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        : const Text(
                            "既存契約者",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                    Switch(
                      // This bool value toggles the switch.
                      value: isNew,
                      activeColor: Colors.blue,
                      onChanged: (bool value) {
                        // This is called when the user toggles the switch.
                        setState(() {
                          isNew = value;
                        });
                      },
                    ),
                  ],
                )),
            const SizedBox(height: 8),

            //---

            const SizedBox(height: 8),

            //----
            isNew
                ? TextFormField(
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
                  )
                : Container(
                    width: double.infinity,
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      // icon: const Icon(Icons.arrow_downward),
                      // elevation: 16,
                      // style: const TextStyle(color: Colors.deepPurple),
                      // underline: Container(
                      //   height: 2,
                      //   color: Colors.deepPurpleAccent,
                      // ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: '住所',
                hintText: '住所を入力してください',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return '住所は必須です';
                }
                if (value.length > 31) {
                  return '住所は51文字以内です';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _telController,
              decoration: const InputDecoration(
                labelText: '電話番号',
                hintText: '電話番号を入力してください',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return '電話番号は必須です';
                }
                if (value.length > 31) {
                  return '電話番号は31文字以内です';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "登録車輌",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
            const SizedBox(height: 8),
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
            TextFormField(
              controller: _carOwnerController,
              decoration: const InputDecoration(
                labelText: '車輌保有者',
                hintText: '車輌保有者を入力してください',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return '車輌保有者は必須です';
                }
                if (value.length > 31) {
                  return '車輌保有者は31文字以内です';
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
                        print('add User');
                        //---------
                        //駐車場区画情報
                        Parking addElementParking = Parking(
                          id: widget.selectedParking.id,
                          used: true,
                          contractor: _contractorController.text,
                          contractorId: "",
                          carNo: _carNoController.text,
                          carName: _carNameController.text,
                          carOwner: _carOwnerController.text,
                          lotNo: widget.selectedParking.lotNo,
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                        );
                        //---------
                        //契約者登録
                        ParkingLot addElementParkingLot = ParkingLot(
                          id: widget.selectedParking.id,
                          used: true,
                          carNo: _carNoController.text,
                          carName: _carNameController.text,
                          carOwner: _carOwnerController.text,
                          lotNo: widget.selectedParking.lotNo.toInt(),
                          contractDate: DateTime.now(),
                          cancelDate: null,
                          contractType: 'person',
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                        );
                        List<ParkingLot> listParkingLot = [];
                        listParkingLot.add(addElementParkingLot);
                        //------
                        Contract addElementContract = Contract(
                          id: "",
                          name: _contractorController.text,
                          address: _addressController.text,
                          tel: _telController.text,
                          parkingLot: listParkingLot,
                          // parkingLot: [
                          //   ParkingLot(
                          //     id: widget.selectedParking.id,
                          //     used: true,
                          //     carNo: _carNoController.text,
                          //     carName: _carNameController.text,
                          //     carOwner: _carOwnerController.text,
                          //     lotNo: widget.selectedParking.lotNo.toInt(),
                          //     contractDate: DateTime.now(),
                          //     cancelDate: null,
                          //     contractType: 'person',
                          //     createdAt: DateTime.now(),
                          //     updatedAt: DateTime.now(),
                          //   ),
                          // ],
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                        );
                        widget.addParking(
                            addElementParking, addElementContract);
                        Navigator.of(context).pushNamed('/parking_lot_list');
                      }
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
