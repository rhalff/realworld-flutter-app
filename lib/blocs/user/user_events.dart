part of blocs.user;

@immutable
abstract class UserEvent extends Equatable {
  const UserEvent([List props = const []]) : super(props);
}

class LoadUserEvent extends UserEvent {
  @override
  String toString() => 'LoadUser';
}

class UpdateUserEvent extends UserEvent {
  final UpdateUser user;

  UpdateUserEvent(this.user) : super([user]);

  @override
  String toString() => 'UpdateUserEvent: [user: $user]';
}

class SignInEvent extends UserEvent {
  final LoginUser user;
  SignInEvent(this.user) : super([user]);
  @override
  String toString() => 'SignInEvent: [user: $user]';
}

class SignUpEvent extends UserEvent {
  final NewUser user;
  SignUpEvent(this.user) : super([user]);
}

class ClearUserDataEvent extends UserEvent {}
