import 'package:flutter/material.dart';
import 'currency_api_helper.dart';

void main() {
  runApp(MaterialApp(
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
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('1'),
                      Text(convertFrom),
                    ],
                  ),
                  Text('='),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(result),
                      Text(convertTo),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('From'),
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
                            child: Text(value),
                          );
                        }).toList(),
                        value: convertFrom,
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('To'),
                      //covert to  selected currency
                      DropdownButton(
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
                            child: Text(value),
                          );
                        }).toList(),
                        value: convertFrom,
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
