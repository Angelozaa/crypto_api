import 'package:crypto_api/data/datasource/exchange_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/datasource/coinmarketcap_api.dart';
import 'repository/crypto_repository.dart';
import 'viewmodel/crypto_viewmodel.dart';
import 'ui/screens/crypto_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CryptoViewModel(
            CryptoRepository(CoinMarketCapApi()),
            ExchangeService(),
          )..loadCryptos(),
        ),
      ],
      child: MaterialApp(
        title: 'CoinMarketCap App',
        theme: ThemeData.dark(),
        home: const CryptoListScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
