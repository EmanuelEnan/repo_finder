import 'package:dartz/dartz.dart';
import 'package:repo_finder/features/screens/home/model/github_repos_model.dart';

import '../../../../data/network/api_failure.dart';

abstract class HomeRepository {
  Future<Either<ApiFailure, GithubReposModel>> getHomeData();
  
}
