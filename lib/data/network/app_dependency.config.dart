// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:repo_finder/data/network/api_client.dart' as _i279;
import 'package:repo_finder/data/network/api_request.dart' as _i1003;
import 'package:repo_finder/data/network/app_dependency.dart' as _i988;
import 'package:repo_finder/features/screens/home/cubit/home_cubit.dart'
    as _i541;
import 'package:repo_finder/features/screens/home/repository/home_repository.dart'
    as _i213;
import 'package:repo_finder/features/screens/home/repository/home_repository_impl.dart'
    as _i411;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.factory<_i1003.ApiRequest>(() => _i1003.ApiRequest());
  gh.factory<_i361.Dio>(() => registerModule.dio);
  gh.factory<_i213.HomeRepository>(
    () => _i411.HomeRepositoryImpl(gh<_i1003.ApiRequest>()),
  );
  gh.factory<_i279.ApiClient>(() => _i279.ApiClient(gh<_i361.Dio>()));
  gh.factory<_i541.HomeCubit>(
    () => _i541.HomeCubit(gh<_i213.HomeRepository>()),
  );
  return getIt;
}

class _$RegisterModule extends _i988.RegisterModule {}
