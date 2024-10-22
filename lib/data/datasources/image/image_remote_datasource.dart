import 'package:images/domain/entities/image_entity.dart';

abstract class ImageRemoteDatasource {
    Future<List<ImageEntity>> getImages({
    required String query,
    required int pageSize,
    required int page,
  });
}
