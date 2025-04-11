import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/coin_model.dart';

class CoinService {
  Future<List<CoinModel>> fetchCoins() async {
    final url = Uri.parse("https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonData = json.decode(response.body);
      return jsonData.map((coin) => CoinModel.fromJson(coin)).toList();
    } else {
      throw Exception("Failed to load coins");
    }
  }
}
