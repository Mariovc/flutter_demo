import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:images/domain/entities/image_entity.dart';
import 'package:images/presentation/viewmodels/detail_viewmodel.dart';
import 'package:images/presentation/widgets/pages/root_page.dart';
import 'package:intl/intl.dart';

class DetailPage extends RootPage<DetailViewState, DetailViewModel> {
  final ImageEntity image;

  const DetailPage({super.key, required this.image});

  @override
  Widget buildView(
    BuildContext context,
    DetailViewState state,
    DetailViewModel viewModel,
  ) {
    final appBarColor =
        image.color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
    return Scaffold(
      appBar: AppBar(
        title: Text(image.user.name, style: TextStyle(color: appBarColor)),
        backgroundColor: image.color,
        iconTheme: Theme.of(context).iconTheme.copyWith(color: appBarColor),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: image.id,
              child: CachedNetworkImage(
                imageUrl: image.url,
                placeholder: (context, url) => Container(
                  height: 300.0,
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: Icon(
                    Icons.image,
                    size: 50.0,
                    color: Colors.grey.withOpacity(0.4),
                  ),
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.error,
                  size: 50.0,
                  color: Colors.red.withOpacity(0.4),
                ),
                height: 300.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.favorite, color: Colors.red),
                      const SizedBox(width: 5),
                      Text(
                        '${image.likes} likes', // TODO localize
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  if (image.description.isNotEmpty) const SizedBox(height: 10),
                  if (image.description.isNotEmpty)
                    Text(
                      image.description,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: image.user.profileImage == null
                            ? null
                            : NetworkImage(image.user.profileImage!),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            image.user.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            image.user.instagramUsername != null
                                ? '@${image.user.instagramUsername}'
                                : '',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Posted on ${DateFormat.yMMMd().format(image.createdAt)}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildUserInfo(
                        icon: Icons.photo,
                        label: 'Photos',
                        value: image.user.totalPhotos.toString(),
                      ),
                      _buildUserInfo(
                        icon: Icons.collections,
                        label: 'Collections',
                        value: image.user.totalCollections.toString(),
                      ),
                      _buildUserInfo(
                        icon: Icons.thumb_up,
                        label: 'Likes',
                        value: image.user.totalLikes.toString(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.grey),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
