import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'application.dart';
import 'blocs/auth/bloc.dart';
import 'blocs/user/bloc.dart';

void main() async {
  // timeDilation = 3.0;
  WidgetsFlutterBinding.ensureInitialized();

  final application = Application();

  await application.setup();
  await application.init();

  runApp(
    MultiBlocProvider(providers: [
      BlocProvider<AuthBloc>.value(
        value: application.authBloc,
      ),
      BlocProvider<UserBloc>.value(
        value: application.userBloc,
      ),
    ], child: RealWorldApp(application: application)),
  );
}
