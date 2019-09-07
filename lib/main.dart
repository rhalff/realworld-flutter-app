import 'package:flutter/material.dart';

import 'app.dart';
import 'application.dart';

void main() async {
  final application = Application();

  await application.setup();

  runApp(RealWorldApp(application: application));
}
