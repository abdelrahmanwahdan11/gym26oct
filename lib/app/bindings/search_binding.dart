import 'package:get/get.dart';

import '../controllers/programs_controller.dart';
import '../controllers/search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchController(Get.find<ProgramsController>()),
        fenix: true);
  }
}
