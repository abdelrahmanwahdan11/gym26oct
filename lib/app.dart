import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/auth_controller.dart';
import 'controllers/clips_controller.dart';
import 'controllers/flexpass_controller.dart';
import 'controllers/programs_controller.dart';
import 'controllers/settings_controller.dart';
import 'controllers/store_controller.dart';
import 'controllers/trainers_controller.dart';
import 'controllers/workout_controller.dart';
import 'core/localization/app_localizations.dart';
import 'core/routes.dart';
import 'core/theme.dart';
import 'data/repositories/clip_repository.dart';
import 'data/repositories/flexpass_repository.dart';
import 'data/repositories/prefs_repository.dart';
import 'data/repositories/program_repository.dart';
import 'data/repositories/store_repository.dart';
import 'data/repositories/trainers_repository.dart';

class AthleticaApp extends StatefulWidget {
  const AthleticaApp({super.key, required this.prefs});

  final SharedPreferences prefs;

  @override
  State<AthleticaApp> createState() => _AthleticaAppState();
}

class _AthleticaAppState extends State<AthleticaApp> {
  late final PrefsRepository prefsRepository;

  @override
  void initState() {
    super.initState();
    prefsRepository = PrefsRepository(widget.prefs);
    Get.put(SettingsController(prefsRepository), permanent: true);
    Get.put(ProgramsController(ProgramsRepository(), prefsRepository), permanent: true);
    Get.put(ClipsController(ClipsRepository()), permanent: true);
    Get.put(StoreController(StoreRepository(), prefsRepository), permanent: true);
    Get.put(TrainersController(TrainersRepository(), prefsRepository), permanent: true);
    Get.put(FlexPassController(FlexPassRepository(), prefsRepository), permanent: true);
    Get.put(WorkoutController(prefsRepository), permanent: true);
    Get.put(AuthController(prefsRepository), permanent: true);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      builder: (settingsController) {
        final locale = settingsController.currentLocale;
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Athletica X',
          themeMode: settingsController.themeMode,
          theme: buildThemeData(brightness: Brightness.light),
          darkTheme: buildThemeData(brightness: Brightness.dark),
          locale: locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [AppLocalizationsDelegate()],
          initialRoute: settingsController.initialRoute,
          routes: buildStaticRoutes(),
          onGenerateRoute: (settings) => buildDynamicRoute(settings, settingsController),
          builder: (context, child) {
            final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);
            return Directionality(
              textDirection: settingsController.isArabic ? TextDirection.rtl : TextDirection.ltr,
              child: Theme(
                data: Theme.of(context).copyWith(textTheme: textTheme),
                child: child!,
              ),
            );
          },
        );
      },
    );
  }
}
