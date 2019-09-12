import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realworld_flutter/blocs/profile/bloc.dart';
import 'package:realworld_flutter/layout.dart';
import 'package:realworld_flutter/pages/profile/profile_page.dart';
import 'package:realworld_flutter/widgets/error_container.dart';
import 'package:realworld_flutter/widgets/scroll_page.dart';

class ProfileScreen extends StatefulWidget {
  static const String route = '/profile';

  final String username;
  ProfileScreen({
    this.username,
  });

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileBloc _profileBloc;

  @override
  void initState() {
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(context)
      ..dispatch(LoadProfileEvent(username: widget.username));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        final actions = <Widget>[];

        Widget child;

        if (state is ProfileError) {
          child = ErrorContainer(
            error: 'failed to load profile',
          );
        } else if (state is ProfileLoaded) {
          actions.addAll(
            <Widget>[
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
            profile: state.profile,
          );
        } else {
          child = Center(
            child: const CircularProgressIndicator(),
          );
        }

        return Layout(
          child: ScrollPage(
            child: child,
          ),
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
