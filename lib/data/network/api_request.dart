import 'dart:developer';

import 'package:dartz/dartz.dart';

import 'package:injectable/injectable.dart';
import 'package:repo_finder/data/network/api_client.dart';
import 'package:repo_finder/data/network/api_exception.dart';
import 'package:repo_finder/data/network/api_failure.dart';
import 'package:repo_finder/data/network/app_dependency.dart';

enum Method { post, get, put, delete, patch }

@Injectable()
class ApiRequest {
  final ApiClient? apiClient = instance.get();

  ApiRequest();

  Future<Either<ApiFailure, T>> performRequest<T>({
    required String url,
    required Method method,
    Map<String, dynamic>? params,
    Function? fromJson,
    int? id,
  }) async {
    try {
      final response = await apiClient?.request(
        url: id != null ? '$url/$id' : url,
        method: method,
        params: params,
      );

      if (fromJson != null) {
        return Right(fromJson(response));
      } else {
        return Right(response);
      }
    } catch (error, stackTrace) {
      log('error ----- $error');
      log('stackTrace ----- $stackTrace');
      return Left(ApiException.handle(error).failure);
    }
  }
}
