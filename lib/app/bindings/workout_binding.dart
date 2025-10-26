import 'package:get/get.dart';

import '../controllers/workout_controller.dart';
import '../data/repositories/workout_repository.dart';

class WorkoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WorkoutRepository(), fenix: true);
    Get.lazyPut(() => WorkoutController(Get.find()), fenix: true);
  }
}
