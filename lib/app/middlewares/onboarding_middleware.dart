import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repositories/prefs_repository.dart';
import '../routes/app_routes.dart';

class OnboardingMiddleware extends GetMiddleware {
  OnboardingMiddleware({int priority = 1}) : super(priority: priority);

  PrefsRepository get _prefs => Get.find<PrefsRepository>();

  @override
  RouteSettings? redirect(String? route) {
    if (!_prefs.onboardingDone && route != AppRoutes.onboarding) {
      return const RouteSettings(name: AppRoutes.onboarding);
    }
    return null;
  }
}
