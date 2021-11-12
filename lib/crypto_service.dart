import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_course_bitcoin_ticker/api_keys.dart';
import 'package:flutter_course_bitcoin_ticker/crypto_exchange.dart';

class CryptoService {
  static Future<CryptoExchange?> getExchangeRate({required String cryptoCurrency, required String realCurrency}) async {
    try {
      Uri coinUri =
          Uri.https('rest.coinapi.io', 'v1/exchangerate/$cryptoCurrency/$realCurrency', {'apikey': kCoinApiKey});
      print(coinUri.toString());
      http.Response response = await http.get(coinUri);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return CryptoExchange.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Crypto web service call failed');
      }
    } catch (e) {
      print('Unable to get crypto exchange rate:');
      print(e);
      return null;
    }
  }
}
