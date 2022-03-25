import 'dart:convert';
import 'dart:ui';

import 'package:crypto_portfolio_trackeer/Text%20Names/titles.dart';
import 'package:crypto_portfolio_trackeer/Theme%20Data/themeData.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: Main(),
    debugShowCheckedModeBanner: false,
    theme: brightThemeData,
  ));
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  Uri url = Uri.parse('');
  var data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var x = getCurrencies();

    // Map<String, dynamic> myMap = Map<String, dynamic>.from(x);

    // print(x);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void fetchData() async {
    // var res = await http.get(url);
    // data = jsonDecode(res.body);
    setState(() {});
  }

  Future<List> getCurrencies() async {
    Uri apiUrl = Uri.parse(
        'https://sandbox-api.coinmarketcap.com/v1/cryptocurrency/listings/latest');
    // Make a HTTP GET request to the CoinMarketCap API.
    // Await basically pauses execution until the get() function returns a Response
    http.Response response = await http.get(apiUrl, headers: {
      'Accepts': 'application/json',
      'X-CMC_PRO_API_KEY': '91da6e09-c276-4460-8ae2-d79f70b59975'
    });
    // Using the JSON class to decode the JSON String

    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map['data'];
    var x=data[0]["name"];
    print(x);
    return jsonDecode(response.body );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(APP_BAR_TITLE,
            style: GoogleFonts.getFont('Bitter',
                textStyle: TextStyle(
                  color: Colors.black,
                  // fontWeight: FontWeight.bold,
                  fontSize: 30,
                ))),
        backgroundColor: Colors.red,
        centerTitle: true,
        toolbarHeight: 50,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
            child: Column(
          children: [
            SizedBox(height: 30),
            CircleAvatar(),
            SizedBox(
              height: 30,
            ),
            CircularProgressIndicator()
          ],
        )),
      ),
    );
  }
}
