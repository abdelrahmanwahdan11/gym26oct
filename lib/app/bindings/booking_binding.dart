import 'package:get/get.dart';

import '../controllers/booking_controller.dart';
import '../data/repositories/prefs_repository.dart';

class BookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookingController(Get.find<PrefsRepository>()),
        fenix: true);
  }
}
