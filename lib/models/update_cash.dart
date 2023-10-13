import 'package:cloud_firestore/cloud_firestore.dart';

Future<dynamic> updateCash(email, newCash) async {
  print("function called");
  var document = await FirebaseFirestore.instance.collection(email).get();
  if (document.docs.isNotEmpty)
    await document.docs[0].reference.update({'dollars': newCash});
}
