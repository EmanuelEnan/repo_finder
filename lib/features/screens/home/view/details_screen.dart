import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:repo_finder/features/screens/home/cubit/home_cubit.dart';

class DetailsScreen extends StatelessWidget {
  final int index;
  final String? updatedAt;
  const DetailsScreen({
    super.key,
    required this.index,
    required this.updatedAt,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(centerTitle: true, title: Text('Repo Details')),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(
                        state
                                .githubReposModel
                                ?.items?[index]
                                .owner
                                ?.avatarUrl ??
                            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                      ),
                    ),
                  ),
                  Text(
                    'Full name: ${state.githubReposModel?.items?[index].fullName ?? ''}',
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    'Repo description: ${state.githubReposModel?.items?[index].description ?? ''}',
                  ),
                  Text(
                    'Last updated: ${updatedAt != null && updatedAt!.isNotEmpty ? DateFormat('dd.MM.yyyy hh:mm a').format(DateTime.parse(updatedAt!)) : 'no date available'}',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
