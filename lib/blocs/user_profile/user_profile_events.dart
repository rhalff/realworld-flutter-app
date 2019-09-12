part of blocs.user.profile;

@immutable
abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent([List props = const []]) : super(props);
}

class LoadUserProfileEvent extends UserProfileEvent {
  @override
  String toString() => 'LoadUserProfileEvent';
}

class UpdateUserProfileEvent extends UserProfileEvent {
  final UpdateUser user;

  UpdateUserProfileEvent(this.user) : super([user]);

  @override
  String toString() => 'UpdateUserProfileEvent: [user: $user]';
}
