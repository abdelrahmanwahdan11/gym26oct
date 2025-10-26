import 'package:get/get.dart';

import '../data/models/exercise.dart';
import '../data/repositories/workout_repository.dart';

class WorkoutController extends GetxController {
  WorkoutController(this._repository);

  final WorkoutRepository _repository;

  final RxList<Exercise> sessionExercises = <Exercise>[].obs;
  final RxInt currentIndex = 0.obs;
  final RxDouble progress = 0.0.obs;
  final RxInt restTimer = 30.obs;

  Future<void> startSession(List<String> exerciseIds) async {
    final items = await _repository.loadSessionExercises(exerciseIds);
    sessionExercises.assignAll(items);
    currentIndex.value = 0;
    progress.value = 0.0;
  }

  void nextExercise() {
    if (currentIndex.value < sessionExercises.length - 1) {
      currentIndex.value++;
      progress.value = currentIndex.value / sessionExercises.length;
    }
  }

  void previousExercise() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
      progress.value = currentIndex.value / sessionExercises.length;
    }
  }

  void updateRestTimer(int value) {
    restTimer.value = value;
  }
}
