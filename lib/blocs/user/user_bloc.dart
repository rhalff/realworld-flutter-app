part of blocs.user;

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

    _authBlocSubscription = authBloc.listen((state) {
      if (state is NotAuthenticated) {
        add(ClearUserDataEvent());
      }
    });
  }

  @override
  Future<void> close() {
    _authBlocSubscription.cancel();
    return super.close();
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

  User getCurrentUser() {
    if (state is UserLoaded) {
      return (state as UserLoaded).user;
    }

    return null;
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

      authBloc.add(SignedInEvent(accessToken: user.token));

      yield UserLoaded(user);
    } catch (error) {
      yield UserError(_parseError(error));
    }
  }

  List<String> _parseError(Object error) {
    if (error is StringResponse) {
      try {
        final body = jsonDecode(error.body) as Map<String, dynamic>;

        final errors = <String>[];
        if (body['errors'] != null) {
          for (var entry in (body['errors'] as Map<String, dynamic>).entries) {
            errors.add('${entry.key} ${entry.value.join(', ')}');
          }
        }

        return errors;
      } catch (e) {
        print(e);
      }
    }

    return [error.toString()];
  }

  Stream<UserState> _signUp(SignUpEvent event) async* {
    try {
      yield UserSigningUp();

      final user = await userRepository.signUp(event.user);

      authBloc.add(SignedInEvent(accessToken: user.token));

      yield UserLoaded(user);
    } catch (error) {
      yield UserError(_parseError(error));
    }
  }

  Stream<UserState> _clearUserData() async* {
    yield UserUninitialized();
  }
}
