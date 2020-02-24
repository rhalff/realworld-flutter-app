part of blocs.comments;

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final ArticlesRepository articlesRepository;

  CommentsBloc({
    @required this.articlesRepository,
  }) : assert(articlesRepository != null);

  @override
  CommentsState get initialState => CommentsUninitialized();

  @override
  Stream<CommentsState> mapEventToState(CommentsEvent event) async* {
    if (event is LoadCommentsEvent) {
      yield* _loadComments(event);
    } else if (event is CreateCommentEvent) {
      yield* _createComment(event);
    } else if (event is DeleteCommentEvent) {
      yield* _deleteComment(event);
    }
  }

  Stream<CommentsState> _createComment(CreateCommentEvent event) async* {
    try {
      yield CommentsLoading();
      await articlesRepository.createComment(event.slug, event.comment);

      add(
        LoadCommentsEvent(
          slug: event.slug,
        ),
      );
    } catch (error) {
      print(error);
      yield CommentsError('Failed to create comment');
    }
  }

  Stream<CommentsState> _deleteComment(DeleteCommentEvent event) async* {
    try {
      yield CommentsLoading();
      await articlesRepository.deleteComment(event.slug, event.id);

      add(
        LoadCommentsEvent(
          slug: event.slug,
        ),
      );
    } catch (error) {
      print(error);
      yield CommentsError('Failed to delete comment.');
    }
  }

  Stream<CommentsState> _loadComments(LoadCommentsEvent event) async* {
    try {
      yield CommentsUninitialized();

      final comments = await articlesRepository.getComments(event.slug);

      yield CommentsLoaded(
        comments: comments,
      );

      return;
    } catch (error) {
      print(error);
      yield CommentsError('Failed to load comments');
    }
  }
}
