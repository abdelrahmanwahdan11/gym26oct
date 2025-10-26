import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static const supportedLocales = [Locale('ar'), Locale('en')];
  static const defaultLocale = Locale('ar');

  static final Map<String, Map<String, String>> _localizedValues = {
    'ar': {
      'generator': 'المُوَلِّد',
      'programs': 'البرامج',
      'clips': 'المقاطع',
      'store': 'المتجر',
      'trainers': 'المدربون',
      'profile': 'الملف',
      'start_workout': 'ابدأ التمرين',
      'join_program': 'انضم للبرنامج',
      'book': 'احجز',
      'contact': 'تواصل',
      'add_to_cart': 'أضف للسلة',
      'buy_now': 'اشترِ الآن',
      'flexpass': 'FlexPass',
    },
    'en': {
      'generator': 'Generator',
      'programs': 'Programs',
      'clips': 'Clips',
      'store': 'Store',
      'trainers': 'Trainers',
      'profile': 'Profile',
      'start_workout': 'Start Workout',
      'join_program': 'Join Program',
      'book': 'Book',
      'contact': 'Contact',
      'add_to_cart': 'Add to Cart',
      'buy_now': 'Buy Now',
      'flexpass': 'FlexPass',
    },
  };

  String t(String key) {
    return _localizedValues[locale.languageCode]?[key] ??
        _localizedValues[defaultLocale.languageCode]?[key] ??
        key;
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => AppLocalizations.supportedLocales.contains(Locale(locale.languageCode));

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture(AppLocalizations(locale));
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) => false;
}
