import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/programs_controller.dart';
import '../../../controllers/workout_controller.dart';
import '../../../routes/app_routes.dart';
import '../../widgets/app_background.dart';
import '../../widgets/exercise_tile.dart';

class WarmupsPage extends GetView<ProgramsController> {
  const WarmupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final workoutController = Get.find<WorkoutController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Warm-ups'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AppBackground(
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: controller.loadInitial,
                child: Obx(
                  () => ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, index) => ExerciseTile(exercise: controller.warmups[index]),
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemCount: controller.warmups.length,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    backgroundColor: const Color(0xFF6C7CFF),
                  ),
                  onPressed: () {
                    workoutController.startSession(controller.warmups.map((e) => e.id).toList());
                    Get.toNamed(AppRoutes.session);
                  },
                  child: Text('start_workout'.tr, style: const TextStyle(color: Colors.white)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
