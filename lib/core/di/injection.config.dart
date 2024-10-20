// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:images/data/repositories/image_repository_impl.dart' as _i711;
import 'package:images/data/services/dio_service.dart' as _i178;
import 'package:images/domain/repositories/image_repository.dart' as _i64;
import 'package:images/domain/usecases/get_images_usecase.dart' as _i463;
import 'package:images/presentation/viewmodels/home_viewmodel.dart'
    as _i927;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioService = _$DioService();
    gh.lazySingleton<_i361.Dio>(() => dioService.dio);
    gh.factory<_i64.ImageRepository>(
        () => _i711.ImageRepositoryImpl(gh<_i361.Dio>()));
    gh.factory<_i463.GetImagesUseCase>(
        () => _i463.GetImagesUseCase(gh<_i64.ImageRepository>()));
    gh.factory<_i927.ImageListViewmodel>(
        () => _i927.ImageListViewmodel(gh<_i463.GetImagesUseCase>()));
    return this;
  }
}

class _$DioService extends _i178.DioService {}
