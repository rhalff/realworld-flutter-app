part of blocs.comments;

@immutable
abstract class CommentsState extends Equatable {
  CommentsState([List props = const []]) : super(props);
}

class CommentsUninitialized extends CommentsState {
  @override
  String toString() => 'CommentsUninitialized';
}

class CommentsLoading extends CommentsState {
  @override
  String toString() => 'CommentsLoading';
}

class CommentsLoaded extends CommentsState {
  final List<Comment> comments;

  CommentsLoaded({
    this.comments,
  }) : super([comments]);

  @override
  String toString() {
    return 'CommentsLoaded[comments: $comments]';
  }
}

class CommentsError extends CommentsState {
  final String error;

  CommentsError(this.error) : super([error]);

  @override
  String toString() => 'CommentsError[error: $error]';
}
