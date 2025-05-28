import 'package:crypto_api/data/datasource/exchange_service.dart';
import 'package:flutter/material.dart';
import '../model/crypto_model.dart';
import '../repository/crypto_repository.dart';

class CryptoViewModel extends ChangeNotifier {
  final CryptoRepository repository;
  final ExchangeService exchangeService;

  List<CryptoModel> cryptos = [];
  bool isLoading = false;
  String error = '';
  double usdToBrlRate = 5.0;
  bool mostrarEmBrl = false;

  CryptoViewModel(this.repository, this.exchangeService);

  Future<void> loadCryptos([String? symbols]) async {
    try {
      isLoading = true;
      notifyListeners();

      usdToBrlRate = await exchangeService.fetchUsdToBrl();
      cryptos = await repository.getCryptos(
        (symbols != null && symbols.isNotEmpty) ? symbols : 'BTC,ETH,SOL,BNB,BCH,MKR,AAVE,DOT,SUI,ADA,XRP,TIA,NEO,NEAR,PENDLE,RENDER,LINK,TON,XAI,SEI,IMX,ETHFI,UMA,SUPER,FET,USUAL,GALA,PAAL,AERO',
      );

      error = '';
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void alternarMoeda() {
    mostrarEmBrl = !mostrarEmBrl;
    notifyListeners();
  }
}

