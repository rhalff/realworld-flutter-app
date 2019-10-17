import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:realworld_flutter/localizations/rw_localizations_en.dart';
import 'package:realworld_flutter/localizations/rw_localizations_nl.dart';

abstract class RWLocalizations {
  static RWLocalizations of(BuildContext context) {
    return Localizations.of<RWLocalizations>(context, RWLocalizations);
  }

  /// Article
  String get articleFormTitle;
  String get articleFormDescription;
  String get articleFormBody;
  String get articleFormTags;
  String get articleFormCreateArticle;
  String get articleFormUpdateArticle;
  String get articlePageEditArticle;
  String get articlePageSignInOrUp;
  String get articleCommentFormComment;
  String get articleCommentFormPostComment;
  String get articleFailedToLoad;
  String get articleRemoveArticle;

  /// App Drawer
  String get appDrawerViewProfile;
  String get appDrawerFavorited;
  String get appDrawerNewArticle;
  String get appDrawerArticles;
  String get appDrawerLogout;
  String get appDrawerAbout;

  /// About
  String get aboutMessage;
  String get aboutVisitRepo;

  /// Feeds
  String get globalFeed;
  String get yourFeed;
  String get yourFeedLogin;

  /// App
  String get appName;
  String get appTitle;
  String get appSubtitle;

  /// Profile
  String get profileFormImage;
  String get profileFormUsername;
  String get profileFormBio;
  String get profileFormEmail;
  String get profileFormUpdateProfile;
  String get profileFormLogout;

  String get profileFailedToLoad;
  String get profileEdit;
  String get profilePageMyPosts;
  String get profilePageFavoritedPosts;

  /// Sign in
  String get userSignIn;
  String get userSignInNoAccount;
  String get userSignInFormEmail;
  String get userSignInFormPassword;
  String get userSignInFormSignIn;

  /// Sign up
  String get userSignUp;
  String get userSignUpHaveAccount;
  String get userSignUpFormName;
  String get userSignUpFormEmail;
  String get userSignUpFormPassword;
  String get userSignUpFormSignUp;
}

class RWLocalizationsDelegate extends LocalizationsDelegate<RWLocalizations> {
  const RWLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'nl'].contains(locale.languageCode);

  @override
  Future<RWLocalizations> load(Locale locale) {
    final name = (locale.countryCode == null || locale.countryCode.isEmpty)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    Intl.defaultLocale = localeName;

    if (locale.languageCode == 'nl') {
      return RWLocalizationsNL.load(locale);
    } else {
      return RWLocalizationsEN.load(locale);
    }
  }

  @override
  bool shouldReload(RWLocalizationsDelegate old) => false;

  @override
  String toString() => 'DefaultRWLocalizations.delegate(en_US)';
}
