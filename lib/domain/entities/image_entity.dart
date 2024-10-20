import 'package:flutter/material.dart';
import 'package:images/domain/entities/user.dart';

class ImageEntity {
  final String id;
  final DateTime createdAt;
  final Color color;
  final String description;
  final String url;
  final int likes;
  final ImageUser user;

  ImageEntity({
    required this.id,
    required this.description,
    required this.url,
    required this.likes,
    required this.user,
    required this.createdAt,
    required this.color,
  });
}
