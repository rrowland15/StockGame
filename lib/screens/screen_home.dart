import 'package:my_stock_game/screens/screen_loading2.dart';
import 'package:my_stock_game/screens/screen_portfolio.dart';
import 'screen_login.dart';
import 'screen_register.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:my_stock_game/components/mypadding.dart';
import 'package:my_stock_game/screens/screen_buy.dart';
import 'screen_loading2.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = '/home';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFf2e8cf),
      padding: EdgeInsets.only(left: 20, top: 80.0, right: 20, bottom: 80),
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(controller.value),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('images/stockgame_icon.png'),
                      height: 60.0,
                    ),
                  ),
                  Expanded(
                    child: WavyAnimatedTextKit(
                      speed: Duration(milliseconds: 800),
                      text: ['Trade Tycoon'],
                      textStyle: TextStyle(
                        color: Color(0xFFbc4749),
                        fontSize: 35.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 48.0,
              ),
              MyPadding(
                myColor: Color(0xFF6a994e),
                myPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                myString: 'Login',
              ),
              MyPadding(
                myPressed: () {
                  Navigator.pushNamed(context, RegisterScreen.id);
                },
                myColor: Color(0xFFa7c957),
                myString: 'Register',
              ),
              MyPadding(
                myPressed: () {
                  Navigator.pushNamed(context, LoadingScreen2.id);
                },
                myColor: Color(0xFFa7c957),
                myString: 'Sell',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
