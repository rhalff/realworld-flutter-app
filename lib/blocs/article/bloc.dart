library blocs.article;

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:realworld_flutter/api/model/article_submission.dart';
import 'package:realworld_flutter/model/article.dart';
import 'package:realworld_flutter/repositories/articles/repository.dart';

part 'article_bloc.dart';
part 'article_events.dart';
part 'article_state.dart';
