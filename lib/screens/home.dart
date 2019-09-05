import 'package:flutter/material.dart' hide Banner;
import 'package:realworld_flutter/layout.dart';
import 'package:realworld_flutter/widgets/banner.dart';
import 'package:realworld_flutter/widgets/preview_post.dart';

class HomeScreen extends StatelessWidget {
  static const String route = '/';

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Banner(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
              child: DefaultTabController(
                length: 2,
                child: TabBar(
                  // instead of controlling which Widget is shown
                  // we will want to change the provided data.
                  // and thus dispatch a bloc action.
                  // controller: use custom controller,
                  tabs: <Widget>[
                    Tab(text: 'Your Feed'),
                    Tab(text: 'Global Feed'),
                  ],
                ),
              ),
            ),
          ),
          PreviewPost(
            author: 'Eric Simons',
            avatar: '',
            date: DateTime.now(),
            title: 'How to build webapps that scale',
            text:
                "In my demo, the holy grail layout is nested inside a document, so there's no body or main tags like shown above. Regardless, we're interested in the class names and the appearance of sections in the markup as opposed to the actual elements themselves. In particular, take note of the modifier classes used on the two sidebars, and the trivial order in which they appear in the markup. Let's break this down to paint a clear picture of what's happening...",
          ),
          PreviewPost(
            author: 'Eric Simons',
            avatar: '',
            date: DateTime.now(),
            title: 'How to build webapps that scale',
            text:
                "In my demo, the holy grail layout is nested inside a document, so there's no body or main tags like shown above. Regardless, we're interested in the class names and the appearance of sections in the markup as opposed to the actual elements themselves. In particular, take note of the modifier classes used on the two sidebars, and the trivial order in which they appear in the markup. Let's break this down to paint a clear picture of what's happening...",
          ),
          PreviewPost(
            author: 'Eric Simons',
            avatar: '',
            date: DateTime.now(),
            title: 'How to build webapps that scale',
            text:
                "In my demo, the holy grail layout is nested inside a document, so there's no body or main tags like shown above. Regardless, we're interested in the class names and the appearance of sections in the markup as opposed to the actual elements themselves. In particular, take note of the modifier classes used on the two sidebars, and the trivial order in which they appear in the markup. Let's break this down to paint a clear picture of what's happening...",
          ),
        ],
      ),
    );
  }
}
