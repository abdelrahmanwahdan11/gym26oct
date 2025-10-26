import 'package:flutter/material.dart';

import '../controllers/settings_controller.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/onboarding_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/clips/clips_list_screen.dart';
import '../screens/flexpass/flexpass_screen.dart';
import '../screens/home/generator_screen.dart';
import '../screens/profile/profile_home_screen.dart';
import '../screens/profile/settings_screen.dart';
import '../screens/profile/stats_screen.dart';
import '../screens/programs/program_details_screen.dart';
import '../screens/programs/program_filters_sheet.dart';
import '../screens/programs/programs_list_screen.dart';
import '../screens/store/cart_screen.dart';
import '../screens/store/checkout_screen.dart';
import '../screens/store/product_detail_screen.dart';
import '../screens/store/store_home_screen.dart';
import '../screens/trainers/booking_sheet.dart';
import '../screens/trainers/trainer_detail_screen.dart';
import '../screens/trainers/trainer_register_screen.dart';
import '../screens/trainers/trainers_list_screen.dart';
import '../screens/workout/warmup_list_screen.dart';
import '../screens/workout/workout_session_screen.dart';
import 'animations.dart';

Map<String, WidgetBuilder> buildStaticRoutes() {
  return {
    'onboarding': (_) => const OnboardingScreen(),
    'auth.login': (_) => const LoginScreen(),
    'auth.register': (_) => const RegisterScreen(),
    'home.generator': (_) => const GeneratorScreen(),
    'programs.list': (_) => const ProgramsListScreen(),
    'clips.list': (_) => const ClipsListScreen(),
    'store.home': (_) => const StoreHomeScreen(),
    'trainers.list': (_) => const TrainersListScreen(),
    'profile.home': (_) => const ProfileHomeScreen(),
    'store.cart': (_) => const CartScreen(),
    'store.checkout': (_) => const CheckoutScreen(),
    'warmup.list': (_) => const WarmupListScreen(),
    'workout.session': (_) => const WorkoutSessionScreen(),
    'flexpass.page': (_) => const FlexPassScreen(),
    'stats': (_) => const StatsScreen(),
    'settings': (_) => const SettingsScreen(),
    'trainer.register': (_) => const TrainerRegisterScreen(),
  };
}

Route<dynamic>? buildDynamicRoute(RouteSettings settings, SettingsController controller) {
  switch (settings.name) {
    case 'program.details':
      final programId = settings.arguments as String?;
      if (programId == null) break;
      return buildAnimatedRoute(builder: (_) => ProgramDetailsScreen(programId: programId), settings: settings);
    case 'store.product':
      final productId = settings.arguments as String?;
      if (productId == null) break;
      return buildAnimatedRoute(builder: (_) => ProductDetailScreen(productId: productId), settings: settings);
    case 'trainer.details':
      final trainerId = settings.arguments as String?;
      if (trainerId == null) break;
      return buildAnimatedRoute(builder: (_) => TrainerDetailScreen(trainerId: trainerId), settings: settings);
    case 'filters.sheet':
      return buildBottomSheetRoute(builder: (_) => const ProgramFiltersSheet(), settings: settings);
    case 'booking.sheet':
      final trainerId = settings.arguments as String?;
      if (trainerId == null) break;
      return buildBottomSheetRoute(builder: (_) => BookingSheet(trainerId: trainerId), settings: settings);
  }
  return null;
}
