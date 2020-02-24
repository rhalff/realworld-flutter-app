part of blocs.user.profile;

@immutable
abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

class UserProfileUninitialized extends UserProfileState {
  @override
  String toString() => 'UserProfileUninitialized';
}

class UserProfileLoading extends UserProfileState {
  @override
  String toString() => 'UserProfileLoading';
}

class UserProfileLoaded extends UserProfileState {
  final UpdateUser user;

  const UserProfileLoaded(this.user);

  @override
  String toString() {
    return 'UserProfileLoaded[user: $user]';
  }

  @override
  List<Object> get props => [user];
}

class UserProfileError extends UserProfileState {
  final String error;
  final UpdateUser user;

  const UserProfileError({
    this.user,
    this.error,
  });

  @override
  String toString() => 'UserProfileError[error: $error]';

  @override
  List<Object> get props => [error];
}
