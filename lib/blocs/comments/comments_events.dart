part of blocs.comments;

abstract class CommentsEvent extends Equatable {
  const CommentsEvent();

  @override
  List<Object> get props => [props];
}

@immutable
class LoadCommentsEvent extends CommentsEvent {
  final String slug;

  LoadCommentsEvent({
    @required this.slug,
  });

  @override
  String toString() => 'LoadComments[slug: $slug]';

  @override
  List<Object> get props => [slug];
}

@immutable
class CreateCommentEvent extends CommentsEvent {
  final String slug;
  final NewComment comment;

  CreateCommentEvent({
    @required this.slug,
    @required this.comment,
  });

  @override
  String toString() => 'CreateCommentEvent[slug: $slug, comment: $comment]';

  @override
  List<Object> get props => [slug, comment];
}

@immutable
class DeleteCommentEvent extends CommentsEvent {
  final String slug;
  final int id;

  DeleteCommentEvent({
    @required this.slug,
    @required this.id,
  });

  @override
  String toString() => 'DeleteCommentEvent[slug: $slug, id: $id]';

  @override
  List<Object> get props => [slug, id];
}
