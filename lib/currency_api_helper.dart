import 'dart:convert';
import 'package:http/http.dart';

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
