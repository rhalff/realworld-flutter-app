import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:realworld_flutter/model/profile.dart';
import 'package:validations/annotations/mixed.dart';
import 'package:validations/validations.dart';

part 'article.g.dart';
part 'article.jser.dart';

class Article {
  @Alias('slug', isNullable: false)
  final String slug;

  @Alias('title', isNullable: false)
  @NotEmpty()
  final String title;

  @Alias('description', isNullable: false)
  @Size(
    min: 1,
    max: 500,
  )
  final String description;

  @Alias('body', isNullable: false)
  @NotEmpty()
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

  Article({
    this.slug,
    this.title,
    this.description,
    this.body,
    this.tagList = const [],
    this.createdAt,
    this.updatedAt,
    this.favorited,
    this.favoritesCount,
    this.author,
  });

  @override
  String toString() {
    return 'Article[slug=$slug, title=$title, description=$description, body=$body, tagList=$tagList, createdAt=$createdAt, updatedAt=$updatedAt, favorited=$favorited, favoritesCount=$favoritesCount, author=$author, ]';
  }

  Article copyWith({
    String slug,
    String title,
    String description,
    String body,
    List<String> tagList,
    DateTime createdAt,
    DateTime updatedAt,
    bool favorited,
    int favoritesCount,
    Profile author,
  }) {
    return Article(
      slug: slug ?? this.slug,
      title: title ?? this.title,
      description: description ?? this.description,
      body: body ?? this.body,
      tagList: tagList ?? this.tagList,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      favorited: favorited ?? this.favorited,
      favoritesCount: favoritesCount ?? this.favoritesCount,
      author: author ?? this.author,
    );
  }
}

@GenSerializer(nullableFields: true)
class ArticleSerializer extends Serializer<Article> with _$ArticleSerializer {}

@GenValidator(fields: {})
class ArticleValidator extends Validator<Article> with _$ArticleValidator {}
