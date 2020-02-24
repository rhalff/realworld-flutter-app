part of repositories.user;

abstract class UserRepositoryEvent {}

class UserCreatedEvent extends UserRepositoryEvent {
  final User user;

  UserCreatedEvent({this.user});
}

class UserUpdatedEvent extends UserRepositoryEvent {
  final User user;

  UserUpdatedEvent({this.user});
}
