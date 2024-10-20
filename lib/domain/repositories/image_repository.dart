import 'package:images/domain/entities/image_entity.dart';

abstract class ImageRepository {
    Future<List<ImageEntity>> getImages({
    required String query,
    required int pageSize,
    required int page,
  });
}
