import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realworld_flutter/blocs/articles/bloc.dart';
import 'package:realworld_flutter/repositories/articles_repository.dart';
import 'package:realworld_flutter/utils.dart';

import 'feed.dart';

class Feeds extends StatefulWidget {
  final List<Feed> feeds;
  final String initialFeed;

  Feeds({
    @required this.feeds,
    this.initialFeed,
  }) : assert(feeds.isNotEmpty);

  @override
  _FeedsState createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> with SingleTickerProviderStateMixin {
  TabController _tabController;

  final Map<String, ArticlesBloc> _blocs = {};

  @override
  void initState() {
    final initialIndex = widget.initialFeed != null
        ? widget.feeds.indexWhere((Feed feed) => feed.id == widget.initialFeed)
        : 0;

    super.initState();
    _tabController = TabController(
      length: 2,
      initialIndex: initialIndex == -1 ? 0 : initialIndex,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    for (var bloc in _blocs.values) {
      bloc.dispose();
    }
    _blocs.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Container(
            child: TabBar(
              controller: _tabController,
              tabs: widget.feeds.map((feed) => Tab(text: feed.label)).toList(),
            ),
          ),
        ),
        SizedBox(
          height: 300,
          child: AnimatedBuilder(
            animation: _tabController.animation,
            builder: (BuildContext context, snapshot) {
              return TabBarView(
                controller: _tabController,
                children: mapWithIndex(widget.feeds, (Feed feed, int index) {
                  return BlocProvider<ArticlesBloc>.value(
                    value: getArticlesBloc(feed),
                    child: Opacity(
                      opacity: index % 2 == 0
                          ? 1 - _tabController.animation.value
                          : _tabController.animation.value,
                      child: feed,
                    ),
                  );
                }),
              );
            },
          ),
        ),
      ],
    );
  }

  ArticlesBloc getArticlesBloc(Feed feed) {
    if (!_blocs.containsKey(feed.label)) {
      return _blocs[feed.label] = ArticlesBloc(
        articlesRepository: RepositoryProvider.of<ArticlesRepository>(context),
      );
    }
    return _blocs[feed.label];
  }
}
