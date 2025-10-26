import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../data/repositories/prefs_repository.dart';
import '../data/repositories/store_repository.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StoreRepository(), fenix: true);
    Get.lazyPut(() => CartController(Get.find<PrefsRepository>(), Get.find()),
        fenix: true);
  }
}
