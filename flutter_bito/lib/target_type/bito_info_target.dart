import '../api_manager/target_type.dart';

class BitoInfoInfoTarget implements TargetType {
  @override
  String get baseUrl => 'https://65efcc68ead08fa78a50f929.mockapi.io';

  @override
  String get path => '/api/v1/pairs';

  @override
  String get method => 'GET';

  @override
  Map<String, dynamic>? get parameters => null;

  @override
  dynamic get data => null;
}