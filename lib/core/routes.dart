import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/auth/login_screen.dart';
import '../screens/auth/onboarding_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/clips/clips_list_screen.dart';
import '../screens/feature/innovation_lab_screen.dart';
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

List<GetPage<dynamic>> buildAppPages() {
  return [
    GetPage(name: '/onboarding', page: () => const OnboardingScreen()),
    GetPage(name: '/auth/login', page: () => const LoginScreen()),
    GetPage(name: '/auth/register', page: () => const RegisterScreen()),
    GetPage(name: '/home/generator', page: () => const GeneratorScreen()),
    GetPage(name: '/programs', page: () => const ProgramsListScreen()),
    GetPage(name: '/clips', page: () => const ClipsListScreen()),
    GetPage(name: '/store', page: () => const StoreHomeScreen()),
    GetPage(name: '/trainers', page: () => const TrainersListScreen()),
    GetPage(name: '/profile', page: () => const ProfileHomeScreen()),
    GetPage(name: '/store/cart', page: () => const CartScreen()),
    GetPage(name: '/store/checkout', page: () => const CheckoutScreen()),
    GetPage(name: '/warmups', page: () => const WarmupListScreen()),
    GetPage(name: '/session', page: () => const WorkoutSessionScreen()),
    GetPage(name: '/flexpass', page: () => const FlexPassScreen()),
    GetPage(name: '/stats', page: () => const StatsScreen()),
    GetPage(name: '/settings', page: () => const SettingsScreen()),
    GetPage(name: '/trainer/register', page: () => const TrainerRegisterScreen()),
    GetPage(name: '/innovation', page: () => const InnovationLabScreen()),
    GetPage(
      name: '/program/:id',
      page: () {
        final programId = Get.parameters['id'];
        if (programId == null || programId.isEmpty) {
          return const _RouteGuardPage(message: 'Program not found');
        }
        return ProgramDetailsScreen(programId: programId);
      },
    ),
    GetPage(
      name: '/store/product/:id',
      page: () {
        final productId = Get.parameters['id'];
        if (productId == null || productId.isEmpty) {
          return const _RouteGuardPage(message: 'Product not found');
        }
        return ProductDetailScreen(productId: productId);
      },
    ),
    GetPage(
      name: '/trainer/:id',
      page: () {
        final trainerId = Get.parameters['id'];
        if (trainerId == null || trainerId.isEmpty) {
          return const _RouteGuardPage(message: 'Trainer not found');
        }
        return TrainerDetailScreen(trainerId: trainerId);
      },
    ),
    GetPage(
      name: '/filters',
      page: () => const _BottomSheetPage(child: ProgramFiltersSheet()),
      customTransition: BottomSheetPageTransition(),
      opaque: false,
      transitionDuration: const Duration(milliseconds: 320),
    ),
    GetPage(
      name: '/booking',
      page: () {
        final trainerId = Get.parameters['trainer'] ?? Get.arguments as String?;
        if (trainerId == null || trainerId.isEmpty) {
          return const _RouteGuardPage(message: 'Trainer not found');
        }
        return _BottomSheetPage(child: BookingSheet(trainerId: trainerId));
      },
      customTransition: BottomSheetPageTransition(),
      opaque: false,
      transitionDuration: const Duration(milliseconds: 320),
    ),
  ];
}

class _RouteGuardPage extends StatelessWidget {
  const _RouteGuardPage({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ),
    );
  }
}

class _BottomSheetPage extends StatelessWidget {
  const _BottomSheetPage({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: SafeArea(
        top: false,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: FractionallySizedBox(
            heightFactor: 0.82,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
              child: Material(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
