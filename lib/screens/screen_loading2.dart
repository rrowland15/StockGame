import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_stock_game/components/suggestionclass.dart';
import 'package:my_stock_game/data/stock_dictionary.dart';
import 'screen_buy.dart';

final _auth = FirebaseAuth.instance;

class LoadingScreen2 extends StatefulWidget {
  static const String id = '/loading2';
  @override
  _LoadingScreenState2 createState() => _LoadingScreenState2();
}

class _LoadingScreenState2 extends State<LoadingScreen2> {
  @override
  void initState() {
    //async {
    super.initState();
    //final email = await getCurrentUser();
    gettopage();
  }

  mapkeyvalues(suggestions, key, value) async {
    await suggestions.add(ArbitrarySuggestionType(
        value[0], key, double.parse(value[1]), value[2], value[3]));
  }

  myFunction(map) async {
    print("made it here");
    List<ArbitrarySuggestionType> suggestions = [];
    for (var entry in map.entries) {
      await mapkeyvalues(suggestions, entry.key, entry.value);
    }
    return suggestions;
  }

  getStockDictionaryData() async {
    print("in gertstockdictionarydata");
    final map = returnstockdict();

    // myFunction(map, suggestions) async {
    //   for (var entry in map.entries) {
    //     await mapkeyvalues(suggestions, entry.key, entry.value);
    //   }
    // }

    //print(suggestions);

    List<ArbitrarySuggestionType> suggestions = await myFunction(map);
    //print(suggestions);
    print("exited");
    //print(suggestions);
    //print(suggestions.runtimeType);
    return suggestions;
  }

  gettopage() async {
    print("start of call");
    List<ArbitrarySuggestionType> suggestions = await getStockDictionaryData();
    print("why no come back");
    print(suggestions);
    if (suggestions != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return CustomBuy(suggestions: suggestions);
      }));
    }
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
