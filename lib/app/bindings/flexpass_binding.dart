import 'package:get/get.dart';

import '../controllers/flexpass_controller.dart';
import '../data/repositories/flexpass_repository.dart';

class FlexPassBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FlexPassRepository(), fenix: true);
    Get.lazyPut(() => FlexPassController(Get.find()), fenix: true);
  }
}
