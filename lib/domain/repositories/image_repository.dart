import 'package:either_dart/either.dart';
import 'package:images/domain/entities/errors.dart';
import 'package:images/domain/entities/image_entity.dart';

abstract class ImageRepository {
  Future<Either<MainError, List<ImageEntity>>> getImages({
    required String query,
    required int pageSize,
    required int page,
  });
}
