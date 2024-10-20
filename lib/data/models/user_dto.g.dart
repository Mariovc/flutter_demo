// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
      id: json['id'] as String,
      username: json['username'] as String,
      name: json['name'] as String,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      twitterUsername: json['twitter_username'] as String?,
      portfolioUrl: json['portfolio_url'] as String?,
      bio: json['bio'] as String?,
      location: json['location'] as String?,
      profileImage: json['profile_image'] == null
          ? null
          : ProfileImageDto.fromJson(
              json['profile_image'] as Map<String, dynamic>),
      totalLikes: (json['total_likes'] as num?)?.toInt() ?? 0,
      totalPhotos: (json['total_photos'] as num?)?.toInt() ?? 0,
      totalCollections: (json['total_collections'] as num?)?.toInt() ?? 0,
      instagramUsername: json['instagram_username'] as String?,
    );

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'name': instance.name,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'twitter_username': instance.twitterUsername,
      'portfolio_url': instance.portfolioUrl,
      'bio': instance.bio,
      'location': instance.location,
      'profile_image': instance.profileImage,
      'total_likes': instance.totalLikes,
      'total_photos': instance.totalPhotos,
      'total_collections': instance.totalCollections,
      'instagram_username': instance.instagramUsername,
    };
