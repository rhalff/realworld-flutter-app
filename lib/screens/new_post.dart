import 'package:flutter/material.dart' hide Banner;
import 'package:realworld_flutter/layout.dart';
import 'package:realworld_flutter/pages/new_post.dart';
import 'package:realworld_flutter/widgets/scroll_page.dart';

class NewPostScreen extends StatelessWidget {
  static const String route = '/new_post';

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: ScrollPage(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: NewPostForm(),
            ),
          ],
        ),
      ),
    );
  }
}
