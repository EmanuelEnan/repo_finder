import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:repo_finder/data/network/app_dependency.dart';
import 'package:repo_finder/features/screens/home/cubit/home_cubit.dart';

import 'features/screens/home/view/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => instance<HomeCubit>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Repo Finder',
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        home: const HomeScreen(),
      ),
    );
  }
}
