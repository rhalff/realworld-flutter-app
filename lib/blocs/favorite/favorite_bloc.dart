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
      (events as Observable<FavoriteEvent>).debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  FavoriteState get initialState => FavoriteIdle();

  @override
  Stream<FavoriteState> mapEventToState(FavoriteEvent event) async* {
    if (event is UpdateFavoriteEvent) {
      yield* _updateFavorite(event);
    }
  }

  Stream<FavoriteState> _updateFavorite(UpdateFavoriteEvent event) async* {
    try {
      yield FavoriteUpdating();

      if (event.favorited) {
        await articlesRepository.createFavorite(event.slug);
      } else {
        await articlesRepository.deleteArticleFavorite(event.slug);
      }

      yield FavoriteIdle();
    } catch (error) {
      print(error);
      yield FavoriteError('Failed to update favorite');
    }
  }
}
