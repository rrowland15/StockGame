import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

// class StockModel {
//   StockModel({required this.ticker});
//   final String ticker;

Future<dynamic> getStock(ticker) async {
  final _db = FirebaseFirestore.instance;
  Uri myurl = Uri(
      scheme: 'https',
      host: 'mboum-finance.p.rapidapi.com',
      path: 'qu/quote',
      queryParameters: {'symbol': ticker});

  http.Response response = await http.get(myurl, headers: {
    "X-RapidAPI-Key": "2b5f70e04fmsh2e7f729ba4f2704p115ec6jsndb4e0c77d89b",
    "X-RapidAPI-Host": "mboum-finance.p.rapidapi.com",
  });
  //var responseArray = JsonDecoder(response.body);
  final data = json.decode(response.body);

  _db.collection('stockdata').add({'ticker': ticker, 'pps': data[0]['ask']});

  return data[0]
      ['ask']; //returns ask value for stock (other items available in data)
}

//val client = OkHttpClient()

// val request = Request.Builder()
//     .url("https://mboum-finance.p.rapidapi.com/qu/quote?symbol=AAPL%2CMSFT%2C%5ESPX%2C%5ENYA%2CGAZP.ME%2CSIBN.ME%2CGEECEE.NS")
//     .get()
//     .addHeader("X-RapidAPI-Key", "2b5f70e04fmsh2e7f729ba4f2704p115ec6jsndb4e0c77d89b")
//     .addHeader("X-RapidAPI-Host", "mboum-finance.p.rapidapi.com")
//     .build()
//
// val response = client.newCall(request).execute()
