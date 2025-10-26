import 'package:get/get.dart';

import '../controllers/locale_controller.dart';

class LocaleBinding extends Bindings {
  @override
  void dependencies() {
    Get.find<LocaleController>();
  }
}
