import 'package:flutter/material.dart';

class CurrencyPriceHeader extends StatelessWidget {
  const CurrencyPriceHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      leading: SizedBox(
        width: 50,
      ),
      title: Text(
        'Currency',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: Text(
        'Price',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}