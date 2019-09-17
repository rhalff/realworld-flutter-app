library blocs.articles;

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:realworld_flutter/model/article.dart';
import 'package:realworld_flutter/repositories/articles_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'articles_bloc.dart';
part 'articles_events.dart';
part 'articles_state.dart';
