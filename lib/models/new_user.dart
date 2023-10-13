import 'package:cloud_firestore/cloud_firestore.dart';

Future<dynamic> createNewUser(email) async {
  FirebaseFirestore.instance.collection(email).add({
    "dollars": 1000,
    "email": email,
    "portfolio": {
      "AAPL": {"shares": 2, "purchase_price": 100, "last_ask": 200},
      "GOOGL": {"shares": 1, "purchase_price": 200, "last_ask": 200},
    },
    "presentvalue": 0,
    "presenttime": DateTime.now(),
    "historicvalue": [],
    "historicvaluetime": []
  });
}
