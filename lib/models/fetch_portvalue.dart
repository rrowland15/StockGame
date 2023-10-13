import 'package:cloud_firestore/cloud_firestore.dart';
import 'fetch_ticker.dart';

Future<dynamic> getDocument(email) async {
  var document = await FirebaseFirestore.instance.collection(email).get();
  return document;
}

// try removing return statment althogether. await in the previous call should
//ensure that the function completes
myAsyncFunction(sum, document, key, value) async {
  // this async allows us to hit return statement before
  final updatedprice = await getStock(key);
  final map2 = value; // all things under stock ticker
  final purchase_price = map2["purchase_price"];
  final shares = map2["shares"];
  sum += updatedprice * shares;
  print("myportval");
  print("${key}${sum}");
  await document.docs[0].reference
      .update({'portfolio.$key.last_ask': updatedprice});
  await document.docs[0].reference.update({'presentvalue': sum});
  return sum;
}

update(thingsJson, document) async {
  final val = thingsJson[0]['presentvalue']; //present portfolio value
  final map = thingsJson[0]['portfolio']; //
  print(map);

  myFunction(document, map) async {
    num sum = 0.0;
    for (var entry in map.entries) {
      sum = await myAsyncFunction(sum, document, entry.key, entry.value);
      print("{sumaccum${sum}");
    }
    return sum;

    //print("returnsum $sum");
    // return sum;
  }

  num sum = await myFunction(document, map);
  return sum;
}

updatehistoric(sum, document) {
  document.docs[0].reference.set({
    "historicvalue": FieldValue.arrayUnion([sum])
  }, SetOptions(merge: true));
}

getPortValue(email) async {
  num portval = 0.0;
  print("function called");

  // get my document
  var document = await getDocument(email);

  // once I have my document
  if (document.docs.isNotEmpty) {
    final thingsJson = await document.docs.map((doc) => doc.data()).toList();
    //Historize time (working correctly, present time being pushed into history as well as presenttime field)
    final time = thingsJson[0]['presenttime'];
    await document.docs[0].reference.set({
      "historicvaluetime": FieldValue.arrayUnion([DateTime.now()])
    }, SetOptions(merge: true));
    await document.docs[0].reference.update({"presenttime": DateTime.now()});
    //Update stock ticker and present value
    num sum = await update(thingsJson, document);
    print("finished update function");
    await updatehistoric(sum, document);
    print("finalsum${sum}");
    final sum2 = sum.toStringAsFixed(2); // round it to 2 digits
    return sum2;
  } else {
    return portval;
  }
}

// Future<dynamic> getPortValue(email)  {
//   num portval = 0.0;
//   print("function called");
//   var document = await FirebaseFirestore.instance.collection(email).get();
//   if (document.docs.isNotEmpty)  {
//   };final thingsJson = document.docs.map((doc) => doc.data()).toList();
//   final val = thingsJson[0]['presentvalue'];
//   final map = thingsJson[0]['portfolio'];
//   map.forEach((k, v) async {
//     final updatedprice = await getStock(k);
//     final map2 = v;
//     final purchase_price = map2["purchase_price"];
//     final shares = map2["shares"];
//     portval += updatedprice * shares;
//     print("myportval");
//     print(portval);
//     document.docs[0].reference.update({
//       'portfolio': {
//         k: {
//           "last ask": updatedprice,
//           "purchase_price": purchase_price,
//           "shares": shares
//         }
//       }
//     });
//   });
//
//   print("return $portval");
// }
// }

// update(thingsJson, document) async {
//   num sum = 0.0;
//   final val = thingsJson[0]['presentvalue']; //present portfolio value
//   final map = thingsJson[0]['portfolio']; //
//   map.forEach((k, v) async {
//     // this async allows us to hit return statement before
//     final updatedprice = await getStock(k);
//     final map2 = v; // all things under stock ticker
//     final purchase_price = map2["purchase_price"];
//     final shares = map2["shares"];
//     sum += updatedprice * shares;
//     print("myportval");
//     print(sum);
//     document.docs[0].reference.update({
//       'portfolio.': {
//         '$k': {
//           "last ask": updatedprice,
//           "purchase_price": purchase_price,
//           "shares": shares
//         }
//       }
//     });
//     document.docs[0].reference.update({'presentvalue': sum});
//   });
//
//   print("returnsum $sum");
//   return sum;
// }

// update(thingsJson, document) async {
//   num sum = 0.0;
//   final val = thingsJson[0]['presentvalue']; //present portfolio value
//   final map = thingsJson[0]['portfolio']; //
//   await map.forEach((k, v) async {
//     // this async allows us to hit return statement before
//     final updatedprice = await getStock(k);
//     final map2 = v; // all things under stock ticker
//     final purchase_price = map2["purchase_price"];
//     final shares = map2["shares"];
//     sum += updatedprice * shares;
//     print("myportval");
//     print(sum);
//     await document.docs[0].reference
//         .update({'portfolio.$k.last_ask': updatedprice});
//     await document.docs[0].reference.update({'presentvalue': sum});
//   });
