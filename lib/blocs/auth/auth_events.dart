import 'package:meta/meta.dart';

@immutable
abstract class AuthEvent {}

class SignedIn extends AuthEvent {
  final String accessToken;
  SignedIn({
    this.accessToken,
  });
}

class SignOut extends AuthEvent {}
