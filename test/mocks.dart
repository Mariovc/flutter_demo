import 'dart:ui';

import 'package:images/domain/entities/image_entity.dart';
import 'package:images/domain/entities/user.dart';

ImageEntity createImage() {
  return ImageEntity(
    id: '1',
    description: 'Test Image',
    url: 'https://via.placeholder.com/150',
    likes: 0,
    user: ImageUser(
      name: 'Test User',
      instagramUsername: 'testuser',
      profileImage: 'https://via.placeholder.com/150',
      totalCollections: 1,
      totalLikes: 1,
      totalPhotos: 1,
      location: 'Test Location',
    ),
    createdAt: DateTime.now(),
    color: const Color(0xFF000000),
  );
}