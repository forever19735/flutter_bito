import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/bito_data.dart';
import 'currency_controller.dart';
import 'currency_exchange.dart';

// 主畫面
class RateConversionScreen extends StatefulWidget {
  const RateConversionScreen({
    required this.data,
    this.currency1,
    this.currency2,
    super.key,
  });

  final List<BitoData> data;
  final BitoData? currency1;
  final BitoData? currency2;

  @override
  State<RateConversionScreen> createState() => _RateConversionScreenState();
}

class _RateConversionScreenState extends State<RateConversionScreen> {
  late BitoData _selectedCurrency1;
  late BitoData _selectedCurrency2;
  late CurrencyController _currencyController;

  @override
  void initState() {
    super.initState();
    _currencyController = CurrencyController();
    _selectedCurrency1 = widget.currency1 ?? widget.data.first;
    _selectedCurrency2 = widget.currency2 ?? widget.data.first;
    _initializeControllers();
  }

  @override
  void dispose() {
    _currencyController.dispose();
    super.dispose();
  }

  void _initializeControllers() {
    _currencyController.currency1Controller.text = '';
    _currencyController.currency2Controller.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('Rate Conversion'),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildCurrencyRow(isFirstCurrency: true),
          const SizedBox(height: 16.0),
          _buildExchangeRateIndicator(),
          const SizedBox(height: 16.0),
          _buildCurrencyRow(isFirstCurrency: false),
        ],
      ),
    );
  }

  Widget _buildCurrencyRow({required bool isFirstCurrency}) {
    final selectedCurrency = isFirstCurrency ? _selectedCurrency1 : _selectedCurrency2;
    final controller = isFirstCurrency
        ? _currencyController.currency1Controller
        : _currencyController.currency2Controller;

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: _buildContainerDecoration(),
      child: Row(
        children: [
          _buildCurrencyIcon(selectedCurrency.currencyIcon),
          const SizedBox(width: 8),
          _buildCurrencyDropdown(
            selectedCurrency: selectedCurrency,
            isFirstCurrency: isFirstCurrency,
          ),
          const Spacer(),
          _buildCurrencyInput(
            controller: controller,
            isEnabled: isFirstCurrency,
          ),
        ],
      ),
    );
  }

  BoxDecoration _buildContainerDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.black12),
    );
  }

  Widget _buildCurrencyIcon(String iconUrl) {
    return Image.network(
      iconUrl,
      width: 32,
      height: 32,
      errorBuilder: (_, __, ___) => const Icon(Icons.currency_exchange, size: 32),
    );
  }

  Widget _buildCurrencyDropdown({
    required BitoData selectedCurrency,
    required bool isFirstCurrency,
  }) {
    return DropdownButton<String>(
      value: selectedCurrency.currency,
      items: _buildDropdownItems(),
      onChanged: (newValue) => _handleCurrencyChange(newValue, isFirstCurrency),
    );
  }

  List<DropdownMenuItem<String>> _buildDropdownItems() {
    return widget.data
        .map((currency) => DropdownMenuItem<String>(
              value: currency.currency,
              child: Text(currency.currency),
            ))
        .toList();
  }

  Widget _buildCurrencyInput({
    required TextEditingController controller,
    required bool isEnabled,
  }) {
    return SizedBox(
      width: 100,
      child: TextFormField(
        controller: controller,
        enabled: isEnabled,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        textAlign: TextAlign.end,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          hintText: '0',
        ),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,8}')),
        ],
        onChanged: isEnabled
            ? (value) => _currencyController.updateCurrency2Value(
                  value,
                  CurrencyExchange(_selectedCurrency1, _selectedCurrency2),
                )
            : null,
      ),
    );
  }

  Widget _buildExchangeRateIndicator() {
    final rate = CurrencyExchange(_selectedCurrency1, _selectedCurrency2).calculateExchangeRate();
    final decimalPlaces = int.parse(_selectedCurrency2.amountDecimal);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.arrow_downward, size: 32, color: Colors.black),
        const SizedBox(width: 8),
        Text(
          '1 ${_selectedCurrency1.currency} ≈ ${rate.toStringAsFixed(decimalPlaces)} ${_selectedCurrency2.currency}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  void _handleCurrencyChange(String? newValue, bool isFirstCurrency) {
    if (newValue == null) return;

    final newCurrency = widget.data.firstWhere(
      (element) => element.currency == newValue,
    );
    setState(() {
      if (isFirstCurrency) {
        _selectedCurrency1 = newCurrency;
      } else {
        _selectedCurrency2 = newCurrency;
      }
      _currencyController.updateCurrency2Value(
        _currencyController.currency1Controller.text,
        CurrencyExchange(_selectedCurrency1, _selectedCurrency2),
      );
    });
  }
}

