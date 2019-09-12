part of blocs.profile;

@immutable
abstract class ProfileState extends Equatable {
  ProfileState([List props = const []]) : super(props);
}

class ProfileUninitialized extends ProfileState {
  @override
  String toString() => 'ProfileUninitialized';
}

class ProfileLoading extends ProfileState {
  @override
  String toString() => 'ProfileLoading';
}

class ProfileLoaded extends ProfileState {
  final Profile profile;

  ProfileLoaded({this.profile}) : super([profile]);

  @override
  String toString() {
    return 'ProfileLoaded[profile: $profile]';
  }
}

class ProfileError extends ProfileState {
  final String error;
  final UpdateUser profile;

  ProfileError({
    this.profile,
    this.error,
  }) : super([error]);

  @override
  String toString() => 'ProfileError[error: $error]';
}
