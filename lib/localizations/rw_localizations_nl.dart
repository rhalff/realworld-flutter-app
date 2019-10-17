import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:realworld_flutter/localizations/rw_localizations.dart';

class RWLocalizationsNL implements RWLocalizations {
  const RWLocalizationsNL();

  /// Article
  @override
  String get articleFormTitle => 'Titel';
  @override
  String get articleFormDescription => 'Waar gaat dit artikel over?';
  @override
  String get articleFormBody => 'Schrijf je artikel (in markdown)';
  @override
  String get articleFormTags => 'Voer tags in';
  @override
  String get articleFormCreateArticle => 'Nieuw artikel';
  @override
  String get articleFormUpdateArticle => 'Artikel bewaren';
  @override
  String get articlePageEditArticle => 'Artikel wijzigen';
  @override
  String get articlePageSignInOrUp =>
      'Log in om commentaar te kunnen plaatsen op dit artikel';
  @override
  String get articleCommentFormComment => 'Schrijf een opmerking...';
  @override
  String get articleCommentFormPostComment => 'Opmerking plaatsen';
  @override
  String get articleFailedToLoad => 'laden van het artikel mislukt';
  @override
  String get articleRemoveArticle => 'Artikel verwijderen';

  /// App Drawer
  @override
  String get appDrawerViewProfile => 'Bekijk profiel';
  @override
  String get appDrawerFavorited => 'Favoriete artikelen';
  @override
  String get appDrawerNewArticle => 'Nieuw Artikel';
  @override
  String get appDrawerArticles => 'Artikelen';
  @override
  String get appDrawerLogout => 'Logout';
  @override
  String get appDrawerAbout => 'Over ons';

  /// About
  @override
  String get aboutMessage => 'Bedankt voor het gebruiken van deze app.\n\n';
  @override
  String get aboutVisitRepo => 'Bezoek github repository';

  /// Feeds
  @override
  String get globalFeed => 'Globale Feed';
  @override
  String get yourFeed => 'Jouw Feed';
  @override
  String get yourFeedLogin =>
      'Om artikelen te kunnen plaatsen moet u eerst inloggen.';

  /// App
  @override
  String get appName => 'Real World Flutter';
  @override
  String get appTitle => 'conduit';
  @override
  String get appSubtitle => 'Een plek om jouw kennis te delen';

  /// Profile
  @override
  String get profileFormImage => 'URL of profiel afbeelding';
  @override
  String get profileFormUsername => 'Jouw Naam';
  @override
  String get profileFormBio => 'Korte omschrijving van jezelf';
  @override
  String get profileFormEmail => 'Email';
  @override
  String get profileFormUpdateProfile => 'Wijzig Profiel';
  @override
  String get profileFormLogout => 'Of klik hier om uit te loggen.';

  @override
  String get profileFailedToLoad => 'laden van het profiel is mislukt';
  @override
  String get profileEdit => 'Wijzig Profiel';
  @override
  String get profilePageMyPosts => 'Mijn Artikelen';
  @override
  String get profilePageFavoritedPosts => 'Favoriete Artikelen';

  /// Sign in
  @override
  String get userSignIn => 'Inloggen';
  @override
  String get userSignInNoAccount => 'Heeft u geen account?';
  @override
  String get userSignInFormEmail => 'Email';
  @override
  String get userSignInFormPassword => 'Password';
  @override
  String get userSignInFormSignIn => 'Inloggen';

  /// Sign up
  @override
  String get userSignUp => 'Inschrijven';
  @override
  String get userSignUpHaveAccount => 'Heeft u reeds een account?';
  @override
  String get userSignUpFormName => 'Jouw Naam';
  @override
  String get userSignUpFormEmail => 'Email';
  @override
  String get userSignUpFormPassword => 'Wachtwoord';
  @override
  String get userSignUpFormSignUp => 'Inschrijven';

  static Future<RWLocalizations> load(Locale locale) {
    return SynchronousFuture<RWLocalizations>(const RWLocalizationsNL());
  }

  static const LocalizationsDelegate<RWLocalizations> delegate =
      RWLocalizationsDelegate();
}
