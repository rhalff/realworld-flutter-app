part of blocs.favorite;

@immutable
abstract class FavoriteState extends Equatable {
  FavoriteState([List props = const []]) : super(props);
}

class FavoriteUninitialized extends FavoriteState {
  @override
  String toString() => 'FavoriteUninitialized';
}

class FavoriteUpdate extends FavoriteState {
  final bool value;
  final bool isUpdating;
  FavoriteUpdate({
    this.value,
    this.isUpdating = false,
  }) : super([value, isUpdating]);
  @override
  String toString() => 'FavoriteUpdate(value: $value, isUpdating: $isUpdating';
}

class FavoriteError extends FavoriteState {
  final String error;

  FavoriteError(this.error) : super([error]);

  @override
  String toString() => 'FavoriteError[error: $error]';
}
