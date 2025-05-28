import 'dart:convert';
import 'package:http/http.dart' as http;

class ExchangeService {
  Future<double> fetchUsdToBrl() async {
    final uri = Uri.parse('https://economia.awesomeapi.com.br/last/USD-BRL');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final rate = json['USDBRL']?['bid'];
      return rate != null ? double.parse(rate) : 5.0;
    } else {
      throw Exception('Erro ao buscar cotação USD/BRL');
    }
  }
}
