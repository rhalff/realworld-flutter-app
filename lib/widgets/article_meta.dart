import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../image_cache_manager.dart';
import '../utils.dart';

class ArticleMeta extends StatelessWidget {
  final String avatar;
  final String author;
  final DateTime date;
  final Color color;
  final VoidCallback onTap;
  ArticleMeta({
    this.avatar = '',
    this.author,
    this.date,
    this.color,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Row(
        children: <Widget>[
          avatar != null && avatar.isNotEmpty
              ? CachedNetworkImage(
                  cacheManager: ImageCacheManager(),
                  imageUrl: avatar,
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    radius: 14,
                    backgroundImage: imageProvider,
                  ),
                  placeholder: (context, url) => const CircleAvatar(
                    radius: 14,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.0,
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                )
              : const CircleAvatar(radius: 14),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (author != null)
                Text(
                  author,
                  style: TextStyle(
                    color: color ?? theme.primaryColor,
                    fontFamily: 'SourceSansPro',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              if (date != null)
                Text(
                  formatDate(date),
                  style: TextStyle(
                    color: const Color(0XFFBBBBBB),
                    fontSize: 12,
                    fontFamily: 'SourceSansPro',
                    fontWeight: FontWeight.w300,
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}
