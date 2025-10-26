import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../bindings/auth_binding.dart';
import '../bindings/booking_binding.dart';
import '../bindings/cart_binding.dart';
import '../bindings/clips_binding.dart';
import '../bindings/flexpass_binding.dart';
import '../bindings/locale_binding.dart';
import '../bindings/programs_binding.dart';
import '../bindings/search_binding.dart';
import '../bindings/stats_binding.dart';
import '../bindings/store_binding.dart';
import '../bindings/theme_binding.dart';
import '../bindings/trainers_binding.dart';
import '../bindings/workout_binding.dart';
import '../middlewares/auth_middleware.dart';
import '../middlewares/onboarding_middleware.dart';
import '../ui/pages/auth/login_page.dart';
import '../ui/pages/auth/register_page.dart';
import '../ui/pages/booking/booking_bottom_sheet.dart';
import '../ui/pages/clips/clips_list_page.dart';
import '../ui/pages/flexpass/flexpass_page.dart';
import '../ui/pages/home/generator_page.dart';
import '../ui/pages/onboarding/onboarding_page.dart';
import '../ui/pages/profile/profile_home_page.dart';
import '../ui/pages/programs/program_details_page.dart';
import '../ui/pages/programs/programs_list_page.dart';
import '../ui/pages/programs/warmups_page.dart';
import '../ui/pages/settings/settings_page.dart';
import '../ui/pages/store/cart_page.dart';
import '../ui/pages/store/checkout_page.dart';
import '../ui/pages/store/product_details_page.dart';
import '../ui/pages/store/store_home_page.dart';
import '../ui/pages/trainers/trainer_details_page.dart';
import '../ui/pages/trainers/trainer_register_page.dart';
import '../ui/pages/trainers/trainers_list_page.dart';
import '../ui/pages/workout/workout_session_page.dart';
import '../routes/app_routes.dart';

class FadeSlideTransition extends CustomTransition {
  const FadeSlideTransition();

  @override
  Widget buildTransition(
    BuildContext context,
    Curve curve,
    Alignment alignment,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return Animate(
      adapter: AnimationAdapter(animation),
      child: child,
      effects: [
        FadeEffect(curve: Curves.easeOut),
        MoveEffect(curve: Curves.easeOut, begin: const Offset(0, 40), end: Offset.zero),
      ],
    );
  }
}

class AppPages {
  static List<GetPage<dynamic>> pages() => [
        GetPage(
          name: AppRoutes.onboarding,
          page: () => const OnboardingPage(),
          binding: BindingsBuilder(() {}),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: AppRoutes.login,
          page: () => const LoginPage(),
          binding: AuthBinding(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: AppRoutes.register,
          page: () => const RegisterPage(),
          binding: AuthBinding(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: AppRoutes.generator,
          page: () => const GeneratorPage(),
          bindings: [
            ProgramsBinding(),
            StatsBinding(),
          ],
          middlewares: [OnboardingMiddleware()],
          customTransition: const FadeSlideTransition(),
        ),
        GetPage(
          name: AppRoutes.programs,
          page: () => const ProgramsListPage(),
          bindings: [ProgramsBinding(), SearchBinding()],
          customTransition: const FadeSlideTransition(),
        ),
        GetPage(
          name: AppRoutes.programDetails,
          page: () => const ProgramDetailsPage(),
          bindings: [ProgramsBinding(), WorkoutBinding()],
          customTransition: const FadeSlideTransition(),
        ),
        GetPage(
          name: AppRoutes.warmups,
          page: () => const WarmupsPage(),
          bindings: [ProgramsBinding(), WorkoutBinding()],
          customTransition: const FadeSlideTransition(),
        ),
        GetPage(
          name: AppRoutes.session,
          page: () => const WorkoutSessionPage(),
          binding: WorkoutBinding(),
          transition: Transition.zoom,
        ),
        GetPage(
          name: AppRoutes.clips,
          page: () => const ClipsListPage(),
          binding: ClipsBinding(),
          customTransition: const FadeSlideTransition(),
        ),
        GetPage(
          name: AppRoutes.store,
          page: () => const StoreHomePage(),
          bindings: [StoreBinding(), CartBinding()],
          customTransition: const FadeSlideTransition(),
        ),
        GetPage(
          name: AppRoutes.product,
          page: () => const ProductDetailsPage(),
          bindings: [StoreBinding(), CartBinding()],
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: AppRoutes.cart,
          page: () => const CartPage(),
          binding: CartBinding(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: AppRoutes.checkout,
          page: () => const CheckoutPage(),
          binding: CartBinding(),
          middlewares: [AuthMiddleware()],
          transition: Transition.rightToLeftWithFade,
        ),
        GetPage(
          name: AppRoutes.trainers,
          page: () => const TrainersListPage(),
          bindings: [TrainersBinding(), BookingBinding()],
          customTransition: const FadeSlideTransition(),
        ),
        GetPage(
          name: AppRoutes.trainerDetails,
          page: () => const TrainerDetailsPage(),
          bindings: [TrainersBinding(), BookingBinding()],
          transition: Transition.cupertino,
        ),
        GetPage(
          name: AppRoutes.trainerRegister,
          page: () => const TrainerRegisterPage(),
          binding: TrainersBinding(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: AppRoutes.booking,
          page: () => const BookingBottomSheet(),
          binding: BookingBinding(),
          transition: Transition.downToUp,
        ),
        GetPage(
          name: AppRoutes.flexpass,
          page: () => const FlexPassPage(),
          binding: FlexPassBinding(),
          transition: Transition.cupertino,
        ),
        GetPage(
          name: AppRoutes.profile,
          page: () => const ProfileHomePage(),
          bindings: [StatsBinding(), AuthBinding()],
          customTransition: const FadeSlideTransition(),
        ),
        GetPage(
          name: AppRoutes.settings,
          page: () => const SettingsPage(),
          bindings: [ThemeBinding(), LocaleBinding()],
          transition: Transition.rightToLeft,
        ),
      ];
}
