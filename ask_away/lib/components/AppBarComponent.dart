import 'package:flutter/material.dart';

import 'UserIcon.dart';

AppBarComponent(GlobalKey<ScaffoldState> _drawerKey) {
  return AppBar(
    toolbarHeight: 100,
    leading: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: new IconButton(
        icon: new Icon(
          Icons.menu,
          size: 40,
          color: Colors.black,
        ),
        onPressed: () => {_drawerKey.currentState.openDrawer()},
      ),
    ),
    backgroundColor: Color(0xFFE5E5E5),
    elevation: 0.0,
    actions: [
      Padding(
          padding: const EdgeInsets.only(
            top: 20,
            right: 10,
          ),
          child: UserIcon()),
    ],
  );
}
