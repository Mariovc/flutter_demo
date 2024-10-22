import 'package:images/data/datasources/image/image_remote_datasource.dart';
import 'package:images/domain/entities/image_entity.dart';
import 'package:images/domain/repositories/image_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ImageRepository)
class ImageRepositoryImpl implements ImageRepository {
  final ImageRemoteDatasource remoteDataSource;

  ImageRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ImageEntity>> getImages({
    required String query,
    required int pageSize,
    required int page,
  }) {
    return remoteDataSource.getImages(
      query: query,
      pageSize: pageSize,
      page: page,
    );
  }
}
