import 'package:dio/dio.dart';
import 'package:flutter_bito/api_manager/target_type.dart';
import 'base_response.dart';

class ApiProvider {
  final Dio _dio = Dio();

  Future<BaseResponse<T>> request<T>(
    TargetType target,
    T Function(dynamic) fromJsonData, 
  ) async {
    try {
      final response = await _dio.request(
        target.baseUrl + target.path,
        options: Options(method: target.method),
        queryParameters: target.parameters,
        data: target.data,
      );

      final parsedData = fromJsonData(response.data);

      return BaseResponse<T>(data: parsedData);
    } catch (error) {
      rethrow;
    }
  }
}
