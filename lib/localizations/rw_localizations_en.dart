import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:realworld_flutter/localizations/rw_localizations.dart';

class RWLocalizationsEN implements RWLocalizations {
  const RWLocalizationsEN();

  /// Article
  @override
  String get articleFormTitle => 'Title';
  @override
  String get articleFormDescription => 'What\'s this article about?';
  @override
  String get articleFormBody => 'Write your post (in markdown)';
  @override
  String get articleFormTags => 'Enter tags';
  @override
  String get articleFormCreateArticle => 'Create article';
  @override
  String get articleFormUpdateArticle => 'Update article';
  @override
  String get articlePageEditArticle => 'Edit article';
  @override
  String get articlePageSignInOrUp =>
      'Sign in or sign up to add comments on this article';
  @override
  String get articleCommentFormComment => 'Write a comment...';
  @override
  String get articleCommentFormPostComment => 'Post Comment';
  @override
  String get articleFailedToLoad => 'failed to load article';
  @override
  String get articleRemoveArticle => 'Remove article';

  /// App Drawer
  @override
  String get appDrawerViewProfile => 'View Profile';
  @override
  String get appDrawerFavorited => 'Favorited';
  @override
  String get appDrawerNewArticle => 'New Article';
  @override
  String get appDrawerArticles => 'Articles';
  @override
  String get appDrawerAbout => 'About';

  /// About
  @override
  String get aboutMessage => 'Thank your for using this app.\n\n';
  @override
  String get aboutVisitRepo => 'Visit repo';

  /// Feeds
  @override
  String get globalFeed => 'Global Feed';
  @override
  String get yourFeed => 'Your Feed';
  @override
  String get yourFeedLogin =>
      'Please login or register in order to post your own articles.';

  /// App
  @override
  String get appName => 'Real World Flutter';
  @override
  String get appTitle => 'conduit';
  @override
  String get appSubtitle => 'A place to share your knowledge';

  /// Profile
  @override
  String get profileFormImage => 'URL of profile picture';
  @override
  String get profileFormUsername => 'Your Name';
  @override
  String get profileFormBio => 'Short bio about you';
  @override
  String get profileFormEmail => 'Email';
  @override
  String get profileFormUpdateProfile => 'Update Profile';
  @override
  String get profileFormLogout => 'Or click here to logout.';

  @override
  String get profileFailedToLoad => 'failed to load profile';
  @override
  String get profileEdit => 'Edit Profile';
  @override
  String get profilePageMyPosts => 'My Posts';
  @override
  String get profilePageFavoritedPosts => 'Favorited Posts';

  /// Sign in
  @override
  String get userSignIn => 'Sign in';
  @override
  String get userSignInNoAccount => 'Do not have an account?';
  @override
  String get userSignInFormEmail => 'Email';
  @override
  String get userSignInFormPassword => 'Password';
  @override
  String get userSignInFormSignIn => 'Sign In';

  /// Sign up
  @override
  String get userSignUp => 'Sign up';
  @override
  String get userSignUpHaveAccount => 'Have an account?';
  @override
  String get userSignUpFormName => 'Your Name';
  @override
  String get userSignUpFormEmail => 'Email';
  @override
  String get userSignUpFormPassword => 'Password';
  @override
  String get userSignUpFormSignUp => 'Sign Up';

  static Future<RWLocalizations> load(Locale locale) {
    return SynchronousFuture<RWLocalizations>(const RWLocalizationsEN());
  }

  static const LocalizationsDelegate<RWLocalizations> delegate =
      RWLocalizationsDelegate();
}
