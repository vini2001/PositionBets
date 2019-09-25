import 'package:flutter/material.dart';

import 'BettingScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Position Bets',
      theme: ThemeData(
        fontFamily: 'Raleway',
        primarySwatch: Colors.blueGrey,
      ),
      home: BettingScreen(),
    );
  }
}
