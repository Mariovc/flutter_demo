import 'package:images/data/models/profile_image_dto.dart';
import 'package:images/domain/entities/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  final String id;
  final String username;
  final String name;

  @JsonKey(name: 'first_name')
  final String? firstName;

  @JsonKey(name: 'last_name')
  final String? lastName;

  @JsonKey(name: 'twitter_username')
  final String? twitterUsername;

  @JsonKey(name: 'portfolio_url')
  final String? portfolioUrl;

  final String? bio;
  final String? location;

  @JsonKey(name: 'profile_image')
  final ProfileImageDto? profileImage;

  @JsonKey(name: 'total_likes')
  final int totalLikes;

  @JsonKey(name: 'total_photos')
  final int totalPhotos;

  @JsonKey(name: 'total_collections')
  final int totalCollections;

  @JsonKey(name: 'instagram_username')
  final String? instagramUsername;

  UserDto({
    required this.id,
    required this.username,
    required this.name,
    this.firstName,
    this.lastName,
    this.twitterUsername,
    this.portfolioUrl,
    this.bio,
    this.location,
    this.profileImage,
    this.totalLikes = 0,
    this.totalPhotos = 0,
    this.totalCollections = 0,
    this.instagramUsername,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  ImageUser toEntity() {
    return ImageUser(
      name: name,
      location: location ?? '',
      profileImage:
          profileImage?.small ?? profileImage?.medium ?? profileImage?.large,
      totalLikes: totalLikes,
      totalPhotos: totalPhotos,
      totalCollections: totalCollections,
      instagramUsername: instagramUsername,
    );
  }
}
