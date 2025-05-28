import 'dart:convert';
import 'package:http/http.dart' as http;

class CoinMarketCapApi {
  final String _baseUrl = 'http://localhost:3000/quotes';

  Future<Map<String, dynamic>> fetchCryptos(String symbols) async {
    final uri = Uri.parse('$_baseUrl?symbols=$symbols');
    final response = await http.get(uri, headers: {
      "Accept": "application/json",
    });

    final json = jsonDecode(response.body);

    if (response.statusCode == 200 && json['data'] != null) {
      return Map<String, dynamic>.from(json['data']);
    } else {
      final errorMsg = json['error'] ?? 'Erro inesperado ao buscar criptomoedas';
      throw Exception(errorMsg);
    }
  }
}
