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
String convertTo = 'AUD';
bool fetchedDataMap = true;
List currencyList = ['USD', 'INR', 'AUD'];
NetworkHelper fetchUrlFromValues =
    NetworkHelper(fromCurrency: convertFrom, toCurrency: convertTo);

Map latestDataMap;
final List<DropdownMenuItem<String>> currenciesList = [
  DropdownMenuItem(
    child: Text(
        'USD'), // this is what user will see in the list, like variable value which user interacts with
    value: 'USD', //value is sort of like index, like variable name
  ),
  DropdownMenuItem(child: Text('AUD'), value: 'AUD'),
  DropdownMenuItem(child: Text('INR'), value: 'INR')
];

class _CurrencyExchangeState extends State<CurrencyExchange> {
  @override
  void initState() {
    String fetchedURL = fetchUrlFromValues.url;
    print(fetchedURL);
    // TODO: implement initState
    super.initState();
  }

  void fetchLatestDataMap() async {
    print('will try to fetch news');
    fetchUrlFromValues =
        NetworkHelper(fromCurrency: convertFrom, toCurrency: convertTo);
    latestDataMap = await fetchUrlFromValues.fetchDataMapFromUrl();
    fetchedDataMap = true;
    setState(() {});
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
                      Text('1'),
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
                          print('from $selectedCurrency');

                          print('url now is ${fetchUrlFromValues.url}');
                          setState(() {});
                        },
                        items: currenciesList,
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
                          print('to $selectedCurrency');
                          fetchUrlFromValues = NetworkHelper(
                              fromCurrency: convertFrom, toCurrency: convertTo);
                          print('url now is ${fetchUrlFromValues.url}');
                          setState(() {});
                        },
                        items: currenciesList,
                        value: convertFrom,
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
