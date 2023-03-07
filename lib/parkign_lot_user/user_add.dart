import 'package:flutter/material.dart';
import 'package:parking_lot_ver1/model/parking.dart';
import 'package:provider/provider.dart';

import '../application_state.dart';
import '../component/loading_screen.dart';
import '../model/contractor.dart';
import '../model/status.dart';
import 'package:intl/intl.dart';

import '../ui/app_bar_bottom.dart';

class UserAdd extends StatelessWidget {
  const UserAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Add User')),
        bottomNavigationBar: Consumer<ApplicationState>(
          builder: (BuildContext context, appState, _) => AppBarBottom(
              // homeState: appState.homeState,
              // setHomeState: appState.setHomeState,
              // activityState: appState.activityState,
              // setActivityState: appState.setActivityState,
              ),
        ),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.topCenter,
              child: Consumer<ApplicationState>(
                  builder: (BuildContext context, appState, _) {
                print('UserAdd');
                return appState.loadingState == LoadState.waiting
                    ? UserAddForm(
                        selectedParking: appState.selectedParking,
                        addParking: appState.addParking,
                        addParkingExistingContractor:
                            appState.addParkingExistingContractor,
                        getParking: appState.getParking,
                        contracts: appState.contracts,
                      )
                    : const LoadingScreen(
                        title: 'Now Loding ...Use Mofidication');
              }),
            ),
          ),
        ));
  }
}

class UserAddForm extends StatefulWidget {
  const UserAddForm({
    Key? key,
    required this.selectedParking,
    required this.addParking,
    required this.addParkingExistingContractor,
    required this.getParking,
    required this.contracts,
  }) : super(key: key);
  final Parking selectedParking;
  final void Function(Parking parking, Contract contract) addParking;
  final void Function(Parking parking, Contract contract, ParkingLot parkingLot)
      addParkingExistingContractor;
  final void Function() getParking;
  final List<Contract> contracts;

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
  TextEditingController _contractDateController = TextEditingController();

  DateTime _date = DateTime.now();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2020),
        lastDate: DateTime.now().add(const Duration(days: 360)));
    if (picked != null) setState(() => _date = picked);
    // _dateController.text = DateFormat('yyyy年M月d日 hh時mm分').format(_date);
    _contractDateController.text = DateFormat('yyyy年M月d日').format(_date);
    print('入力した日付-------');
    print(DateFormat('yyyy年M月d日').format(_date));
  }

  List<String> list = <String>[];
  late String dropdownValue;
  List<Contract> contracts = <Contract>[];
  Contract selectedContract = Contract(
      id: '',
      name: '',
      address: '',
      tel: 'tel',
      parkingLot: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now());
  bool isNew = true;

  @override
  void initState() {
    super.initState();
    print('initState');
    print(widget.contracts.length);
    if (widget.contracts.isNotEmpty) {
      list = widget.contracts.map((value) => value.name).toList();
      contracts = widget.contracts.map((value) => value).toList();
      dropdownValue = list.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    // String dropdownContract = widget.contract.first;
    print('UserAdd UserAddForm ');
    // print(widget.contracts[0]);
    // final List<Contract> contractLists = widget.contracts;
    // print(widget.contracts.length);
    widget.contracts.forEach((value) {
      print('contract data#########');
      print(value.id);
      print(value.name);
      print('-----------');
    });
    // widget.contracts.map((value) {
    //   print('contract data----');
    //   print(value.id);
    //   print(value.name);
    // });
    return SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 16),

                // ListView.builder(
                //     padding: const EdgeInsets.all(8),
                //     itemCount: widget.contracts.length,
                //     itemBuilder: (BuildContext context, int index) {
                //       return Wrap(children: [
                //         Text('Entry ${widget.contracts[index].name}')
                //       ]);
                //     }),
                //             widget.contracts.map((item) => Container (
                //   width: size.width,
                //   decoration: BoxDecoration(
                //     border: Border(
                //       bottom: BorderSide(color: Colors.black38),
                //     ),
                //   ),
                //   child: Padding(
                //     child: Text('$item', style: TextStyle(fontSize: 22.0),),
                //     padding: EdgeInsets.all(20.0),),
                // )).toList();

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
                        const Text(
                          "契約者",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 16),
                        Switch(
                          // This bool value toggles the switch.
                          value: isNew,
                          activeColor: Colors.blue,
                          onChanged: (bool value) {
                            // This is called when the user toggles the switch.
                            setState(() {
                              isNew = value;
                              if (isNew) {
                                _contractorController =
                                    TextEditingController(text: "");
                                _addressController =
                                    TextEditingController(text: "");
                                _telController =
                                    TextEditingController(text: "");
                              }
                            });
                          },
                        ),
                        isNew
                            ? Wrap(
                                children: const [
                                  Text(
                                    "新規",
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "既存",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            : Wrap(children: const [
                                Text(
                                  "新規",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "既存",
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
                        // const Text(
                        //     "既存契約者",
                        //     style: TextStyle(
                        //         fontSize: 20, fontWeight: FontWeight.bold),
                        //   ),
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
                            print(list.indexOf(value!));
                            print(contracts[list.indexOf(value)].id);
                            print(contracts[list.indexOf(value)].name);
                            print(contracts[list.indexOf(value)].address);
                            print(contracts[list.indexOf(value)].tel);

                            setState(() {
                              dropdownValue = value;
                              _contractorController = TextEditingController(
                                  text: contracts[list.indexOf(value)].name);
                              _addressController = TextEditingController(
                                  text: contracts[list.indexOf(value)].address);
                              _telController = TextEditingController(
                                  text: contracts[list.indexOf(value)].tel);
                              selectedContract = Contract(
                                  id: contracts[list.indexOf(value)].id,
                                  name: contracts[list.indexOf(value)].name,
                                  address:
                                      contracts[list.indexOf(value)].address,
                                  tel: contracts[list.indexOf(value)].tel,
                                  parkingLot:
                                      contracts[list.indexOf(value)].parkingLot,
                                  createdAt:
                                      contracts[list.indexOf(value)].createdAt,
                                  updatedAt:
                                      contracts[list.indexOf(value)].updatedAt);
                            });
                          },
                          items: list
                              .map<DropdownMenuItem<String>>((String value) {
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                          flex: 8,
                          child: TextFormField(
                            enabled: false,
                            controller: _contractDateController,
                            decoration: const InputDecoration(
                              labelText: '契約日',
                              // hintText: '日付を入力してください',
                              // helperText: '必須'
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return '契約日は必須です';
                              }
                              return null;
                            },
                          )),
                      Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: () => _selectDate(context),
                            child: const Text('契約日選択'),
                          ))
                      // Expanded(
                      //     flex: 2,
                      //     child: ElevatedButton(
                      //       onPressed: () => _selectTime(context),
                      //       child: const Text('日付選択'),
                      //     ))
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isNew
                          //新規追加
                          ? FloatingActionButton.extended(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  print('New add User');
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
                                    // contractDate: DateTime.now(),
                                    contractDate: DateTime(
                                        _date.year,
                                        _date.month,
                                        _date.day,
                                        _date.hour,
                                        _date.minute),
                                    // cancelDate: DateTime.now(),
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
                                  Navigator.of(context)
                                      .pushNamed('/parking_lot_list');
                                }
                              },
                              label: const Text('新規登録',
                                  style: TextStyle(fontSize: 12)),
                              icon: const Icon(Icons.add),
                              backgroundColor: Colors.blue,
                            )
                          //---------------------------------------
                          //addParkingExistingContractor
                          //既存契約者に追加
                          : FloatingActionButton.extended(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  print('Existing contractor add ');
                                  //---------
                                  //駐車場区画情報
                                  Parking addElementParkingExisting = Parking(
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

                                  //契約者登録
                                  ParkingLot addElementParkingLot = ParkingLot(
                                    id: widget.selectedParking.id,
                                    used: true,
                                    carNo: _carNoController.text,
                                    carName: _carNameController.text,
                                    carOwner: _carOwnerController.text,
                                    lotNo: widget.selectedParking.lotNo.toInt(),
                                    contractDate: DateTime(
                                        _date.year,
                                        _date.month,
                                        _date.day,
                                        _date.hour,
                                        _date.minute),
                                    cancelDate: null,
                                    contractType: 'person',
                                    createdAt: DateTime.now(),
                                    updatedAt: DateTime.now(),
                                  );
                                  //------

                                  print(
                                      'selectedContract contract.id: ${selectedContract.id}');
                                  print(
                                      'selectedContract parkinglot length: ${selectedContract.parkingLot!.length}');

                                  Contract addElementContractExisting =
                                      Contract(
                                    id: selectedContract.id,
                                    name: selectedContract.name,
                                    address: selectedContract.address,
                                    tel: selectedContract.tel,
                                    parkingLot: selectedContract.parkingLot,
                                    createdAt: DateTime.now(),
                                    updatedAt: DateTime.now(),
                                  );
                                  //すべてのデータを更新する場合はparkingLotに追加して更新
                                  addElementContractExisting.parkingLot!
                                      .add(addElementParkingLot);
                                  print(
                                      'addElementContractExisting.parkingLot length: ${addElementContractExisting.parkingLot!.length}');

                                  widget.addParkingExistingContractor(
                                      addElementParkingExisting,
                                      addElementContractExisting,
                                      addElementParkingLot);
                                  Navigator.of(context)
                                      .pushNamed('/parking_lot_list');
                                }
                              },
                              label: const Text('既存登録',
                                  style: TextStyle(fontSize: 12)),
                              icon: const Icon(Icons.add),
                              backgroundColor: Colors.blue,
                            ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  child: const Text('キャンセル'),
                  onPressed: () {
                    // Navigator.of(context).pushNamed('/parking_lot_list');
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(height: 16),
              ],
            )));
  }
}
