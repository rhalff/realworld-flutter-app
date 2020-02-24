import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realworld_flutter/blocs/articles/bloc.dart';
import 'package:realworld_flutter/blocs/profile/bloc.dart';
import 'package:realworld_flutter/localizations/rw_localizations.dart';
import 'package:realworld_flutter/model/profile.dart';
import 'package:realworld_flutter/model/user.dart';
import 'package:realworld_flutter/pages/articles/feed.dart';
import 'package:realworld_flutter/pages/articles/feeds.dart';
import 'package:realworld_flutter/pages/profile/profile_header.dart';

class ProfilePage extends StatefulWidget {
  final Profile profile;
  final User user;
  final String initialFeed;

  const ProfilePage({
    this.profile,
    this.user,
    this.initialFeed,
  });

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final locale = RWLocalizations.of(context);

    final feeds = [
      FeedModel(
        id: 'my-posts',
        label: locale.profilePageMyPosts,
        onLoad: (ArticlesBloc bloc) {
          bloc
            ..add(
              LoadArticlesEvent(
                author: widget.profile.username,
                refresh: true,
              ),
            );
        },
        onLoadMore: (ArticlesBloc bloc) {
          bloc
            ..add(
              LoadArticlesEvent(
                author: widget.profile.username,
              ),
            );
        },
        onRefresh: (ArticlesBloc bloc) async {
          bloc
            ..add(
              LoadArticlesEvent(
                author: widget.profile.username,
                refresh: true,
              ),
            );
        },
      ),
      FeedModel(
        id: 'favorited-posts',
        label: locale.profilePageFavoritedPosts,
        onLoad: (ArticlesBloc bloc) {
          bloc
            ..add(
              LoadArticlesEvent(
                favorited: widget.profile.username,
                refresh: true,
              ),
            );
        },
        onLoadMore: (ArticlesBloc bloc) {
          bloc
            ..add(
              LoadArticlesEvent(
                favorited: widget.profile.username,
              ),
            );
        },
        onRefresh: (ArticlesBloc bloc) async {
          bloc
            ..add(
              LoadArticlesEvent(
                favorited: widget.profile.username,
                refresh: true,
              ),
            );
        },
      ),
    ];

    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (
        BuildContext context,
        ProfileState state,
      ) {
        if (state is ProfileLoaded) {
          return Feeds(
            feeds: feeds,
            minExtentHeader: 0,
            maxExtentHeader: 250,
            header: ProfileHeader(
              profile: state.profile,
              fit: BoxFit.fitWidth,
              isUserPage: widget.profile.username == widget.user?.username,
            ),
            initialFeed: widget.initialFeed,
          );
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
