
import '../../models/bito_data.dart';

class CurrencyExchange {
  final BitoData currency1;
  final BitoData currency2;

  CurrencyExchange(this.currency1, this.currency2);

  double calculateExchangeRate() {
    if (currency1.twdPrice <= 0) return 0;
    return currency2.twdPrice / currency1.twdPrice;
  }
}