import 'package:json_annotation/json_annotation.dart';
import 'image_dto.dart';

part 'search_result_dto.g.dart';

@JsonSerializable()
class SearchResultDto {
  final int total;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  final List<ImageDto> results;

  SearchResultDto({
    required this.total,
    required this.totalPages,
    required this.results,
  });

  factory SearchResultDto.fromJson(Map<String, dynamic> json) =>
      _$SearchResultDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SearchResultDtoToJson(this);
}
