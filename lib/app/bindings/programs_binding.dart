import 'package:get/get.dart';

import '../controllers/programs_controller.dart';
import '../data/repositories/programs_repository.dart';

class ProgramsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProgramsRepository(), fenix: true);
    Get.lazyPut(() => ProgramsController(Get.find()), fenix: true);
  }
}
