import 'package:get/get.dart';

import '../controllers/trainers_controller.dart';
import '../data/repositories/trainers_repository.dart';

class TrainersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TrainersRepository(), fenix: true);
    Get.lazyPut(() => TrainersController(Get.find()), fenix: true);
  }
}
