library blocs.article;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:realworld_flutter/api/model/new_article.dart';
import 'package:realworld_flutter/api/model/update_article.dart';
import 'package:realworld_flutter/model/article.dart';
import 'package:realworld_flutter/model/comment.dart';
import 'package:realworld_flutter/repositories/articles_repository.dart';

part 'article_bloc.dart';
part 'article_events.dart';
part 'article_state.dart';
