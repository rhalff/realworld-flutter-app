import 'package:flutter/material.dart';

import 'app.dart';
import 'application.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final application = Application();

  await application.setup();
  await application.init();

  runApp(RealWorldApp(application: application));
}
