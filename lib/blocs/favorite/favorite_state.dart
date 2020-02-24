part of blocs.favorite;

@immutable
abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteUninitialized extends FavoriteState {
  @override
  String toString() => 'FavoriteUninitialized';
}

class FavoriteUpdate extends FavoriteState {
  final bool value;
  final bool isUpdating;

  const FavoriteUpdate({
    this.value,
    this.isUpdating = false,
  });

  @override
  String toString() => 'FavoriteUpdate(value: $value, isUpdating: $isUpdating';

  @override
  List<Object> get props => [value, isUpdating];
}

class FavoriteError extends FavoriteState {
  final String error;

  const FavoriteError(this.error);

  @override
  String toString() => 'FavoriteError[error: $error]';

  @override
  List<Object> get props => [error];
}
