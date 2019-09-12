library blocs.profile;

import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:jaguar_retrofit/jaguar_retrofit.dart';
import 'package:meta/meta.dart';
import 'package:realworld_flutter/api/model/update_user.dart';
import 'package:realworld_flutter/model/profile.dart';
import 'package:realworld_flutter/repositories/user_repository.dart';

part 'profile_bloc.dart';
part 'profile_events.dart';
part 'profile_state.dart';
