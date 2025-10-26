import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/app_scope.dart';
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
  late final SettingsController settingsController;
  late final ProgramsController programsController;
  late final ClipsController clipsController;
  late final StoreController storeController;
  late final TrainersController trainersController;
  late final FlexPassController flexPassController;
  late final WorkoutController workoutController;
  late final AuthController authController;

  @override
  void initState() {
    super.initState();
    final storage = GetStorage();
    prefsRepository = PrefsRepository(widget.prefs, storage);
    settingsController = SettingsController(prefsRepository);
    programsController = ProgramsController(ProgramsRepository(), prefsRepository);
    clipsController = ClipsController(ClipsRepository());
    storeController = StoreController(StoreRepository(), prefsRepository);
    trainersController = TrainersController(TrainersRepository(), prefsRepository);
    flexPassController = FlexPassController(FlexPassRepository(), prefsRepository);
    workoutController = WorkoutController(prefsRepository);
    authController = AuthController(prefsRepository);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      settingsController.bootstrap();
      programsController.bootstrap();
      clipsController.bootstrap();
      storeController.bootstrap();
      trainersController.bootstrap();
      flexPassController.bootstrap();
      workoutController.bootstrap();
      authController.bootstrap();
    });
  }

  @override
  void dispose() {
    settingsController.dispose();
    programsController.dispose();
    clipsController.dispose();
    storeController.dispose();
    trainersController.dispose();
    flexPassController.dispose();
    workoutController.dispose();
    authController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScope(
      settings: settingsController,
      programs: programsController,
      clips: clipsController,
      store: storeController,
      trainers: trainersController,
      flexPass: flexPassController,
      workout: workoutController,
      auth: authController,
      child: AnimatedBuilder(
        animation: settingsController,
        builder: (context, _) {
          final locale = settingsController.currentLocale;
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Athletica X',
            themeMode: settingsController.themeMode,
            theme: buildThemeData(brightness: Brightness.light),
            darkTheme: buildThemeData(brightness: Brightness.dark),
            locale: locale,
            fallbackLocale: AppLocalizations.defaultLocale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: const [
              AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            initialRoute: settingsController.initialRoute,
            getPages: buildAppPages(),
            defaultTransition: Transition.noTransition,
            customTransition: FadeSlidePageTransition(),
            transitionDuration: const Duration(milliseconds: 280),
            builder: (context, child) {
              final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);
              return Directionality(
                textDirection: settingsController.isArabic ? TextDirection.rtl : TextDirection.ltr,
                child: Theme(
                  data: Theme.of(context).copyWith(textTheme: textTheme),
                  child: child ?? const SizedBox.shrink(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
