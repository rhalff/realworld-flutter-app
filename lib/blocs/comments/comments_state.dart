part of blocs.comments;

@immutable
abstract class CommentsState extends Equatable {
  const CommentsState();

  @override
  List<Object> get props => [];
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
  });

  @override
  String toString() {
    return 'CommentsLoaded[comments: $comments]';
  }

  @override
  List<Object> get props => [comments];
}

class CommentsError extends CommentsState {
  final String error;

  CommentsError(this.error);

  @override
  String toString() => 'CommentsError[error: $error]';

  @override
  List<Object> get props => [error];
}
