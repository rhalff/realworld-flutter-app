part of blocs.user;

@immutable
abstract class UserState extends Equatable {
  UserState([List props = const []]) : super(props);
}

class UserUninitialized extends UserState {
  @override
  String toString() => 'UserUninitialized';
}

class UserLoading extends UserState {
  @override
  String toString() => 'UserLoading';
}

class UserSigningIn extends UserState {
  @override
  String toString() => 'UserSigningIn';
}

class UserSigningUp extends UserState {
  @override
  String toString() => 'UserSigningUp';
}

class UserSigningOut extends UserState {
  @override
  String toString() => 'UserSigningOut';
}

class UserLoaded extends UserState {
  final User user;

  UserLoaded(this.user) : super([user]);

  @override
  String toString() {
    return 'UserLoaded[user: $user]';
  }
}

class UserError extends UserState {
  final String error;

  UserError(this.error) : super([error]);

  @override
  String toString() => 'UserError[error: $error]';
}
