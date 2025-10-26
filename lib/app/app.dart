import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bindings/app_bindings.dart';
import 'bindings/locale_binding.dart';
import 'bindings/notifications_binding.dart';
import 'bindings/theme_binding.dart';
import 'controllers/locale_controller.dart';
import 'controllers/theme_controller.dart';
import 'localization/app_translations.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';

class AthleticaApp extends StatelessWidget {
  AthleticaApp({super.key, required SharedPreferences sharedPrefs})
      : _appBindings = AppBindings(sharedPrefs) {
    _appBindings.dependencies();
  }

  final AppBindings _appBindings;

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final localeController = Get.find<LocaleController>();

    return Obx(
      () => GetMaterialApp(
        title: 'Athletica X',
        debugShowCheckedModeBanner: false,
        translations: AppTranslations(),
        locale: localeController.locale,
        fallbackLocale: const Locale('ar'),
        supportedLocales: AppTranslations.supportedLocales,
        themeMode: themeController.themeMode,
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        defaultTransition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 220),
        smartManagement: SmartManagement.full,
        initialRoute: AppRoutes.initial,
        getPages: AppPages.pages(),
        initialBinding: BindingsBuilder(() {
          ThemeBinding().dependencies();
          LocaleBinding().dependencies();
          NotificationsBinding().dependencies();
        }),
      ),
    );
  }
}
