part of blocs.auth;

@immutable
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class NotAuthenticated extends AuthState {
  @override
  String toString() => 'NotAuthenticated';
}

class Authenticated extends AuthState {
  @override
  String toString() {
    return 'Authenticated[]';
  }
}

class AuthError extends AuthState {
  final Object error;

  AuthError(this.error);

  @override
  String toString() => 'AuthError[error: $error]';

  @override
  List<Object> get props => [error];
}
