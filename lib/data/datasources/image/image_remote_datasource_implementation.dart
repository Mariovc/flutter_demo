import 'package:either_dart/either.dart';
import 'package:images/core/di/environment.dart';
import 'package:images/data/datasources/image/image_remote_datasource.dart';
import 'package:images/data/models/search_result_dto.dart';
import 'package:images/data/services/api_service.dart';
import 'package:images/domain/entities/errors.dart';
import 'package:images/domain/entities/image_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ImageRemoteDatasource)
class ImageRepositoryImpl implements ImageRemoteDatasource {
  final ApiService _apiService;
  final Env _envConfig;
  final String _defaultQuery = '*';

  ImageRepositoryImpl(this._apiService, this._envConfig);

  @override
  Future<Either<MainError, List<ImageEntity>>> getImages({
    required String query,
    required int pageSize,
    required int page,
  }) async {
    // Fetch images using dio
    final response = await _apiService.get<Map<String, dynamic>>(
      Uri.https(
        _envConfig.baseUrl,
        '/search/photos',
        {
          'query': query.isEmpty ? _defaultQuery : query,
          'page': page.toString(),
          'client_id': _envConfig.apiKey,
        },
      ),
    );

    return response.map((data) {
      final result = SearchResultDto.fromJson(data);
      return result.results.map((e) => e.toEntity()).toList();
      
    });
  }
}
