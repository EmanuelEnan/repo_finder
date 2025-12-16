part of 'home_cubit.dart';

enum ProfileStatus {
  initial,
  loading,
  success,
  profileUpdateSuccess,
  failure,
  update,
}

enum RepoSortOrder { starsDesc, starsAsc }

enum RepoSortOrderByDate { newest, oldest }

class HomeState extends Equatable {
  final ProfileStatus profileStatus;
  final RepoSortOrder repoSortOrder;
  final RepoSortOrderByDate repoSortOrderByDate;
  final GithubReposModel? githubReposModel;

  const HomeState({
    this.profileStatus = ProfileStatus.initial,
    this.repoSortOrder = RepoSortOrder.starsDesc,
    this.repoSortOrderByDate = RepoSortOrderByDate.newest,
    this.githubReposModel,
  });

  HomeState copyWith({
    final ProfileStatus? profileStatus,
    final RepoSortOrder? repoSortOrder,
    final RepoSortOrderByDate? repoSortOrderByDate,
    final GithubReposModel? githubReposModel,
  }) {
    return HomeState(
      profileStatus: profileStatus ?? this.profileStatus,
      repoSortOrder: repoSortOrder ?? this.repoSortOrder,
      repoSortOrderByDate: repoSortOrderByDate ?? this.repoSortOrderByDate,
      githubReposModel: githubReposModel ?? this.githubReposModel,
    );
  }

  @override
  List<Object> get props => [
    profileStatus,
    repoSortOrder,
    repoSortOrderByDate,
    githubReposModel ?? [],
  ];
}
