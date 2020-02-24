part of blocs.profile;

@immutable
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadProfileEvent extends ProfileEvent {
  final String username;

  const LoadProfileEvent({
    @required this.username,
  });

  @override
  String toString() => 'LoadProfileEvent(username: username)';

  @override
  List<Object> get props => [username];
}

class ReloadProfileEvent extends ProfileEvent {
  @override
  String toString() => 'ReloadProfileEvent()';
}

class ToggleFollowUserEvent extends ProfileEvent {
  final String username;

  const ToggleFollowUserEvent({
    @required this.username,
  });

  @override
  String toString() => 'FollowUserEvent(username: $username)';

  @override
  List<Object> get props => [username];
}
