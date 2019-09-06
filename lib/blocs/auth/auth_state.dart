import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthState extends Equatable {
  AuthState([List props = const []]) : super(props);
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

  AuthError(this.error) : super([error]);

  @override
  String toString() => 'AuthError[error: $error]';
}
