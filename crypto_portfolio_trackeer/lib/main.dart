// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import 'dart:convert';

import 'package:crypto_portfolio_trackeer/Text%20Names/titles.dart';
import 'package:crypto_portfolio_trackeer/Theme%20Data/themeData.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

void main() {
  // WidgetsFlutterBinding.ensureInitialized();

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
  List<dynamic>? data;

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void fetchData() async {
    data = await getCurrencies();

    setState(() {});
  }

  Future<List<dynamic>> getCurrencies() async {
    Uri apiUrl = Uri.parse(
        'https://sandbox-api.coinmarketcap.com/v1/cryptocurrency/listings/latest');
    http.Response response = await http.get(apiUrl, headers: {
      'Accepts': 'application/json',
      'X-CMC_PRO_API_KEY': '91da6e09-c276-4460-8ae2-d79f70b59975'
    });

    Map<String, dynamic> map = json.decode(response.body);

    return map['data'];
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
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: Column(
              children: [
                SizedBox(
                    height: 120,
                    child: Row(
                      children: [Text('Name'), Text('USD'), Text('BTC')],
                    )),
                SizedBox(
                  height: 40,
                ),
                Expanded(
                  child: data != null
                      ? ListView.builder(
                          itemCount: data!.length,
                          itemBuilder: ((context, index) {
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Text(data![index]['name']),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Text(data![index]['symbol']),
                                  ],
                                )
                              ],
                            );

                            // return ListTile(title: Text(data![index]));
                          }))
                      : const CircularProgressIndicator(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
