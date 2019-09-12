part of blocs.user.profile;

@immutable
abstract class UserProfileState extends Equatable {
  UserProfileState([List props = const []]) : super(props);
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

  UserProfileLoaded(this.user) : super([user]);

  @override
  String toString() {
    return 'UserProfileLoaded[user: $user]';
  }
}

class UserProfileError extends UserProfileState {
  final String error;
  final UpdateUser user;

  UserProfileError({
    this.user,
    this.error,
  }) : super([error]);

  @override
  String toString() => 'UserProfileError[error: $error]';
}
