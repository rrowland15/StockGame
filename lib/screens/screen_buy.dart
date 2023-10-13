import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:my_stock_game/data/companynames.dart';
import 'package:my_stock_game/data/stock_dictionary.dart';
import 'package:my_stock_game/components/suggestionclass.dart';
import 'package:my_stock_game/screens/screen_loading.dart';
import 'package:my_stock_game/components/mypadding.dart';
import 'screen_loading3.dart';
import 'package:my_stock_game/models/purchase_stock.dart';
import 'package:my_stock_game/constants.dart';
import 'package:my_stock_game/models/fetch_ticker.dart';

//good
class CustomBuy extends StatefulWidget {
  static const String id = 'buy';
  CustomBuy({this.suggestions});
  final suggestions;

  @override
  State<StatefulWidget> createState() => _CustomBuyState();
}

//extension
class _CustomBuyState extends State<CustomBuy> {
  List<ArbitrarySuggestionType>? suggestions;
  late List<ArbitrarySuggestionType> displaysuggestions;
  late num shares;
  num price = 2;
  bool updatedprice = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("init");
    updateUI(widget.suggestions);
    _CustomBuyState2();
  }

  GlobalKey<AutoCompleteTextFieldState<ArbitrarySuggestionType>> key =
      GlobalKey<AutoCompleteTextFieldState<ArbitrarySuggestionType>>();

  AutoCompleteTextField<ArbitrarySuggestionType>? textField;

  ArbitrarySuggestionType? selected;

  _CustomBuyState2() {
    textField = AutoCompleteTextField<ArbitrarySuggestionType>(
      decoration: InputDecoration(
          hintText: "Search Companies:", suffixIcon: Icon(Icons.search)),
      itemSubmitted: (item) => setState(() => selected = item),
      key: key,
      suggestions: displaysuggestions,
      itemBuilder: (context, suggestion) => Padding(
          child: ListTile(
              title: Text(suggestion.name),
              trailing: Text("ticker: ${suggestion.ticker}")),
          padding: EdgeInsets.all(8.0)),
      itemSorter: (a, b) => a.marketcap == b.marketcap
          ? 0
          : a.marketcap > b.marketcap
              ? -1
              : 1,
      itemFilter: (suggestion, input) =>
          suggestion.name.toLowerCase().startsWith(input.toLowerCase()),
    );
  }

  Future<void> priceState() async {
    num new_price = await getStock(selected!.ticker);
    print(new_price);
    setState(() {
      price = new_price;
      print("finished set state");
    });
  }

  void updateUI(dynamic suggestions) {
    print("hit updateUI");
    setState(() {
      if (suggestions == null) {
        print("mysug ${suggestions}");
        displaysuggestions = [
          ArbitrarySuggestionType(
              "RRR", "ryan", 10000, "Cat Care", "Nail Trimming")
        ];
        return;
      }
      displaysuggestions = suggestions;
      print("displaysuginitialized");
      _CustomBuyState;
    });
  }

  checkDisp(sug) {
    for (var inst in sug) {
      print(inst.name);
    }
  }

  setChosen(selected) {
    String chosen = selected.name;
  }

  //@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sell2'),
      ),
      body: Column(children: [
        Padding(
            child: Container(child: textField), padding: EdgeInsets.all(16.0)),
        Padding(
            padding: EdgeInsets.fromLTRB(10.0, 64.0, 10.0, 0.0),
            child: Card(
                child: selected != null
                    ? Column(children: [
                        ListTile(
                            title: Text(selected!.name),
                            trailing: Text("Ticker: ${selected!.ticker}")),
                        Container(
                            child: Text(
                                "MarketCap: ${(selected!.marketcap / 1000000).round()} MM")),
                        Container(
                            child: Text("Industry: ${selected!.industry}")),
                        Container(child: Text("Sector: ${selected!.sector}")),
                      ])
                    : Icon(Icons.cancel))),
        Padding(
            padding: EdgeInsets.fromLTRB(10.0, 64.0, 10.0, 0.0),
            child: price == 2
                ? Column(children: [
                    Container(child: Text("PPS: ${priceState()}")),
                  ])
                : Column(children: [
                    Container(child: Text("PPS: ${price}")),
                  ])),

        TextField(
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          onChanged: (number) {
            shares = int.parse(number);
          },
          decoration:
              kInputBoxDecoration.copyWith(hintText: "Enter number of shares"),
        ),
        //Card(child: selected!= null ?
        //Text("${getStock(selected!.ticker)}"):),
        MyPadding(
            myString: "Buy",
            //myPressed: () {Navigator.pushNamed(context, LoadingScreen3.id);},
            //myPressed: () {},
            //myPressed: () => {print(selected!.name)},
            myPressed: () => {
                  purchasestock(
                    context,
                    selected!,
                    shares!,
                    price!,
                  )
                },
            myColor: Colors.blue)
      ]),
    );
  }
}
