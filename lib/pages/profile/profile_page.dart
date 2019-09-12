import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realworld_flutter/blocs/profile/bloc.dart';
import 'package:realworld_flutter/model/profile.dart';
import 'package:realworld_flutter/pages/profile/profile_header.dart';

class ProfilePage extends StatefulWidget {
  final Profile profile;
  const ProfilePage({
    this.profile,
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
              ProfileHeader(profile: state.profile),
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
