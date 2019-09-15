part of blocs.user.profile;

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UserRepository userRepository;
  final UserBloc userBloc;

  UserProfileBloc({
    @required this.userRepository,
    @required this.userBloc,
  }) {
    assert(userRepository != null);
    assert(userBloc != null);
  }

  @override
  UserProfileState get initialState => UserProfileUninitialized();

  @override
  Stream<UserProfileState> mapEventToState(UserProfileEvent event) async* {
    if (event is LoadUserProfileEvent) {
      yield* _loadUserProfile(event);
    } else if (event is UpdateUserProfileEvent) {
      yield* _updateUser(event);
    }
  }

  Stream<UserProfileState> _loadUserProfile(LoadUserProfileEvent event) async* {
    try {
      yield UserProfileLoading();
      final user = await userRepository.getCurrentUser();

      yield UserProfileLoaded(
        UpdateUser(
          username: user.username,
          email: user.email,
          token: user.token,
          bio: user.bio,
          image: user.image,
        ),
      );
    } catch (error) {
      yield UserProfileError(
        user: null,
        error: _parseError(error),
      );
    }
  }

  Stream<UserProfileState> _updateUser(UpdateUserProfileEvent event) async* {
    try {
      yield UserProfileLoading();

      final user = await userRepository.updateCurrentUser(event.user);

      // reload user
      userBloc.dispatch(LoadUserEvent());

      yield UserProfileLoaded(
        UpdateUser(
          username: user.username,
          email: user.email,
          token: user.token,
          bio: user.bio,
          image: user.image,
        ),
      );
    } catch (error) {
      yield UserProfileError(
        user: event.user,
        error: _parseError(error),
      );
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
}
