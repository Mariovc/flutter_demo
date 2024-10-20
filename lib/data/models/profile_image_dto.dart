import 'package:json_annotation/json_annotation.dart';

part 'profile_image_dto.g.dart';

@JsonSerializable()
class ProfileImageDto {
  final String small;
  final String medium;
  final String large;

  ProfileImageDto({
    required this.small,
    required this.medium,
    required this.large,
  });

  factory ProfileImageDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileImageDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileImageDtoToJson(this);
}
