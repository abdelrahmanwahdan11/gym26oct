import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/auth_controller.dart';
import '../controllers/locale_controller.dart';
import '../controllers/notifications_controller.dart';
import '../controllers/theme_controller.dart';
import '../data/repositories/prefs_repository.dart';
import '../services/prefs_service.dart';

class AppBindings extends Bindings {
  AppBindings(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  @override
  void dependencies() {
    final prefsService = PrefsService(sharedPreferences: sharedPreferences);
    final prefsRepository = PrefsRepository(prefsService);
    Get.put(prefsService, permanent: true);
    Get.put(prefsRepository, permanent: true);
    Get.put(ThemeController(prefsRepository), permanent: true);
    Get.put(LocaleController(prefsRepository), permanent: true);
    Get.put(NotificationsController(prefsRepository), permanent: true);
    Get.put(AuthController(prefsRepository), permanent: true);
  }
}
