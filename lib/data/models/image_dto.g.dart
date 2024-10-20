// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageDto _$ImageDtoFromJson(Map<String, dynamic> json) => ImageDto(
      id: json['id'] as String,
      description: json['description'] as String?,
      urls: UrlsDto.fromJson(json['urls'] as Map<String, dynamic>),
      user: UserDto.fromJson(json['user'] as Map<String, dynamic>),
      likes: (json['likes'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] as String?,
      color: json['color'] as String?,
    );

Map<String, dynamic> _$ImageDtoToJson(ImageDto instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'urls': instance.urls,
      'user': instance.user,
      'likes': instance.likes,
      'createdAt': instance.createdAt,
      'color': instance.color,
    };
