part of blocs.profile;

@immutable
abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
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

  const ProfileLoaded({this.profile});

  @override
  String toString() {
    return 'ProfileLoaded[profile: $profile]';
  }

  @override
  List<Object> get props => [profile];
}

class ProfileError extends ProfileState {
  final String error;
  final UpdateUser profile;

  const ProfileError({
    this.profile,
    this.error,
  });

  @override
  String toString() => 'ProfileError[error: $error]';

  @override
  List<Object> get props => [error];
}
