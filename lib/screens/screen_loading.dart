import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_stock_game/models/fetch_cash.dart';
import 'package:my_stock_game/screens/screen_portfolio.dart';
import 'screen_portfolio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_stock_game/models/fetch_portvalue.dart';
import 'package:my_stock_game/components/suggestionclass.dart';

final _auth = FirebaseAuth.instance;

class LoadingScreen extends StatefulWidget {
  static const String id = '/loading';
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    //async {
    super.initState();
    //final email = await getCurrentUser();
    getLocationData();
  }

  Future<String?> getCurrentUser() async {
    print("Into function");
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        final useremail = await user.email;
        return useremail.toString();
      }
    } catch (Exc) {
      print(Exc);
    }
  }

  getLocationData() async {
    final email = await getCurrentUser();
    print(email);
    var userCash = await getCash(email);
    var userPortValue = await getPortValue(email);
    print("userportvalue${userPortValue}");
    if (userPortValue != 0.0) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return PortfolioScreen(
            userCash: userCash, userPortvalue: userPortValue);
      }));
    }
    ;
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
