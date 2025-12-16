import 'dart:convert';

import 'package:repo_finder/features/screens/home/model/github_repos_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveReposToCache(GithubReposModel model) async {
  final prefs = await SharedPreferences.getInstance();

  final jsonString = jsonEncode(model.toJson());

  await prefs.setString('github_repos_cache', jsonString);
}

Future<GithubReposModel?> loadReposFromCache() async {
  final prefs = await SharedPreferences.getInstance();

  final jsonString = prefs.getString('github_repos_cache');
  if (jsonString == null) return null;

  final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;

  return GithubReposModel.fromJson(jsonMap);
}
