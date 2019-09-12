part of blocs.auth;

@immutable
abstract class AuthEvent {}

class SignedInEvent extends AuthEvent {
  final String accessToken;
  SignedInEvent({
    this.accessToken,
  });
}

class SignOutEvent extends AuthEvent {}
