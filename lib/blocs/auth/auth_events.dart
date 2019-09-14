part of blocs.auth;

@immutable
abstract class AuthEvent {}

class SignedInEvent extends AuthEvent {
  final String accessToken;
  SignedInEvent({
    @required this.accessToken,
  });
}

class SignOutEvent extends AuthEvent {
  final Function() onComplete;
  SignOutEvent({
    this.onComplete,
  });
}
