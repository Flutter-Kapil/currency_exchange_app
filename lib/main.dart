import 'package:flutter/material.dart';
import 'currency_api_helper.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      canvasColor: Colors.blueGrey,
      appBarTheme: AppBarTheme(color: Colors.black),
      textTheme: TextTheme(
        headline: TextStyle(fontSize: 68.0, color: Colors.red),
        title: TextStyle(
          fontSize: 22.0,
        ),
        body1: TextStyle(
          fontSize: 14.0,
        ),
      ),
    ),
    home: CurrencyExchange(),
  ));
}

class CurrencyExchange extends StatefulWidget {
  @override
  _CurrencyExchangeState createState() => _CurrencyExchangeState();
}

String convertFrom = 'USD';
String convertTo = 'USD';
List<String> currencyList = ['USD'];

CurrencyDataMap currentData = CurrencyDataMap();
Map latestDataMap;
String result = '1';

class _CurrencyExchangeState extends State<CurrencyExchange> {
  @override
  void initState() {
    fetchLatestDataMap();
    super.initState();
  }

  void fetchLatestDataMap() async {
    latestDataMap = await currentData.latestMap();
    //now lets automate all the values of drop down menu
    List<String> x = populateButtonList(latestDataMap);
    currencyList = x;
    print('network call made and button list updated');
    setState(() {});
  }

  List<String> populateButtonList(Map x) {
    Map subMap = x['rates'];
    return subMap.keys.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Exchange Rates',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '1',
                          style: Theme.of(context).textTheme.headline,
                        ),
                        Text(
                          convertFrom,
                          style: Theme.of(context).textTheme.headline,
                        ),
                      ],
                    ),
                    Text(
                      '=',
                      style: Theme.of(context).textTheme.headline,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          result,
                          style: Theme.of(context).textTheme.headline,
                        ),
                        Text(
                          convertTo,
                          style: Theme.of(context).textTheme.headline,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.only(top: 10),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('From', style: Theme.of(context).textTheme.title),
                        //covert from selected currency
                        DropdownButton(
                          elevation: 5,
                          onChanged: (selectedCurrency) {
                            convertFrom = selectedCurrency;
                            result = (latestDataMap['rates'][convertTo] /
                                    latestDataMap['rates'][convertFrom])
                                .toStringAsFixed(2);
                            setState(() {});
                          },
                          items: currencyList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text("        $value     "),
                            );
                          }).toList(),
                          value: convertFrom,
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('To', style: Theme.of(context).textTheme.title),
                        //covert to  selected currency
                        DropdownButton(
                          iconSize: 30,
                          elevation: 5,
                          onChanged: (selectedCurrency) {
                            convertTo = selectedCurrency;
                            result = (latestDataMap['rates'][convertTo] /
                                    latestDataMap['rates'][convertFrom])
                                .toStringAsFixed(2);
                            setState(() {});
                          },
                          items: currencyList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text("        $value     "),
                            );
                          }).toList(),
                          value: convertFrom,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
