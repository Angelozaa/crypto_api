import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/crypto_viewmodel.dart';
import 'package:crypto_api/ui/widgets/crypto_card.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  final TextEditingController _controller = TextEditingController();

  void _buscar() {
    final symbols = _controller.text.trim().toUpperCase();
    context.read<CryptoViewModel>().loadCryptos(symbols);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CryptoViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Criptomoedas')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Símbolos (ex: BTC,ETH)',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _buscar(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _buscar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple, 
                    foregroundColor: Colors.white,  
                    elevation: 4,                   
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 23),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Buscar'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text('USD'),
                Consumer<CryptoViewModel>(
                  builder: (_, viewModel, __) => Switch(
                    value: viewModel.mostrarEmBrl,
                    onChanged: (_) => viewModel.alternarMoeda(),
                  ),
                ),
                const Text('BRL'),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => viewModel.loadCryptos(),
              child: viewModel.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : viewModel.error.isNotEmpty
                      ? Center(child: Text(viewModel.error))
                      : ListView.builder(
                          itemCount: viewModel.cryptos.length,
                          itemBuilder: (context, index) =>
                              CryptoCard(crypto: viewModel.cryptos[index]),
                        ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => viewModel.loadCryptos(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
