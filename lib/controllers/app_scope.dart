import 'package:flutter/widgets.dart';

import 'auth_controller.dart';
import 'challenges_controller.dart';
import 'clips_controller.dart';
import 'flexpass_controller.dart';
import 'programs_controller.dart';
import 'settings_controller.dart';
import 'store_controller.dart';
import 'trainers_controller.dart';
import 'workout_controller.dart';

class AppScope extends InheritedWidget {
  const AppScope({
    super.key,
    required super.child,
    required this.settings,
    required this.programs,
    required this.clips,
    required this.store,
    required this.trainers,
    required this.flexPass,
    required this.workout,
    required this.auth,
    required this.challenges,
  });

  final SettingsController settings;
  final ProgramsController programs;
  final ClipsController clips;
  final StoreController store;
  final TrainersController trainers;
  final FlexPassController flexPass;
  final WorkoutController workout;
  final AuthController auth;
  final ChallengesController challenges;

  static AppScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope not found');
    return scope!;
  }

  @override
  bool updateShouldNotify(covariant AppScope oldWidget) => false;
}
