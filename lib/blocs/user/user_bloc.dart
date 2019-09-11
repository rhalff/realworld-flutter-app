part of user.blocs;

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  final AuthBloc authBloc;
  StreamSubscription _authBlocSubscription;

  UserBloc({
    @required this.userRepository,
    @required this.authBloc,
  }) {
    assert(userRepository != null);
    assert(authBloc != null);

    _authBlocSubscription = authBloc.state.listen((state) {
      if (state is SignOutEvent) {
        dispatch(ClearUserDataEvent());
      }
    });
  }

  @override
  void dispose() {
    _authBlocSubscription.cancel();
    super.dispose();
  }

  @override
  UserState get initialState => UserUninitialized();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is LoadUserEvent) {
      yield* _loadUser(event);
    } else if (event is SignInEvent) {
      yield* _signIn(event);
    } else if (event is SignUpEvent) {
      yield* _signUp(event);
    } else if (event is ClearUserDataEvent) {
      yield* _clearUserData();
    } else if (event is UpdateUserEvent) {
      yield* _updateUser(event);
    }
  }

  Stream<UserState> _loadUser(LoadUserEvent event) async* {
    try {
      yield UserLoading();
      final user = await userRepository.getCurrentUser();

      yield UserLoaded(user);
    } catch (error) {
      yield UserError(_parseError(error));
    }
  }

  Stream<UserState> _updateUser(UpdateUserEvent event) async* {
    try {
      yield UserLoading();

      final user = await userRepository.updateCurrentUser(event.user);

      yield UserLoaded(user);
    } catch (error) {
      yield UserError(_parseError(error));
    }
  }

  Stream<UserState> _signIn(SignInEvent event) async* {
    try {
      yield UserSigningIn();
      final user = await userRepository.login(event.user);

      authBloc.dispatch(SignedInEvent(accessToken: user.token));

      yield UserLoaded(user);
    } catch (error) {
      yield UserError(_parseError(error));
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

  Stream<UserState> _signUp(SignUpEvent event) async* {
    try {
      yield UserSigningUp();

      final user = await userRepository.signUp(event.user);

      authBloc.dispatch(SignedInEvent(accessToken: user.token));

      yield UserLoaded(user);
    } catch (error) {
      yield UserError(_parseError(error));
    }
  }

  Stream<UserState> _clearUserData() async* {
    yield UserUninitialized();
  }
}
