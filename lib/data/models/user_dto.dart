import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  final String id;
  final String username;
  final String name;
  final String? first_name;
  final String? last_name;
  final String? twitter_username;
  final String? portfolio_url;
  final String? bio;
  final String? location;

  UserDto({
    required this.id,
    required this.username,
    required this.name,
    this.first_name,
    this.last_name,
    this.twitter_username,
    this.portfolio_url,
    this.bio,
    this.location,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}