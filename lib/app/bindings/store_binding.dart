import 'package:get/get.dart';

import '../controllers/store_controller.dart';
import '../data/repositories/store_repository.dart';

class StoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StoreRepository(), fenix: true);
    Get.lazyPut(() => StoreController(Get.find()), fenix: true);
  }
}
