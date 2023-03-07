import 'package:flutter/material.dart';

class AppBarBottom extends StatelessWidget {
  const AppBarBottom(
      {
      //   required this.homeState,
      // required this.setHomeState,
      // required this.activityState,
      // required this.setActivityState,
      Key? key})
      : super(key: key);
  // final HomeState homeState;
  // final void Function(HomeState status) setHomeState;
  // final ActivityState activityState;
  // final void Function(ActivityState status) setActivityState;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.blue[600],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            tooltip: 'Home',
            icon: const Icon(
              Icons.home,
              color: Colors.white,
            ),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) {
              //       return HomePage();
              //     },
              //   ),
              // );
              // setHomeState(HomeState.display);
              Navigator.of(context).pushNamed('/home');
            },
          ),
          IconButton(
            tooltip: 'arrengment',
            icon: const Icon(
              Icons.grid_view,
              color: Colors.white,
            ),
            onPressed: () {
              // setActivityState(ActivityState.display);
              Navigator.of(context).pushNamed('/arrangement');
            },
          ),
          IconButton(
            tooltip: 'Lot',
            icon: const Icon(
              Icons.list,
              color: Colors.white,
            ),
            onPressed: () {
              // setActivityState(ActivityState.display);
              Navigator.of(context).pushNamed('/parking_lot_list');
            },
          ),
          IconButton(
            tooltip: 'Contract',
            icon: const Icon(
              // Icons.settings,
              Icons.person,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/contractor_list');
            },
          ),
        ],
      ),
    );
  }
}
