import 'dart:convert';

List<BitoData> bitoDataFromJson(String str) => List<BitoData>.from(json.decode(str).map((x) => BitoData.fromJson(x)));

String bitoDataToJson(List<BitoData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BitoData {
    String currency;
    String currencyIcon;
    double twdPrice;
    String amountDecimal;
    String id;

    BitoData({
        required this.currency,
        required this.currencyIcon,
        required this.twdPrice,
        required this.amountDecimal,
        required this.id,
    });

    factory BitoData.fromJson(Map<String, dynamic> json) => BitoData(
        currency: json["currency"],
        currencyIcon: json["currency_icon"],
        twdPrice: json["twd_price"]?.toDouble(),
        amountDecimal: json["amount_decimal"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "currency": currency,
        "currency_icon": currencyIcon,
        "twd_price": twdPrice,
        "amount_decimal": amountDecimal,
        "id": id,
    };
}
