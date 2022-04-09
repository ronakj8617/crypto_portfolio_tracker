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
                      children: [
                        Text('Name'),
                        SizedBox(
                          width: 100,
                        ),
                        Text('USD'),
                        SizedBox(
                          width: 100,
                        ),
                        Text('BTC'),
                        SizedBox(
                          width: 0,
                        ),
                      ],
                    )),
                SizedBox(
                  height: 40,
                ),
                Expanded(
                  child: data != null
                      ? ListView.builder(
                          itemCount: data!.length,
                          itemBuilder: ((context, index) {
                            List quote = data as List;
                            final quoteMap = quote.whereType<Map>();
                            var map;
                            if (quoteMap.iterator.moveNext() != null) {
                              quoteMap.forEach((element) {
                                // print('\n'+element.keys.iterator.current['id']);
                                print(element['quote']['USD']);
                                map = element['quote'];
                              });

                              // print(map);
                            }
                            //  print(map);
                            return map != null
                                ? Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(data![index]['name']),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Text(map['USD']['price'].toString()),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Text(map['BTC']['price'].toString()),
                                          SizedBox(
                                            width: 30,
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                : CircularProgressIndicator();

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
