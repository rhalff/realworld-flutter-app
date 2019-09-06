import 'package:jaguar_serializer/jaguar_serializer.dart';

import 'package:realworld_flutter/model/profile.dart';

part 'article.jser.dart';

class Article {
  @Alias('slug', isNullable: false)
  final String slug;

  @Alias('title', isNullable: false)
  final String title;

  @Alias('description', isNullable: false)
  final String description;

  @Alias('body', isNullable: false)
  final String body;

  @Alias('tagList', isNullable: false)
  final List<String> tagList;

  @Alias('createdAt', isNullable: false)
  final DateTime createdAt;

  @Alias('updatedAt', isNullable: false)
  final DateTime updatedAt;

  @Alias('favorited', isNullable: false)
  final bool favorited;

  @Alias('favoritesCount', isNullable: false)
  final int favoritesCount;

  @Alias('author', isNullable: false)
  final Profile author;

  Article(
      {this.slug = null,
      this.title = null,
      this.description = null,
      this.body = null,
      this.tagList = const [],
      this.createdAt = null,
      this.updatedAt = null,
      this.favorited = null,
      this.favoritesCount = null,
      this.author = null});

  @override
  String toString() {
    return 'Article[slug=$slug, title=$title, description=$description, body=$body, tagList=$tagList, createdAt=$createdAt, updatedAt=$updatedAt, favorited=$favorited, favoritesCount=$favoritesCount, author=$author, ]';
  }
}

@GenSerializer(nullableFields: true)
class ArticleSerializer extends Serializer<Article> with _$ArticleSerializer {}
