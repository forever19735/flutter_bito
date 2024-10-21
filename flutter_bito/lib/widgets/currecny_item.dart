import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/bito_data.dart';
import 'currency_icon.dart';

class CurrencyItem extends StatelessWidget {
  final BitoData currency;
  final String title; // 新增 title 參數
  final VoidCallback? onTap; // 可選的 onTap 參數

  const CurrencyItem({
    super.key,
    required this.currency,
    required this.title, // 必需的 title 參數
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat("#,##0.00", "en_US");

    return ListTile(
      leading: CurrencyIcon(url: currency.currencyIcon),
      title: Text(title),
      trailing: onTap != null ? Text(numberFormat.format(currency.twdPrice)) : null,
      onTap: onTap,
    );
  }
}

