import 'dart:convert';
import 'package:http/http.dart' as http;

class CoinMarketCapApi {
  final String _baseUrl = 'http://localhost:3000/quotes';

    Future<List<Map<String, dynamic>>> fetchCryptos(String symbols) async {
      final uri = Uri.parse('$_baseUrl?symbols=$symbols');
      final response = await http.get(uri, headers: {
        "Accept": "application/json",
      });

      final json = jsonDecode(response.body);

      if (response.statusCode == 200 && json['data'] != null) {
        final data = json['data'] as Map<String, dynamic>;

        final filteredCryptos = <Map<String, dynamic>>[];

        for (var entry in data.entries) {
          final symbolList = entry.value as List<dynamic>;

          final ativosValidos = symbolList
              .where((item) =>
                  item is Map<String, dynamic> &&
                  item['is_active'] == 1 &&
                  item['cmc_rank'] != null)
              .toList();

          if (ativosValidos.isNotEmpty) {
            final melhor = ativosValidos.reduce((a, b) =>
                (a['cmc_rank'] as int) < (b['cmc_rank'] as int) ? a : b);
            filteredCryptos.add(melhor as Map<String, dynamic>);
          }
        }

        return filteredCryptos;
      } else {
        final errorMsg = json['error'] ?? 'Erro inesperado ao buscar criptomoedas';
        throw Exception(errorMsg);
      }
    }
}
