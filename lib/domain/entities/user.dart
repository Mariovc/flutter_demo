class ImageUser {
  final String name;
  final String location;
  final String? profileImage;
  final int totalLikes;
  final int totalPhotos;
  final int totalCollections;
  final String? instagramUsername;

  ImageUser({
    required this.name,
    required this.location,
    this.profileImage,
    required this.totalLikes,
    required this.totalPhotos,
    required this.totalCollections,
    this.instagramUsername,
  });
}
