import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realworld_flutter/blocs/articles/bloc.dart';
import 'package:realworld_flutter/blocs/profile/bloc.dart';
import 'package:realworld_flutter/model/profile.dart';
import 'package:realworld_flutter/model/user.dart';
import 'package:realworld_flutter/pages/articles/feed.dart';
import 'package:realworld_flutter/pages/articles/feeds.dart';
import 'package:realworld_flutter/pages/profile/profile_header.dart';
import 'package:realworld_flutter/screens/settings.dart';
import 'package:realworld_flutter/widgets/drop_down_menu.dart';

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
    final feeds = [
      Feed(
        id: 'my-posts',
        label: 'My Posts',
        onLoad: (ArticlesBloc bloc) {
          bloc.dispatch(
            LoadArticlesEvent(
              author: widget.profile.username,
              refresh: true,
            ),
          );
        },
        onLoadMore: (ArticlesBloc bloc) {
          bloc.dispatch(
            LoadArticlesEvent(
              author: widget.profile.username,
            ),
          );
        },
        onRefresh: (ArticlesBloc bloc) async {
          bloc.dispatch(
            LoadArticlesEvent(
              author: widget.profile.username,
              refresh: true,
            ),
          );
        },
      ),
      Feed(
        id: 'favorited-posts',
        label: 'Favorited Posts',
        onLoad: (ArticlesBloc bloc) {
          bloc.dispatch(
            LoadArticlesEvent(
              favorited: widget.profile.username,
              refresh: true,
            ),
          );
        },
        onLoadMore: (ArticlesBloc bloc) {
          bloc.dispatch(
            LoadArticlesEvent(
              favorited: widget.profile.username,
            ),
          );
        },
        onRefresh: (ArticlesBloc bloc) async {
          bloc.dispatch(
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: ProfileHeader(profile: state.profile),
                    ),
                    if (widget.profile.username == widget.user.username)
                      Positioned(
                        top: 10,
                        right: 10,
                        child: DropdownMenu(
                          onSelect: (item) {
                            if (item.id == 'edit_profile') {
                              Navigator.of(context)
                                  .pushNamed(SettingsScreen.route);
                            }
                          },
                          items: [
                            MenuItem(
                              id: 'edit_profile',
                              label: 'Edit profile',
                              icon: Icons.edit,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: Feeds(
                  feeds: feeds,
                  initialFeed: widget.initialFeed,
                ),
              )
            ],
          );
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
