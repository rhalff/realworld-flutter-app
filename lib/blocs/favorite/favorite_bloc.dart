part of 'bloc.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final ArticlesRepository articlesRepository;

  FavoriteBloc({
    @required this.articlesRepository,
  }) : assert(articlesRepository != null);

  @override
  Stream<FavoriteState> transformEvents(
    Stream<FavoriteEvent> events,
    Stream<FavoriteState> Function(FavoriteEvent event) next,
  ) {
    return super.transformEvents(
      events.debounceTime(
        const Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  FavoriteState get initialState => FavoriteUninitialized();

  @override
  Stream<FavoriteState> mapEventToState(FavoriteEvent event) async* {
    if (event is UpdateFavoriteEvent) {
      yield* _updateFavorite(event);
    }
  }

  Stream<FavoriteState> _updateFavorite(UpdateFavoriteEvent event) async* {
    try {
      yield FavoriteUpdate(
        value: !event.favorited,
        isUpdating: true,
      );

      Article article;
      if (event.favorited) {
        article = await articlesRepository.createFavorite(event.slug);
      } else {
        article = await articlesRepository.deleteArticleFavorite(event.slug);
      }

      yield FavoriteUpdate(
        value: article.favorited,
        isUpdating: false,
      );
    } catch (error) {
      print(error);
      yield FavoriteError('Failed to update favorite');
    }
  }
}
