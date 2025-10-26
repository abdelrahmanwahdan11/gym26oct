import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/workout_controller.dart';
import '../../widgets/app_background.dart';

class WorkoutSessionPage extends GetView<WorkoutController> {
  const WorkoutSessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Session'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AppBackground(
        child: Obx(
          () {
            final exercises = controller.sessionExercises;
            final current = exercises.isNotEmpty
                ? exercises[controller.currentIndex.value]
                : null;
            return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: Image.network(
                    current?.image ?? 'https://images.unsplash.com/photo-1546484959-f9a53db89c2d',
                    height: 220,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: 160,
                  height: 160,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: controller.progress.value,
                        strokeWidth: 12,
                        backgroundColor: Colors.white24,
                      ),
                      Text(
                        current?.title ?? 'Ready',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text('Rest Timer: ${controller.restTimer.value}s'),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: controller.previousExercise,
                          child: const Text('Prev'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: controller.nextExercise,
                          child: const Text('Next'),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
