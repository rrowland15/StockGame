import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_stock_game/models/fetch_cash.dart';
import 'package:my_stock_game/screens/screen_portfolio.dart';
import 'screen_portfolio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_stock_game/models/fetch_portvalue.dart';
import 'package:my_stock_game/components/suggestionclass.dart';

final _auth = FirebaseAuth.instance;

class LoadingScreen3 extends StatefulWidget {
  LoadingScreen3({this.selected});
  final selected;

  static const String id = '/loading3';
  @override
  _LoadingScreenState3 createState() => _LoadingScreenState3();
}

class _LoadingScreenState3 extends State<LoadingScreen3> {
  late String selected;

  @override
  void initState() {
    //async {
    super.initState();
    //final email = await getCurrentUser();
    getLocationData(selected);
  }

  getLocationData(selected) async {
    print(selected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}

// void initState() async {
//   super.initState();
//   final email = await getCurrentUser();
//   getLocationData(email);
// }
