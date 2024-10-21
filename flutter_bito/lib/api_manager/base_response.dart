class BaseResponse<T> {
  final T data;

  BaseResponse({
    required this.data,
  });

  factory BaseResponse.fromJson(dynamic json, T Function(dynamic) fromJsonData) {
    T parsedData;

    if (json is List) {
      parsedData = json.map((item) => fromJsonData(item)).toList() as T;
    } else {
      parsedData = fromJsonData(json);
    }

    return BaseResponse<T>(
      data: parsedData,
    );
  }
}
