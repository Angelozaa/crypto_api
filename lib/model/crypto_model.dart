class CryptoModel {
  final String name;
  final String symbol;
  final String dateAdded;
  final double priceUsd;

  CryptoModel({
    required this.name,
    required this.symbol,
    required this.dateAdded,
    required this.priceUsd,
  });

  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    final quote = json['quote'];
    final usd = quote is Map<String, dynamic> ? quote['USD'] : null;

    if (usd == null) {
      print('⚠️ Atenção: quote["USD"] veio nulo para ${json['symbol']}');
    }

    final price = usd is Map<String, dynamic> ? usd['price'] : null;
    final priceUsd = price is num ? price.toDouble() : 0.0;

    return CryptoModel(
      name: json['name'] ?? 'Desconhecido',
      symbol: json['symbol'] ?? '???',
      dateAdded: json['date_added'] ?? '---',
      priceUsd: priceUsd,
    );
  }
}
