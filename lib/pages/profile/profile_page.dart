import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realworld_flutter/blocs/profile/bloc.dart';
import 'package:realworld_flutter/model/profile.dart';
import 'package:realworld_flutter/model/user.dart';
import 'package:realworld_flutter/pages/profile/profile_header.dart';
import 'package:realworld_flutter/screens/settings.dart';
import 'package:realworld_flutter/widgets/drop_down_menu.dart';

class ProfilePage extends StatefulWidget {
  final Profile profile;
  final User user;
  const ProfilePage({
    this.profile,
    this.user,
  });

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
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
              )
            ],
          );
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
