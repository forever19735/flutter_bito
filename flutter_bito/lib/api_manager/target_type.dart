abstract class TargetType {
  String get baseUrl;
  String get path;
  String get method;
  Map<String, dynamic>? get parameters;
  dynamic get data;
}