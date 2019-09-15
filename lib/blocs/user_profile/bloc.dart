library blocs.user.profile;

import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:jaguar_retrofit/jaguar_retrofit.dart';
import 'package:meta/meta.dart';
import 'package:realworld_flutter/api/model/update_user.dart';
import 'package:realworld_flutter/blocs/user/bloc.dart';
import 'package:realworld_flutter/repositories/user_repository.dart';

part 'user_profile_bloc.dart';
part 'user_profile_events.dart';
part 'user_profile_state.dart';
