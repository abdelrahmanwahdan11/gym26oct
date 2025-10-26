import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../routes/app_routes.dart';

class AuthMiddleware extends GetMiddleware {
  AuthMiddleware({int priority = 2}) : super(priority: priority);

  AuthController get _auth => Get.find<AuthController>();

  @override
  RouteSettings? redirect(String? route) {
    if (!_auth.isLoggedIn) {
      return const RouteSettings(name: AppRoutes.login);
    }
    return null;
  }
}
