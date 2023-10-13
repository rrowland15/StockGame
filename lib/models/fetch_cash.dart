import 'package:cloud_firestore/cloud_firestore.dart';

Future<dynamic> getCash(email) async {
  print("function called");
  var document = await FirebaseFirestore.instance.collection(email).get();
  if (document.docs.isNotEmpty) {
    final thingsJson = document.docs.map((doc) => doc.data()).toList();
    final val = thingsJson[0]['dollars'];
    final val2 = val.toStringAsFixed(2); //round the value to 2 decimal places
    return val2;
  }
  ;
}
