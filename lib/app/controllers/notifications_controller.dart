import 'package:get/get.dart';

import '../data/repositories/prefs_repository.dart';

class NotificationsController extends GetxController {
  NotificationsController(this._prefsRepository);

  final PrefsRepository _prefsRepository;
  final RxList<Map<String, dynamic>> notifications = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    notifications.assignAll(_prefsRepository.notifications);
  }

  Future<void> pushNotification(String title, String message) async {
    final payload = {
      'title': title,
      'message': message,
      'time': DateTime.now().toIso8601String(),
    };
    notifications.insert(0, payload);
    await _prefsRepository.saveNotifications(notifications);
  }

  Future<void> clear() async {
    notifications.clear();
    await _prefsRepository.saveNotifications(const []);
  }
}
