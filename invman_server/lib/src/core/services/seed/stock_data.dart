import 'package:invman_server/src/generated/protocol.dart';

List<Stock> getSeedStocks(List<Currency> currencies) {
  int currencyId(String code) => currencies.firstWhere((c) => c.code == code).id!;

  return [
    // US Tech Stocks
    Stock(
      symbol: 'AAPL',
      shortName: 'Apple',
      longName: 'Apple Inc.',
      quoteType: StockType.ticker,
      currencyId: currencyId('USD'),
    ),
    Stock(
      symbol: 'MSFT',
      shortName: 'Microsoft',
      longName: 'Microsoft Corporation',
      quoteType: StockType.ticker,
      currencyId: currencyId('USD'),
    ),
    Stock(
      symbol: 'GOOGL',
      shortName: 'Alphabet',
      longName: 'Alphabet Inc.',
      quoteType: StockType.ticker,
      currencyId: currencyId('USD'),
    ),
    Stock(
      symbol: 'AMZN',
      shortName: 'Amazon',
      longName: 'Amazon.com Inc.',
      quoteType: StockType.ticker,
      currencyId: currencyId('USD'),
    ),
    Stock(
      symbol: 'NVDA',
      shortName: 'NVIDIA',
      longName: 'NVIDIA Corporation',
      quoteType: StockType.ticker,
      currencyId: currencyId('USD'),
    ),
    // ETFs
    Stock(
      symbol: 'SPY',
      shortName: 'S&P 500 ETF',
      longName: 'SPDR S&P 500 ETF Trust',
      quoteType: StockType.etf,
      currencyId: currencyId('USD'),
    ),
    Stock(
      symbol: 'QQQ',
      shortName: 'Nasdaq ETF',
      longName: 'Invesco QQQ Trust',
      quoteType: StockType.etf,
      currencyId: currencyId('USD'),
    ),
    Stock(
      symbol: 'VTI',
      shortName: 'Total Market ETF',
      longName: 'Vanguard Total Stock Market ETF',
      quoteType: StockType.etf,
      currencyId: currencyId('USD'),
    ),
    // Crypto
    Stock(
      symbol: 'BTC',
      shortName: 'Bitcoin',
      longName: 'Bitcoin',
      quoteType: StockType.crypto,
      currencyId: currencyId('USD'),
    ),
    Stock(
      symbol: 'ETH',
      shortName: 'Ethereum',
      longName: 'Ethereum',
      quoteType: StockType.crypto,
      currencyId: currencyId('USD'),
    ),
    Stock(
      symbol: 'SOL',
      shortName: 'Solana',
      longName: 'Solana',
      quoteType: StockType.crypto,
      currencyId: currencyId('USD'),
    ),
    Stock(
      symbol: 'XRP',
      shortName: 'Ripple',
      longName: 'XRP',
      quoteType: StockType.crypto,
      currencyId: currencyId('USD'),
    ),
  ];
}
