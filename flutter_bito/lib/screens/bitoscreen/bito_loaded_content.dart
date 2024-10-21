
import 'package:flutter/material.dart';
import '../../models/bito_data.dart';
import 'bito_data_list.dart';
import 'currency_price_header.dart';
import 'rate_conversion_button.dart';

class BitoLoadedContent extends StatelessWidget {
  final List<BitoData> data;
  final Function(BitoData) onItemTap;
  final List<BitoData> selectedCurrencies;

  const BitoLoadedContent({
    super.key,
    required this.data,
    required this.onItemTap,
    required this.selectedCurrencies, // 新增 selectedCurrencies
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CurrencyPriceHeader(),
        const Divider(),
        Expanded(
          child: BitoDataList(
            data: data,
            onItemTap: onItemTap,
          ),
        ),
        RateConversionButton(selectedCurrencies: selectedCurrencies), // 傳遞 selectedCurrencies
      ],
    );
  }
}