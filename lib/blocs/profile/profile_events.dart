part of blocs.profile;

@immutable
abstract class ProfileEvent extends Equatable {
  const ProfileEvent([List props = const []]) : super(props);
}

class LoadProfileEvent extends ProfileEvent {
  final String username;
  LoadProfileEvent({
    @required this.username,
  }) : super([username]);
  @override
  String toString() => 'LoadProfileEvent(username: username)';
}

class ToggleFollowUserEvent extends ProfileEvent {
  final String username;
  ToggleFollowUserEvent({
    @required this.username,
  }) : super([username]);
  @override
  String toString() => 'FollowUserEvent(username: $username)';
}
