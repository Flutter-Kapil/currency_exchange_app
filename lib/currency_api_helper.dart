import 'dart:convert';
import 'package:http/http.dart';

class NetworkHelper {
  String url;
  String fromCurrency;
  String toCurrency;

  NetworkHelper({String fromCurrency, String toCurrency}) {
    this.fromCurrency = fromCurrency;
    this.toCurrency = toCurrency;
    this.url = 'https://api.exchangeratesapi.io/latest';
  }

  Future<Map> fetchDataMapFromUrl() async {
    print('url here is $url');
    Response response = await get(url);
    if (response.statusCode == 200) {
      print("response 200");
    }
    Map<String, dynamic> currencyComaparedMap = jsonDecode(response.body);
    return currencyComaparedMap;
  }
}

class CurrencyDataMap {
  String url = 'https://api.exchangeratesapi.io/latest';

  Future<Map> latestMap() async {
    Response response = await get(url);
    if (response.statusCode == 200) {
      print("response 200");
    }
    Map<String, dynamic> allCurrenciesMap = jsonDecode(response.body);
    return allCurrenciesMap;
  }
}
