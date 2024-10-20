import 'package:images/domain/entities/image_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'urls_dto.dart';
import 'user_dto.dart';

part 'image_dto.g.dart';

@JsonSerializable()
class ImageDto {
  final String id;
  final String? description;
  final UrlsDto urls;
  final UserDto user;

  ImageDto({
    required this.id,
    required this.description,
    required this.urls,
    required this.user,
  });

  factory ImageDto.fromJson(Map<String, dynamic> json) =>
      _$ImageDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ImageDtoToJson(this);
  ImageEntity toEntity() {
    return ImageEntity(id: id, title: description ?? '', url: urls.regular);
  }
}
