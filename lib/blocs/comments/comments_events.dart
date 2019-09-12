part of blocs.comments;

abstract class CommentsEvent extends Equatable {
  CommentsEvent([props]) : super([props]);
}

@immutable
class LoadCommentsEvent extends CommentsEvent {
  final String slug;
  LoadCommentsEvent({
    this.slug,
  }) : super([slug]);
  @override
  String toString() => 'LoadComments[slug: $slug]';
}

@immutable
class CreateCommentEvent extends CommentsEvent {
  final String slug;
  final NewComment comment;
  CreateCommentEvent({
    this.slug,
    this.comment,
  });
  @override
  String toString() => 'CreateCommentEvent[slug: $slug, comment: $comment]';
}

@immutable
class DeleteCommentEvent extends CommentsEvent {
  final String slug;
  final int id;
  DeleteCommentEvent({
    this.slug,
    this.id,
  });
  @override
  String toString() => 'DeleteCommentEvent[slug: $slug, id: $id]';
}
