import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:realworld_flutter/image_cache_manager.dart';

class UserAvatar extends StatelessWidget {
  final String avatar;
  final double radius;
  UserAvatar({
    this.avatar,
    this.radius = 14.0,
  });
  @override
  Widget build(BuildContext context) {
    return avatar != null && avatar.isNotEmpty
        ? CachedNetworkImage(
            cacheManager: ImageCacheManager(),
            imageUrl: avatar,
            imageBuilder: (context, imageProvider) => CircleAvatar(
              radius: radius,
              backgroundImage: imageProvider,
            ),
            placeholder: (context, url) => CircleAvatar(
              radius: radius,
              child: const CircularProgressIndicator(
                strokeWidth: 1.0,
              ),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          )
        : CircleAvatar(radius: radius);
  }
}
