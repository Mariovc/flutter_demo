// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'urls_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UrlsDto _$UrlsDtoFromJson(Map<String, dynamic> json) => UrlsDto(
      raw: json['raw'] as String,
      full: json['full'] as String,
      regular: json['regular'] as String,
      small: json['small'] as String,
      thumb: json['thumb'] as String,
      small_s3: json['small_s3'] as String?,
    );

Map<String, dynamic> _$UrlsDtoToJson(UrlsDto instance) => <String, dynamic>{
      'raw': instance.raw,
      'full': instance.full,
      'regular': instance.regular,
      'small': instance.small,
      'thumb': instance.thumb,
      'small_s3': instance.small_s3,
    };
