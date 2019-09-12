part of blocs.favorite;

@immutable
abstract class FavoriteState extends Equatable {
  FavoriteState([List props = const []]) : super(props);
}

class FavoriteIdle extends FavoriteState {
  @override
  String toString() => 'FavoriteIdle';
}

class FavoriteUpdating extends FavoriteState {
  @override
  String toString() => 'FavoriteUpdating';
}

class FavoriteError extends FavoriteState {
  final String error;

  FavoriteError(this.error) : super([error]);

  @override
  String toString() => 'FavoriteError[error: $error]';
}
