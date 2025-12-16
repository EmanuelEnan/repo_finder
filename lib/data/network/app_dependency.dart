import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'app_dependency.config.dart';

final instance = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  asExtension: false,
)
Future<void> configureInjection() async => $initGetIt(instance);

@module
abstract class RegisterModule {
  @injectable
  Dio get dio => Dio();
}