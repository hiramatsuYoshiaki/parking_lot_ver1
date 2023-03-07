import 'dart:math';

import 'package:flutter/material.dart';
import 'package:parking_lot_ver1/component/loading_screen.dart';
import 'package:parking_lot_ver1/model/contractor.dart';
import 'package:parking_lot_ver1/model/parking.dart';
import 'package:parking_lot_ver1/model/status.dart';
import 'package:provider/provider.dart';

import '../application_state.dart';
import 'package:intl/intl.dart';

class UserCancel extends StatelessWidget {
  const UserCancel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('user_cancel*******************************');
    return Scaffold(
        appBar: AppBar(title: const Text('Cansel User')),
        body: SingleChildScrollView(
          child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.topCenter,
                  child: Consumer<ApplicationState>(
                    builder: (BuildContext context, appState, _) {
                      return appState.loadingState == LoadState.waiting
                          ? UserCancelForm(
                              selectedParking: appState.selectedParking,
                              cancelParking: appState.cancelParking,
                              contracts: appState.contracts,
                              updateCancelDate: appState.updateCancelDate,
                            )
                          : const LoadingScreen(
                              title: 'Now Loading ... Cansel User');
                    },
                  ))),
        ));
  }
}

class UserCancelForm extends StatefulWidget {
  const UserCancelForm({
    Key? key,
    required this.selectedParking,
    required this.cancelParking,
    required this.contracts,
    required this.updateCancelDate,
  }) : super(key: key);
  final Parking selectedParking;
  final void Function(Parking parking) cancelParking;
  final void Function(Contract constract) updateCancelDate;
  final List<Contract> contracts;

  @override
  _UserCancelFormState createState() => _UserCancelFormState();
}

class _UserCancelFormState extends State<UserCancelForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_userCanselForm');
  TextEditingController _contractorController = TextEditingController(text: '');
  TextEditingController _carNoController = TextEditingController(text: '');
  TextEditingController _carNameController = TextEditingController(text: '');
  TextEditingController _carOwnerController = TextEditingController(text: '');

  TextEditingController _contractDateController = TextEditingController();
  TextEditingController _cancellDateController = TextEditingController();
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  TextEditingController _pickedDateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2020),
        lastDate: DateTime.now().add(const Duration(days: 360)));

    if (picked != null) setState(() => _date = picked);
    // _dateController.text = DateFormat('yyyy年M月d日 hh時mm分').format(_date);
    _pickedDateController.text = DateFormat('yyyy年M月d日').format(_date);
  }

  Contract contract = Contract(
      id: '',
      name: '',
      address: '',
      tel: '',
      parkingLot: <ParkingLot>[],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now());
  ParkingLot parkinglot = ParkingLot(
    id: '',
    used: true,
    carNo: '',
    carName: '',
    carOwner: '',
    lotNo: 0,
    contractDate: DateTime.now(),
    cancelDate: null,
    contractType: 'person',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  @override
  void initState() {
    super.initState();
    _contractorController.text = widget.selectedParking.contractor;
    _carNoController.text = widget.selectedParking.carNo;
    _carNameController.text = widget.selectedParking.carName;
    _carOwnerController.text = widget.selectedParking.carOwner;
    // print('キャンセル処理　initState');
    // print('区画情報　契約者：${widget.selectedParking.contractor}');
    // print('区画情報　契約者ID:${widget.selectedParking.contractorId}');
    // print('区画情報　区画番号：${widget.selectedParking.lotNo}');

    widget.contracts.forEach((element) {
      if (element.id == widget.selectedParking.contractorId) {
        print('+++++++++++++');
        print('契約者　id：${element.id}');
        print('契約者　name：${element.name}');
        contract = Contract(
            id: element.id,
            name: element.name,
            address: element.address,
            tel: element.tel,
            parkingLot: element.parkingLot,
            createdAt: element.createdAt,
            updatedAt: element.updatedAt);

        element.parkingLot!.forEach((element) {
          if (element.lotNo == widget.selectedParking.lotNo) {
            // print('---------------------');

            print('区画情報　区画番号：${element.lotNo}');
            print('契約者　lot：${element.lotNo}');
            print('契約者　carName：${element.carName}');
            print(
                '契約者　contractDate：${DateFormat('yyyy年M月d日').format(element.contractDate)}');
            print(element.cancelDate == null
                ? 'null'
                : '契約者　cancellDate：${DateFormat('yyyy年M月d日').format(element.cancelDate!)}');

            parkinglot = ParkingLot(
              id: element.id,
              used: element.used,
              carNo: element.carNo,
              carName: element.carName,
              carOwner: element.carOwner,
              lotNo: element.lotNo,
              contractDate: element.contractDate,
              cancelDate: element.cancelDate,
              contractType: element.contractType,
              createdAt: element.createdAt,
              updatedAt: element.updatedAt,
            );
          }
        });
      }
    });
    _contractDateController.text =
        DateFormat('yyyy年M月d日').format(parkinglot.contractDate);
    print('init set contract');
    print('init contract.id: ${contract.id}');
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
                          // hintText: '契約日を入力してください',
                          // helperText: '必須'
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '契約日は必須です';
                          }
                          return null;
                        },
                      )),
                  // Expanded(
                  //     flex: 2,
                  //     child: ElevatedButton(
                  //       onPressed: () {
                  //         _selectDate(context);
                  //         _contractDateController = _pickedDateController;
                  //       },
                  //       child: const Text('契約日選択'),
                  //     ))
                ],
              ),
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
                        controller: _cancellDateController,
                        decoration: const InputDecoration(
                          labelText: '解約日',
                          // hintText: '解約日を入力してください',
                          // helperText: '必須'
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '解約日は必須です';
                          }
                          return null;
                        },
                      )),
                  Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        // onPressed: () => _selectDate(context),
                        onPressed: () {
                          _selectDate(context);
                          _cancellDateController = _pickedDateController;
                        },
                        child: const Text('解約日選択'),
                      ))
                ],
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton.extended(
                    onPressed: () {
                      print('FloatingActionButton');
                      print('FloatingActionButton contract.id: ${contract.id}');
                      if (_formKey.currentState!.validate()) {
                        //   print('cansel User');
                        //   print(widget.selectedParking.id);
                        //   print(widget.selectedParking.used ? 'true' : 'false');
                        //   print(widget.selectedParking.contractor);
                        //   print(widget.selectedParking.contractorId);
                        //   print(widget.selectedParking.carNo);
                        //   print(widget.selectedParking.carName);
                        //   print(widget.selectedParking.carOwner);
                        //   print(widget.selectedParking.lotNo);
                        //区画情報を更新
                        widget.cancelParking(Parking(
                          id: widget.selectedParking.id,
                          used: false,
                          contractor: "",
                          contractorId: "",
                          carNo: "",
                          carName: "",
                          lotNo: widget.selectedParking.lotNo,
                          carOwner: "",
                          createdAt: widget.selectedParking.createdAt,
                          updatedAt: DateTime.now(),
                        ));
                        //契約者のキャンセル日を更新
                        // print(DateTime(_date.year, _date.month, _date.day,
                        //     _time.hour, _time.minute));
                        // parkinglot.cancelDate = DateTime(_date.year,
                        //     _date.month, _date.day, _time.hour, _time.minute);
                        // parkinglot.cancelDate =
                        //     DateTime.utc(2022, 03, 03, 12, 30, 00);

                        // List<ParkingLot> updateParkingLot =
                        //     contract.parkingLot!.map((e) {
                        //   if (e.lotNo == widget.selectedParking.lotNo) {
                        //     return parkinglot;
                        //   }
                        //   return e;
                        // }).toList();

                        // List<Contract> updateContracts =
                        //     widget.contracts.map((value) {
                        //   if (value.id == widget.selectedParking.contractorId) {
                        //     return Contract(
                        //         id: value.id,
                        //         name: value.name,
                        //         address: value.address,
                        //         tel: value.tel,
                        //         // parkingLot: value.parkingLot,
                        //         parkingLot: value.parkingLot!.map((e) {
                        //           if (e.lotNo == widget.selectedParking.lotNo) {
                        //             return parkinglot;
                        //           }
                        //           return e;
                        //         }).toList(),
                        //         createdAt: value.createdAt,
                        //         updatedAt: DateTime.now());
                        //   }
                        //   return value;
                        // }).toList();
                        // widget.updateContract(updateContracts);
                        print('cancelContract data create----!!');
                        print('user_cancel contract.id: ${contract.id}');
                        print('user_cancel contract.name: ${contract.name}');
                        Contract cancelContract = Contract(
                            id: contract.id,
                            name: contract.name,
                            address: contract.address,
                            tel: contract.tel,
                            parkingLot: contract.parkingLot!.map((e) {
                              if (e.lotNo == widget.selectedParking.lotNo) {
                                // return parkinglot;
                                return ParkingLot(
                                  id: e.id,
                                  used: false,
                                  carNo: e.carNo,
                                  carName: e.carName,
                                  carOwner: e.carOwner,
                                  lotNo: e.lotNo,
                                  contractDate: e.contractDate,
                                  cancelDate: DateTime(
                                      _date.year, _date.month, _date.day),
                                  //     DateTime.utc(2023, 03, 03, 12, 30, 00),
                                  // cancelDate: DateTime.now(),
                                  contractType: e.contractType,
                                  createdAt: e.createdAt,
                                  updatedAt: DateTime.now(),
                                );
                              }
                              return e;
                            }).toList(),
                            createdAt: contract.createdAt,
                            // updatedAt: DateTime.now());
                            updatedAt: DateTime.utc(2023, 02, 17, 12, 30, 00));
                        // print('updateCancelDate');
                        widget.updateCancelDate(cancelContract);
                        Navigator.of(context).pushNamed('/parking_lot_list');
                      }
                    },
                    label: const Text('解約', style: TextStyle(fontSize: 12)),
                    icon: const Icon(Icons.block),
                    backgroundColor: Colors.blue,
                  )
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
        ));
  }
}
