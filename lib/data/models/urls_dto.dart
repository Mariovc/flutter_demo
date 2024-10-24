import 'package:json_annotation/json_annotation.dart';

part 'urls_dto.g.dart';

@JsonSerializable()
class UrlsDto {
  final String raw;
  final String full;
  final String regular;
  final String small;
  final String thumb;
  @JsonKey(name: 'small_s3')
  final String? smallS3;

  UrlsDto({
    required this.raw,
    required this.full,
    required this.regular,
    required this.small,
    required this.thumb,
    this.smallS3,
  });

  factory UrlsDto.fromJson(Map<String, dynamic> json) =>
      _$UrlsDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UrlsDtoToJson(this);
}
