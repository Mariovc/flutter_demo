import 'package:dio/dio.dart';
import 'package:images/data/models/search_result_dto.dart';
import 'package:images/domain/entities/image_entity.dart';
import 'package:images/domain/repositories/image_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ImageRepository)
class ImageRepositoryImpl implements ImageRepository {
  final Dio dio;
  final String _defaultQuery = '*';

  String apiKey =
      'uQXPMHIOSdoJgi10hGFiNQ04NyzdHrFThVOUnjwU4D4'; // TODO keep it secret

  // TODO usar remoteDataSource
  ImageRepositoryImpl(this.dio);

  @override
    Future<List<ImageEntity>> getImages({
    required String query,
    required int pageSize,
    required int page,
  }) async {
    // Fetch images using dio
    final response = await dio.get('/search/photos', queryParameters: {
      'query': query.isEmpty ? _defaultQuery : query,
      'page': page,
      'client_id': apiKey,
    });

    final result = SearchResultDto.fromJson(response.data);
    return result.results.map((e) => e.toEntity()).toList();
  }
}
