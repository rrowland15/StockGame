import 'package:flutter/material.dart';
import 'screens/screen_home.dart';
import 'screens/screen_login.dart';
import 'package:my_stock_game/screens/screen_register.dart';
import 'package:my_stock_game/screens/screen_portfolio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_stock_game/screens/screen_loading.dart';
//import 'package:my_stock_game/screens/screen_sell.dart';
import 'screens/screen_buy.dart';
import 'package:my_stock_game/screens/screen_loading2.dart';
import 'screens/screen_loading3.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyStockGame());
}

class MyStockGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        PortfolioScreen.id: (context) => PortfolioScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoadingScreen.id: (context) => LoadingScreen(),
        CustomBuy.id: (context) => CustomBuy(),
        LoadingScreen2.id: (context) => LoadingScreen2(),
        LoadingScreen3.id: (context) => LoadingScreen3(),
        //SimpleTimeSeriesChart.id: (context) => SimpleTimeSeriesChart(),
      },
    );
  }
}

//386641
//6a994e
//a7c957
//f2e8cf
//bc4749
