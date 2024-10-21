
import 'package:flutter/material.dart';
import 'currency_exchange.dart';

class CurrencyController {
  final TextEditingController currency1Controller = TextEditingController();
  final TextEditingController currency2Controller = TextEditingController();

  void dispose() {
    currency1Controller.dispose();
    currency2Controller.dispose();
  }

  void updateCurrency2Value(String value, CurrencyExchange exchange) {
    if (value.isEmpty) {
      currency2Controller.text = '';
      return;
    }

    try {
      final value1 = double.parse(value);
      final rate = exchange.calculateExchangeRate();
      final value2 = value1 * rate;
      final decimalPlaces = int.parse(exchange.currency2.amountDecimal);
      currency2Controller.text = value2.toStringAsFixed(decimalPlaces);
    } catch (error) {
      currency2Controller.text = error.toString();
    }
  }
}