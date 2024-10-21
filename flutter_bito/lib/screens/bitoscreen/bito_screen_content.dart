
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/bito_bloc.dart';
import '../../bloc/bito_event.dart';
import '../../bloc/bito_state.dart';
import '../../constants/app_constants.dart';
import '../../models/bito_data.dart';
import '../../widgets/error_display.dart';
import '../../widgets/loading_indicator.dart';
import 'bito_loaded_content.dart';
// 內容區域元件
class BitoScreenContent extends StatefulWidget {
  const BitoScreenContent({super.key});

  @override
  BitoScreenContentState createState() => BitoScreenContentState();
}

class BitoScreenContentState extends State<BitoScreenContent> {
  final List<BitoData> selectedCurrencies = [];

  @override
  Widget build(BuildContext context) {
    final bitoBloc = context.read<BitoBloc>();

    if (bitoBloc.state is BitoInitial) {
      bitoBloc.add(FetchBitoData());
    }

    return BlocBuilder<BitoBloc, BitoState>(
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _buildContent(state),
        );
      },
    );
  }

  Widget _buildContent(BitoState state) {
    if (state is BitoInitial) {
      return const Center(child: Text(AppConstants.initialMessage));
    }

    if (state is BitoLoading) {
      return const LoadingIndicator();
    }

    if (state is BitoLoaded) {
      return BitoLoadedContent(
        data: state.data,
        onItemTap: _addCurrency,
        selectedCurrencies: selectedCurrencies,
      );
    }

    if (state is BitoError) {
      return ErrorDisplay(message: state.message);
    }

    return const SizedBox.shrink();
  }

  void _addCurrency(BitoData currency) {
    setState(() {
      bool exists =
          selectedCurrencies.any((item) => item.currency == currency.currency);

      if (!exists) {
        selectedCurrencies.add(currency);
      }
    });
  }
}