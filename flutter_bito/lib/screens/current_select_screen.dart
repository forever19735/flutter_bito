import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../models/bito_data.dart';
import '../widgets/currecny_item.dart';
import '../widgets/empty_state_message.dart';

class CurrencySelectScreen extends StatelessWidget {
  final List<BitoData> selectedCurrencies;
  const CurrencySelectScreen({super.key, required this.selectedCurrencies});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.selectedCurrenciesTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingDefault),
        child: Builder(
          builder: (context) {
            if (selectedCurrencies.isEmpty) {
              return const EmptyStateMessage();
            }

            return ListView.builder(
              itemCount: selectedCurrencies.length,
              itemBuilder: (context, index) {
                return CurrencyItem(
                  currency: selectedCurrencies[index],
                  title: selectedCurrencies[index].currency,
                  onTap: null, 
                );
              },
            );
          },
        ),
      ),
    );
  }
}