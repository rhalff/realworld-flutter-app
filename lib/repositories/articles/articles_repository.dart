part of repositories.articles;

class ArticlesRepository extends EventEmitter {
  ArticlesApi articlesApi;
  CommentsApi commentsApi;
  TagsApi tagsApi;
  FavoritesApi favoritesApi;

  ArticlesRepository({
    this.articlesApi,
    this.commentsApi,
    this.favoritesApi,
    this.tagsApi,
  });

  Future<Article> getArticle(String slug) async {
    final result = await articlesApi.getArticle(slug);

    return result.article;
  }

  Future<MultipleArticlesResponse> getArticles({
    String tag,
    String author,
    String favorited,
    int limit,
    int offset,
  }) async {
    final result = await articlesApi.getArticles(
      tag,
      author,
      favorited,
      limit,
      offset,
    );

    return result;
  }

  Future<MultipleArticlesResponse> getArticlesFeed({
    int limit,
    int offset,
  }) async {
    final result = articlesApi.getArticlesFeed(limit, offset);

    return result;
  }

  Future<Article> createArticle(ArticleSubmission article) async {
    final result = await articlesApi.createArticle(
      ArticleSubmissionRequest(article: article),
    );

    fire(ArticleCreatedEvent(article: result.article));

    return result.article;
  }

  Future<Article> updateArticle(String slug, ArticleSubmission article) async {
    final result = await articlesApi.updateArticle(
      slug,
      ArticleSubmissionRequest(article: article),
    );

    fire(ArticleUpdatedEvent(article: result.article));

    return result.article;
  }

  Future<void> deleteArticle(String slug) async {
    await articlesApi.deleteArticle(slug);

    fire(ArticleDeletedEvent(slug: slug));
  }

  Future<List<Comment>> getComments(String slug) async {
    final result = await commentsApi.getArticleComments(slug);

    return result.comments;
  }

  Future<Comment> createComment(
    String slug,
    NewComment comment,
  ) async {
    final result = await commentsApi.createArticleComment(
      slug,
      NewCommentRequest(comment: comment),
    );

    fire(CommentCreatedEvent(slug: slug, comment: result.comment));

    return result.comment;
  }

  Future<void> deleteComment(String slug, int id) async {
    await commentsApi.deleteArticleComment(slug, id);

    fire(CommentDeletedEvent(slug: slug, id: id));
  }

  Future<List<String>> getTags() async {
    final result = await tagsApi.tagsGet();

    return result.tags;
  }

  Future<Article> createFavorite(String slug) async {
    final result = await favoritesApi.createArticleFavorite(slug);

    fire(FavoriteCreatedEvent(slug: slug, article: result.article));

    return result.article;
  }

  Future<Article> deleteArticleFavorite(String slug) async {
    final result = await favoritesApi.deleteArticleFavorite(slug);

    fire(FavoriteDeletedEvent(slug: slug, article: result.article));

    return result.article;
  }
}
