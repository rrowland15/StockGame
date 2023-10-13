import 'package:flutter/material.dart';
import 'package:my_stock_game/components/mypadding.dart';
import 'package:my_stock_game/components/simple_line.dart';
import 'package:my_stock_game/models/fetch_portvalue.dart';
import 'package:my_stock_game/models/fetch_ticker.dart';
import 'package:my_stock_game/models/fetch_cash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_stock_game/models/update_cash.dart';
import 'package:my_stock_game/screens/screen_buy.dart';
import 'package:my_stock_game/screens/screen_loading2.dart';
import 'package:my_stock_game/screens/screen_sell.dart';

final _auth = FirebaseAuth.instance;

class PortfolioScreen extends StatefulWidget {
  static const String id = '/portfolio';
  PortfolioScreen({this.userCash, this.userPortvalue});

  final userCash;
  final userPortvalue;

  @override
  _PortfolioScreenState createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  //StockModel myTicker = StockModel(ticker: "AAPL");
  //late String stockMessage;
  String currentUserEmail = _auth.currentUser!.email!;
  String? displaycash;
  String? displayportvalue;
  String? userCash;
  String stockMessage = "blah";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.userCash, widget.userPortvalue);
  }

  void updateUI(dynamic userCash, dynamic userPortvalue) {
    setState(() {
      //updatePortfolio();
      if (userCash == null || userPortvalue == null) {
        displaycash = "Not here yet";
        displayportvalue = "Not here yet";
        //stockMessage = "Unable to get weather data";
        return;
      }
      displaycash = userCash.toString();
      displayportvalue = userPortvalue.toString();
      //stockMessage = myTicker[0]['ask'].toString();
    });
  }

  void printurl() {
    var httpsUri = Uri(
        scheme: 'https',
        host: 'dart.dev',
        path: '/guides/libraries/library-tour',
        fragment: 'numbers');
    print(httpsUri);
  }

  Widget build(BuildContext context) {
    return Container(
        color: Color(0xFFf2e8cf),
        padding: EdgeInsets.only(left: 20, top: 80.0, right: 20, bottom: 80),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Hero(
                        tag: 'logo',
                        child: Container(
                          child: Image.asset('images/stockgame_icon.png'),
                          height: 80.0,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Container(
                          child: Column(children: [
                            Text("Cash Available"),
                            Text(displaycash.toString())
                          ]),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Container(
                          child: Column(children: [
                            Text("Stock Value"),
                            Text(displayportvalue.toString())
                          ]),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  SizedBox(
                      width: 100,
                      height: 200,
                      child: SimpleTimeSeriesChart.withSampleData()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: MyPadding(
                          myColor: Color(0xFF6a994e),
                          myPressed: () {
                            Navigator.pushNamed(context, LoadingScreen2.id);
                          },
                          myString: 'Buy',
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: MyPadding(
                          myColor: Color(0xFFbc4749),
                          myPressed: () {
                            Navigator.pushNamed(context, LoadingScreen2.id);
                          },
                          myString: 'Sell',
                        ),
                      ),
                    ],
                  ),
                  Container(child: Text(stockMessage)),
                  FloatingActionButton(
                    onPressed: () async {
                      //var tickerData = await myTicker.getStock("GOOGL");
                      //updateUI(tickerData);
                    },
                  )
                ]),
          ),
        ));
  }
}
