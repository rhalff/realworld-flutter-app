part of blocs.user;

@immutable
abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [props];
}

class LoadUserEvent extends UserEvent {
  @override
  String toString() => 'LoadUser';
}

class UpdateUserEvent extends UserEvent {
  final UpdateUser user;

  const UpdateUserEvent(
    this.user,
  );

  @override
  String toString() => 'UpdateUserEvent: [user: $user]';

  @override
  List<Object> get props => [user];
}

class SignInEvent extends UserEvent {
  final LoginUser user;

  const SignInEvent(this.user);

  @override
  String toString() => 'SignInEvent: [user: $user]';

  @override
  List<Object> get props => [user];
}

class SignUpEvent extends UserEvent {
  final NewUser user;

  SignUpEvent(this.user);

  @override
  List<Object> get props => [user];
}

class ClearUserDataEvent extends UserEvent {}
