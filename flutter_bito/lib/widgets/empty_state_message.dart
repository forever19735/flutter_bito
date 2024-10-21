
import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class EmptyStateMessage extends StatelessWidget {
  const EmptyStateMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(AppConstants.noDataMessage),
    );
  }
}