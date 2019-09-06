import 'package:bloc/bloc.dart';

import 'auth_events.dart';
import 'auth_state.dart';

class AuthException implements Exception {}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthState initialState;

  AuthBloc({
    this.initialState,
    @required this.authRepository,
  }) {
    assert(authRepository != null);
    assert(initialState != null);
  }

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is SignedIn) {
      yield* _signedIn(event);
    } else if (event is SignOut) {
      yield* _signOut(event);
    }
  }

  Stream<AuthState> _signedIn(SignedIn event) async* {
    try {
      await authRepository.setAccessToken(event.accessToken);

      yield Authenticated();
    } catch (error) {
      yield AuthError(error);
    }
  }

  Stream<AuthState> _signOut(SignOut event) async* {
    await authRepository.removeAccessToken();

    yield NotAuthenticated();
  }
}
