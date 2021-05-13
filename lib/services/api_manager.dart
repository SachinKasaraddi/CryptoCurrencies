import 'dart:convert';
import 'package:cryptoapp/models/crypto_base_response.dart';
import 'package:http/http.dart' as http;

class ApiManager {
  Future<CryptoBaseResponse> getCryptoCurrencies(int startCount) async {
    var client = http.Client();
    var cryptoResponse;

    try {
      var headers = {
        'X-CMC_PRO_API_KEY': '86f13433-f5e2-4893-986e-2e35c90397bc',
        'Accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded',
        'Cookie': '__cfduid=d30f322262ee6398a57946c59e563acc71619294665'
      };
      var response = await client.get(
          Uri.parse(
              'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=$startCount&limit=10&convert=USD'),
          headers: headers);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        print(jsonString);
        var jsonMap = json.decode(jsonString);
        cryptoResponse = CryptoBaseResponse.fromJson(jsonMap);
      }
    } catch (Exception) {
      return cryptoResponse;
    }
    return cryptoResponse;
  }
}
