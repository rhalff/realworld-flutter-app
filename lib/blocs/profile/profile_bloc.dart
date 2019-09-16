part of blocs.profile;

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository userRepository;

  ProfileBloc({
    @required this.userRepository,
  }) {
    assert(userRepository != null);

    userRepository.addListener(_reloadHandler);
  }

  void _reloadHandler() {
    if (currentState is ProfileLoaded) {
      dispatch(
        LoadProfileEvent(
          username: (currentState as ProfileLoaded).profile.username,
        ),
      );
    }
  }

  @override
  ProfileState get initialState => ProfileUninitialized();

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is LoadProfileEvent) {
      yield* _loadProfile(event);
    } else if (event is ToggleFollowUserEvent) {
      yield* _toggleFollowUser(event);
    }
  }

  Stream<ProfileState> _loadProfile(LoadProfileEvent event) async* {
    try {
      yield ProfileLoading();
      final profile = await userRepository.getProfileByUsername(event.username);

      yield ProfileLoaded(profile: profile);
    } catch (error) {
      yield ProfileError(
        error: _parseError(error),
      );
    }
  }

  Stream<ProfileState> _toggleFollowUser(ToggleFollowUserEvent event) async* {
    if (currentState is ProfileLoaded) {
      var profile = (currentState as ProfileLoaded).profile;
      try {
        yield ProfileLoading();

        if (profile.following) {
          profile = await userRepository.unFollowUser(event.username);
        } else {
          profile = await userRepository.followUser(event.username);
        }

        yield ProfileLoaded(profile: profile);
      } catch (error) {
        yield ProfileError(
          error: _parseError(error),
        );
      }
    }
  }

  String _parseError(Object error) {
    if (error is StringResponse) {
      final body = jsonDecode(error.body) as Map<String, dynamic>;

      if (body['error'] != null && body['error']['message'] != null) {
        return body['error']['message'] as String;
      }
    }

    return error.toString();
  }

  @override
  void dispose() {
    userRepository.removeListener(_reloadHandler);
    super.dispose();
  }
}
