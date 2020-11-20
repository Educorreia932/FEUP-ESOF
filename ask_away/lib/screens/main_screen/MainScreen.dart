import 'package:ask_away/components/AppBarComponent.dart';
import 'package:ask_away/components/SimpleButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'components/DrawerComponent.dart';

GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: DrawerComponent(),
      appBar: AppBarComponent(_drawerKey),
      body: Container(
        color: Color(0xFFE5E5E5),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 40,
                  right: 40,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ask Away",
                      style: TextStyle(
                        fontSize: 55,
                      ),
                    ),
                    Text(
                      "Every great answer starts with a great question.",
                      style: TextStyle(
                        color: Color(0xFF9A9A9A),
                        fontSize: 35,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 50,
                          bottom: 70,
                          left: 20,
                          right: 20,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image(
                              image: AssetImage('assets/images/logo.png'),
                            ),
                            SimpleButton("Find talk")
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


