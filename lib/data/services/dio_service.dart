import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DioService {
  @lazySingleton
  Dio get dio => Dio(
        BaseOptions(
          baseUrl: 'https://api.unsplash.com',
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 3),
        ),
      );
}