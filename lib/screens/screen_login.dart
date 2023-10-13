import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:my_stock_game/constants.dart';
import 'package:my_stock_game/screens/screen_loading.dart';
import 'package:my_stock_game/screens/screen_portfolio.dart';
import 'package:my_stock_game/components/mypadding.dart';

class LoginScreen extends StatefulWidget {
  static const String id = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner = false;

  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFf2e8cf),
      padding: EdgeInsets.only(left: 20, top: 80.0, right: 20, bottom: 80),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Flexible(
                        child: Hero(
                          tag: "logo",
                          child: Container(
                            height: 60.0,
                            child: Image.asset('images/stockgame_icon.png'),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Color(0xFFbc4749),
                            fontSize: 35.0,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kInputBoxDecoration.copyWith(
                      hintText: "Enter your email"),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: kInputBoxDecoration.copyWith(
                        hintText: "Enter your password")),
                SizedBox(
                  height: 24.0,
                ),
                MyPadding(
                  myColor: Color(0xFF6a994e),
                  myString: 'Login',
                  myPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      print(email);
                      print(password);
                      final newUser = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (newUser != null) {
                        Navigator.pushNamed(context, LoadingScreen.id);
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    } on FirebaseAuthException catch (e) {
                      print('Failed with error code: ${e.code}');
                      print(e.message);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
