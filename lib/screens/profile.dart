import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realworld_flutter/blocs/profile/bloc.dart';
import 'package:realworld_flutter/blocs/user/bloc.dart';
import 'package:realworld_flutter/layout.dart';
import 'package:realworld_flutter/pages/profile/profile_page.dart';
import 'package:realworld_flutter/widgets/error_container.dart';

class ProfileScreen extends StatefulWidget {
  static const String route = '/profile';
  final UserBloc userBloc;
  final String feed;

  ProfileScreen({
    this.userBloc,
    this.feed,
  });

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileBloc _profileBloc;

  @override
  void initState() {
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.userBloc.getCurrentUser();

    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        final actions = <Widget>[];

        Widget child;

        if (state is ProfileError) {
          child = Layout(
            child: ErrorContainer(
              error: 'failed to load profile',
            ),
          );
        } else if (state is ProfileLoaded) {
          actions.addAll(
            <Widget>[
              if (user?.username != state.profile.username)
                IconButton(
                  icon: state.profile.following
                      ? Icon(Icons.star)
                      : Icon(Icons.star_border),
                  onPressed: () => _profileBloc.dispatch(
                    ToggleFollowUserEvent(username: state.profile.username),
                  ),
                ),
            ],
          );

          child = ProfilePage(
            user: user,
            profile: state.profile,
            initialFeed: widget.feed,
          );
        } else {
          child = const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Layout(
          child: child,
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 4.0,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: actions,
            ),
          ),
        );
      },
    );
  }
}
