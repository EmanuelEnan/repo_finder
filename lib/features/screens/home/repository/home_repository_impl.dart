import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:repo_finder/data/network/api_failure.dart';
import 'package:repo_finder/data/network/api_request.dart';
import 'package:repo_finder/data/network/api_urls.dart';
import 'package:repo_finder/features/screens/home/model/github_repos_model.dart';
import 'package:repo_finder/features/screens/home/repository/home_repository.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final ApiRequest _apiRequest;

  HomeRepositoryImpl(this._apiRequest);

  @override
  Future<Either<ApiFailure, GithubReposModel>> getHomeData() {
    return _apiRequest.performRequest(
      url: ApiUrls.liveUrl,
      method: Method.get,
      fromJson: GithubReposModel.fromJson,
    );
  }

}
