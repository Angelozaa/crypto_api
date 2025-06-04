const express = require('express');
const axios = require('axios');
const cors = require('cors');
const app = express();
const port = 3000;

app.use(cors());

app.get('/quotes', async (req, res) => {
  try {
    const symbols = req.query.symbols || 'BTC,ETH';
    const url = `https://pro-api.coinmarketcap.com/v2/cryptocurrency/quotes/latest?symbol=${symbols}`;

    console.log('URL chamada:', url);

    const response = await axios.get(url, {
      headers: {
        'X-CMC_PRO_API_KEY': '6e67b604-4ebc-488a-a177-858a986717eb',
        'Accept': 'application/json',
      },
    });

    res.json(response.data);
  } catch (e) {
    console.error('Erro CoinMarketCap:', e.response?.data || e.message);
    res.status(500).json({ error: 'Erro ao buscar dados da CoinMarketCap' });
  }
});


app.listen(port, () => {
  console.log(`Servidor proxy rodando: http://localhost:${port}`);
});
