import 'package:flutter/material.dart' hide Banner;
import 'package:realworld_flutter/layout.dart';
import 'package:realworld_flutter/pages/settings.dart';
import 'package:realworld_flutter/widgets/scroll_page.dart';

class SettingsScreen extends StatelessWidget {
  static const String route = '/settings';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Layout(
      child: ScrollPage(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: <Widget>[
                  Text(
                    'Your Settings',
                    style: theme.textTheme.title.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: SettingsForm(),
            ),
          ],
        ),
      ),
    );
  }
}
