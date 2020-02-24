part of blocs.user;

@immutable
abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
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

  const UserLoaded(this.user);

  @override
  String toString() {
    return 'UserLoaded[user: $user]';
  }

  @override
  List<Object> get props => [user];
}

class UserError extends UserState {
  final List<String> errors;

  const UserError(this.errors);

  @override
  String toString() => 'UserError[errors: $errors]';

  @override
  List<Object> get props => [errors];
}
