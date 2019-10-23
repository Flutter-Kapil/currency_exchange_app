import 'package:flutter/material.dart';
import 'currency_api_helper.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      appBarTheme: AppBarTheme(color: Colors.white),
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
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.black,
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
                    SizedBox(
                      width: 40,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('From',
                              style: Theme.of(context).textTheme.title),
                          //covert from selected currency
                          Platform.isAndroid?Container(
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0))),
                            child: androidDropdownFromButton(),
                          ):myIOsPickerFrom()
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('To', style: Theme.of(context).textTheme.title),
                          //covert to  selected currency
                          Platform.isAndroid?Container(
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0))),
                            child: androidDropdownToButton(),
                          ):myIOsPickerTo()
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  DropdownButton<String> androidDropdownFromButton() {
    return DropdownButton(
      isExpanded: true,
      elevation: 5,
      onChanged: (selectedCurrency) {
        convertFrom = selectedCurrency;
        result = (latestDataMap['rates'][convertTo] /
                latestDataMap['rates'][convertFrom])
            .toStringAsFixed(2);
        setState(() {});
      },
      items: currencyList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text("            $value  "),
        );
      }).toList(),
      value: convertFrom,
    );
  }

    DropdownButton<String> androidDropdownToButton() {
    return DropdownButton(
      isExpanded: true,
      elevation: 5,
      onChanged: (selectedCurrency) {
        convertFrom = selectedCurrency;
        result = (latestDataMap['rates'][convertTo] /
                latestDataMap['rates'][convertFrom])
            .toStringAsFixed(2);
        setState(() {});
      },
      items: currencyList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text("            $value  "),
        );
      }).toList(),
      value: convertTo,
    );
  }


Widget myIOsPickerTo(){
  return CupertinoPicker.builder(
    itemExtent:40,
    childCount: currencyList.length,
    itemBuilder: (context,index){
      print("index in IOS picker is $index");
      return Text(currencyList[index]);
    }, onSelectedItemChanged:(index) {
                                convertTo = currencyList[index];
                                result = (latestDataMap['rates'][convertTo] /
                                        latestDataMap['rates'][convertFrom])
                                    .toStringAsFixed(2);
                                setState(() {});
                              },
  );
}

Widget myIOsPickerFrom(){
  return CupertinoPicker.builder(
    itemExtent:40,
    childCount: currencyList.length,
    itemBuilder: (context,index){
      print("index in IOS picker is $index");
      return Text(currencyList[index]);
    }, onSelectedItemChanged:(index) {
                                convertFrom = currencyList[index];
                                result = (latestDataMap['rates'][convertTo] /
                                        latestDataMap['rates'][convertFrom])
                                    .toStringAsFixed(2);
                                setState(() {});
                              },
  );
}




}
