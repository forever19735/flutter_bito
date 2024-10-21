import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class CurrencyIcon extends StatelessWidget {
  final String url;

  const CurrencyIcon({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      width: AppConstants.iconSize,
      height: AppConstants.iconSize,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.currency_exchange);
      },
    );
  }
}
