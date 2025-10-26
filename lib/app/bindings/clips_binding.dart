import 'package:get/get.dart';

import '../controllers/clips_controller.dart';
import '../data/repositories/clips_repository.dart';

class ClipsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ClipsRepository(), fenix: true);
    Get.lazyPut(() => ClipsController(Get.find()), fenix: true);
  }
}
