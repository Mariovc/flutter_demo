import 'package:dio/dio.dart';
import 'package:images/core/di/environment.dart';
import 'package:images/data/datasources/image/image_remote_datasource.dart';
import 'package:images/data/models/search_result_dto.dart';
import 'package:images/domain/entities/image_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ImageRemoteDatasource)
class ImageRepositoryImpl implements ImageRemoteDatasource {
  final Dio dio;
  final Env envConfig;
  final String _defaultQuery = '*';

  ImageRepositoryImpl(this.dio, this.envConfig);

  @override
  Future<List<ImageEntity>> getImages({
    required String query,
    required int pageSize,
    required int page,
  }) async {
    // Fetch images using dio
    final response = await dio.getUri(
      Uri.https(
        envConfig.baseUrl,
        '/search/photos',
        {
          'query': query.isEmpty ? _defaultQuery : query,
          'page': page.toString(),
          'client_id': envConfig.apiKey,
        },
      ),
    );

    final result = SearchResultDto.fromJson(response.data);
    return result.results.map((e) => e.toEntity()).toList();
  }
}
