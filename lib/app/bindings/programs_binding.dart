import 'package:get/get.dart';

import '../controllers/programs_controller.dart';
import '../controllers/workout_controller.dart';
import '../data/repositories/programs_repository.dart';
import '../data/repositories/workout_repository.dart';

class ProgramsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProgramsRepository(), fenix: true);
    Get.lazyPut(() => WorkoutRepository(), fenix: true);
    Get.lazyPut(() => ProgramsController(Get.find()), fenix: true);
    Get.lazyPut(() => WorkoutController(Get.find()), fenix: true);
  }
}
