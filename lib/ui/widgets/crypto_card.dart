import 'package:crypto_api/model/crypto_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/crypto_viewmodel.dart';

class CryptoCard extends StatelessWidget {
  final CryptoModel crypto;

  const CryptoCard({super.key, required this.crypto});

  String _formatPrice(double value, {String locale = 'en_US'}) {
    return NumberFormat.simpleCurrency(locale: locale).format(value);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CryptoViewModel>();
    final usdToBrl = viewModel.usdToBrlRate;
    final mostrarEmBrl = viewModel.mostrarEmBrl;

    final valor = mostrarEmBrl
        ? _formatPrice(crypto.priceUsd * usdToBrl, locale: 'pt_BR')
        : _formatPrice(crypto.priceUsd, locale: 'en_US');

    return ListTile(
      title: Text('${crypto.symbol} - ${crypto.name}'),
      subtitle: Text('${mostrarEmBrl ? "BRL" : "USD"}: $valor'),
      onTap: () => _showDetails(context, usdToBrl, mostrarEmBrl),
    );
  }

  void _showDetails(BuildContext context, double usdToBrl, bool mostrarEmBrl) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${crypto.name} (${crypto.symbol})', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Data Adicionada: ${_formatDate(crypto.dateAdded)}'),
            const SizedBox(height: 8),
            Text(' USD: ${_formatPrice(crypto.priceUsd, locale: 'en_US')}'),
            Text(' BRL: ${_formatPrice(crypto.priceUsd * usdToBrl, locale: 'pt_BR')}'),
          ],
        ),
      ),
    );
  }

  String _formatDate(String rawDate) {
    try {
      final dateTime = DateTime.parse(rawDate);
      return DateFormat('dd/MM/yyyy').format(dateTime);
    } catch (_) {
      return rawDate;
    }
  }

}
