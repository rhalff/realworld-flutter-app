import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realworld_flutter/blocs/articles/bloc.dart';
import 'package:realworld_flutter/repositories/articles/repository.dart';
import 'package:realworld_flutter/screens/home.dart';
import 'package:realworld_flutter/utils.dart';

import 'feed.dart';

class FeedTabs implements SliverPersistentHeaderDelegate {
  @override
  double maxExtent;
  @override
  double minExtent;

  final List<Feed> feeds;
  final TabController controller;

  FeedTabs({
    @required this.minExtent,
    @required this.maxExtent,
    @required this.feeds,
    @required this.controller,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        child: TabBar(
          controller: controller,
          tabs: feeds.map((feed) => Tab(text: feed.label)).toList(),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;
}

class Feeds extends StatefulWidget {
  final List<FeedModel> feeds;
  final String initialFeed;
  final Widget header;
  final double minExtentHeader;
  final double maxExtentHeader;
  final bool pinned;

  Feeds({
    @required this.feeds,
    this.header,
    this.pinned = false,
    this.initialFeed,
    this.minExtentHeader = 90.0,
    this.maxExtentHeader = 140.0,
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
        ? widget.feeds
            .indexWhere((FeedModel feed) => feed.id == widget.initialFeed)
        : 0;

    super.initState();
    _tabController = TabController(
      length: widget.feeds.length,
      initialIndex: initialIndex == -1 ? 0 : initialIndex,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    for (var cachedBloc in _blocs.values) {
      cachedBloc.dispose();
    }
    _blocs.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverPersistentHeader(
              pinned: widget.pinned,
              delegate: HeroHeader(
                minExtent: widget.minExtentHeader,
                maxExtent: widget.maxExtentHeader,
                child: widget.header,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Container(
                  child: TabBar(
                    controller: _tabController,
                    tabs: widget.feeds
                        .map((feed) => Tab(text: feed.label))
                        .toList(),
                  ),
                ),
              ),
            ),
          ];
        },
        body: SizedBox(
          height: 300,
          child: AnimatedBuilder(
            animation: _tabController.animation,
            builder: (BuildContext context, snapshot) {
              return TabBarView(
                controller: _tabController,
                children:
                    mapWithIndex(widget.feeds, (FeedModel feed, int index) {
                  return BlocProvider<ArticlesBloc>.value(
                    value: getArticlesBloc(feed),
                    child: Opacity(
                      opacity: index % 2 == 0
                          ? 1 - _tabController.animation.value
                          : _tabController.animation.value,
                      child: Feed(
                        id: feed.id,
                        scrollThreshold: feed.scrollThreshold,
                        label: feed.label,
                        onRefresh: feed.onRefresh,
                        onLoadMore: feed.onLoadMore,
                        onLoad: feed.onLoad,
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ));
  }

  ArticlesBloc getArticlesBloc(FeedModel feed) {
    if (!_blocs.containsKey(feed.label)) {
      return _blocs[feed.label] = ArticlesBloc(
        articlesRepository: RepositoryProvider.of<ArticlesRepository>(context),
      );
    }
    return _blocs[feed.label];
  }
}
