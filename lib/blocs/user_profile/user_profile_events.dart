part of blocs.user.profile;

@immutable
abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadUserProfileEvent extends UserProfileEvent {
  @override
  String toString() => 'LoadUserProfileEvent';
}

class UpdateUserProfileEvent extends UserProfileEvent {
  final UpdateUser user;

  UpdateUserProfileEvent(this.user);

  @override
  String toString() => 'UpdateUserProfileEvent: [user: $user]';

  @override
  List<Object> get props => [user];
}
