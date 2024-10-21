
import 'package:flutter/material.dart';

import '../../models/bito_data.dart';
import '../../widgets/currecny_item.dart';

class BitoDataList extends StatelessWidget {
  final List<BitoData> data;
  final Function(BitoData) onItemTap;

  const BitoDataList({
    super.key,
    required this.data,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index){
      return CurrencyItem(
        currency: data[index],
        title: '${data[index].currency} / TWD',
        onTap: () => onItemTap(data[index]), // 傳遞 onTap 回調
      );
    }
    );
  }
}
