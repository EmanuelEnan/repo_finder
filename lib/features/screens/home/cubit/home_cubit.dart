import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import 'package:repo_finder/data/network/app_preference.dart';
import 'package:repo_finder/features/screens/home/model/github_repos_model.dart';
import 'package:repo_finder/features/screens/home/repository/home_repository.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _homeRepository;
  HomeCubit(this._homeRepository) : super(HomeState());

  RepoSortOrder currentSort = RepoSortOrder.starsDesc;
  RepoSortOrderByDate currentSortDate = RepoSortOrderByDate.newest;

  Future<void> loadRepos() async {
    emit(state.copyWith(profileStatus: ProfileStatus.loading));

    final cached = await loadReposFromCache();
    if (cached != null) {
      emit(
        state.copyWith(
          githubReposModel: cached,
          profileStatus: ProfileStatus.success,
        ),
      );
    } else {
      final response = await _homeRepository.getHomeData();
      response.fold(
        (failure) {
          emit(state.copyWith(profileStatus: ProfileStatus.failure));
        },
        (githubReposData) async {
          log('----repos data $githubReposData');

          emit(
            state.copyWith(
              profileStatus: ProfileStatus.success,
              githubReposModel: githubReposData,
            ),
          );
        },
      );
    }

    await saveReposToCache(state.githubReposModel!);
  }

  void sortByStars(RepoSortOrder order) {
    currentSort = order;

    final currentModel = state.githubReposModel;
    if (currentModel == null || currentModel.items == null) return;

    final sortedItems = List.of(currentModel.items!);

    sortedItems.sort((a, b) {
      final aStars = a.stargazersCount ?? 0;
      final bStars = b.stargazersCount ?? 0;

      return order == RepoSortOrder.starsDesc
          ? bStars.compareTo(aStars)
          : aStars.compareTo(bStars);
    });

    emit(
      state.copyWith(
        githubReposModel: currentModel.copyWith(items: sortedItems),
      ),
    );
  }

  void sortByDate(RepoSortOrderByDate order) {
    currentSortDate = order;

    final currentModel = state.githubReposModel;
    if (currentModel?.items == null) return;

    final sortedItems = List.of(currentModel!.items!);

    sortedItems.sort((a, b) {
      final aDate = DateTime.tryParse(a.updatedAt ?? '');
      final bDate = DateTime.tryParse(b.updatedAt ?? '');

      if (aDate == null && bDate == null) return 0;
      if (aDate == null) return 1;
      if (bDate == null) return -1;

      return order == RepoSortOrderByDate.newest
          ? bDate.compareTo(aDate)
          : aDate.compareTo(bDate);
    });

    emit(
      state.copyWith(
        githubReposModel: currentModel.copyWith(items: sortedItems),
      ),
    );
  }
}
