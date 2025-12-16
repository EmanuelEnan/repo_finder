import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:repo_finder/data/network/api_request.dart';

@Injectable()
class ApiClient {
  // final AppPreferences _appPreferences;
  final Dio _dio;

  ApiClient(this._dio);

  Future<dynamic> request({
    required String url,
    required Method method,
    Map<String, dynamic>? params,
  }) async {
    try {
      Response response;
      switch (method) {
        case Method.post:
          response = await _dio.post(url, data: params);
          break;

        case Method.get:
          response = await _dio.get(url, queryParameters: params);
          break;
        default:
          throw UnsupportedError("Unsupported HTTP method");
      }

      log('[$url] [${response.statusCode}] Response data: ${response.data}');
      return response.data;
    } on DioException catch (error) {
      log('DioError: $error');
      // dismissProgressDialog();
      rethrow;
    } catch (error) {
      log('Error: $error');
      // dismissProgressDialog();
      rethrow;
    }
  }
}
