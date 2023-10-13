import 'package:my_stock_game/components/suggestionclass.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_stock_game/models/fetch_portvalue.dart';
import 'package:flutter/material.dart';
import 'package:my_stock_game/models/update_cash.dart';
import 'package:my_stock_game/screens/screen_loading.dart';
import 'package:my_stock_game/screens/screen_portfolio.dart';

final _auth = FirebaseAuth.instance;

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

void purchasestock(context, selected, shares, price) async {
  late String? email;
  print(selected!.ticker);
  print(shares);
  email = await getCurrentUser();
  print(email);
  var document = await getDocument(email);
  if (document.docs.isNotEmpty) {
    final thingsJson = await document.docs.map((doc) => doc.data()).toList();
    await document.docs[0].reference.set({
      'portfolio': {
        "${selected!.ticker}": {
          "shares": shares,
          "purchase_price": price,
          "last_ask": price
        },
      },
    }, SetOptions(merge: true));
    var cash = thingsJson[0]['dollars'];
    var newcash = cash - (shares * price);
    await updateCash(email, newcash);
    Navigator.pushNamed(context, LoadingScreen.id);
  }
}

///: {"shares": shares, "purchase_price": price, "last_ask": price}
