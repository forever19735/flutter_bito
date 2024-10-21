import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import 'bito_screen_content.dart';

// 主畫面
class BitoScreen extends StatelessWidget {
  const BitoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appTitle),
      ),
      body: const BitoScreenContent(),
    );
  }
}