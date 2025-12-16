import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:repo_finder/features/screens/home/cubit/home_cubit.dart';
import 'package:repo_finder/features/screens/home/view/details_screen.dart';
import 'package:repo_finder/features/screens/home/widgets/repo_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<HomeCubit>().loadRepos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(centerTitle: true, title: Text('Repos')),
          body: state.githubReposModel != null
              ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: DropdownButton<RepoSortOrder>(
                              value: context.read<HomeCubit>().currentSort,
                              underline: const SizedBox(),
                              items: const [
                                DropdownMenuItem(
                                  value: RepoSortOrder.starsDesc,
                                  child: Text('Most stars'),
                                ),
                                DropdownMenuItem(
                                  value: RepoSortOrder.starsAsc,
                                  child: Text('Least stars'),
                                ),
                              ],
                              onChanged: (value) {
                                if (value == null) return;

                                setState(() {
                                  context.read<HomeCubit>().currentSort = value;
                                });

                                context.read<HomeCubit>().sortByStars(value);
                              },
                            ),
                          ),
                          DropdownButton<RepoSortOrderByDate>(
                            value: context.read<HomeCubit>().currentSortDate,
                            underline: const SizedBox(),
                            items: const [
                              DropdownMenuItem(
                                value: RepoSortOrderByDate.newest,
                                child: Text('Latest'),
                              ),
                              DropdownMenuItem(
                                value: RepoSortOrderByDate.oldest,
                                child: Text('Oldest'),
                              ),
                            ],
                            onChanged: (value) {
                              if (value == null) return;

                              setState(() {
                                context.read<HomeCubit>().currentSortDate =
                                    value;
                              });

                              context.read<HomeCubit>().sortByDate(value);
                            },
                          ),
                        ],
                      ),

                      Expanded(
                        child: ListView.builder(
                          itemCount: state.githubReposModel?.items?.length,
                          itemBuilder: (context, index) {
                            String? updatedAt =
                                state.githubReposModel?.items?[index].updatedAt;
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => DetailsScreen(
                                      index: index,
                                      updatedAt: updatedAt,
                                    ),
                                  ),
                                );
                              },
                              child: RepoCard(
                                name:
                                    state
                                        .githubReposModel
                                        ?.items?[index]
                                        .name ??
                                    '',
                                owner:
                                    state
                                        .githubReposModel
                                        ?.items?[index]
                                        .owner
                                        ?.type ??
                                    '',
                                starCount:
                                    state
                                        .githubReposModel
                                        ?.items?[index]
                                        .stargazersCount
                                        .toString() ??
                                    '',
                                updatedAt:
                                    updatedAt != null && updatedAt.isNotEmpty
                                    ? DateFormat(
                                        'dd.MM.yyyy hh:mm a',
                                      ).format(DateTime.parse(updatedAt))
                                    : 'no date available',
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
