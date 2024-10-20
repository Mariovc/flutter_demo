// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
      id: json['id'] as String,
      username: json['username'] as String,
      name: json['name'] as String,
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      twitter_username: json['twitter_username'] as String?,
      portfolio_url: json['portfolio_url'] as String?,
      bio: json['bio'] as String?,
      location: json['location'] as String?,
    );

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'name': instance.name,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'twitter_username': instance.twitter_username,
      'portfolio_url': instance.portfolio_url,
      'bio': instance.bio,
      'location': instance.location,
    };
