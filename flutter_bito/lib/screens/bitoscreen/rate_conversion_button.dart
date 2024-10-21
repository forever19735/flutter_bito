
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bito_bloc.dart';
import '../../bloc/bito_state.dart';
import '../../constants/app_constants.dart';
import '../../models/bito_data.dart';
import '../current_select_screen.dart';
import '../rateconversionscreen/rate_conversion_screen.dart';

class RateConversionButton extends StatelessWidget {
  final List<BitoData> selectedCurrencies;

  const RateConversionButton({super.key, required this.selectedCurrencies});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<BitoBloc>().state;
    if (state is! BitoLoaded) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(AppConstants.paddingDefault),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () => _navigateToRateConversion(context, state.data),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
            ),
            child: const Text(AppConstants.rateConversionTitle),
          ),
          ElevatedButton(
            onPressed: () => _navigateToCurrentSelectScreen(context),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
            ),
            child: const Text(AppConstants.selectedCurrenciesTitle),
          ),
        ],
      ),
    );
  }

  void _navigateToRateConversion(BuildContext context, List<BitoData> data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RateConversionScreen(data: data),
      ),
    );
  }

  void _navigateToCurrentSelectScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CurrencySelectScreen(selectedCurrencies: selectedCurrencies),
      ),
    );
  }
}