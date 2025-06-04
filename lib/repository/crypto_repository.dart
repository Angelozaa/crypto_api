import '../data/datasource/coinmarketcap_api.dart';
import '../model/crypto_model.dart';

class CryptoRepository {
  final CoinMarketCapApi api;

  CryptoRepository(this.api);

  Future<List<CryptoModel>> getCryptos(String symbols) async {
    final list = await api.fetchCryptos(symbols);
    return list.map((item) => CryptoModel.fromJson(item)).toList();
  }
}
