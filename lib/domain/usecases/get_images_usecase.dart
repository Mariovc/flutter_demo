import 'package:images/domain/entities/image_entity.dart';
import 'package:images/domain/repositories/image_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetImagesUseCase {
  final ImageRepository repository;

  GetImagesUseCase(this.repository);

  Future<List<ImageEntity>> call(
   { required String query,
    required int pageSize,
    required int page,}
  ) {
    return repository.getImages(
      query: query,
      pageSize: pageSize,
      page: page,
    );
  }
}
