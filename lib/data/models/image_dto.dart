import 'package:flutter/material.dart';
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
  final int likes;
  final String? createdAt;
  final String? color;

  ImageDto({
    required this.id,
    required this.description,
    required this.urls,
    required this.user,
    this.likes = 0,
    this.createdAt,
    this.color,
  });

  factory ImageDto.fromJson(Map<String, dynamic> json) =>
      _$ImageDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ImageDtoToJson(this);
  ImageEntity toEntity() {
    return ImageEntity(
      id: id,
      description: description ?? '',
      url: urls.regular,
      likes: likes,
      user: user.toEntity(),
      createdAt:
          createdAt != null ? DateTime.parse(createdAt!) : DateTime.now(),
      color: color != null
          ? Color(int.parse(color!.substring(1, 7), radix: 16) + 0xFF000000)
          : Colors.white,
    );
  }
}
