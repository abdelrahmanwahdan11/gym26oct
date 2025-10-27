import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/programs_controller.dart';
import '../../../controllers/workout_controller.dart';
import '../../../data/models/program.dart';
import '../../../routes/app_routes.dart';
import '../../widgets/app_background.dart';
import '../../widgets/glass_container.dart';

class ProgramDetailsPage extends StatelessWidget {
  const ProgramDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Program program = Get.arguments as Program? ?? Get.find<ProgramsController>().programs.first;
    final workoutController = Get.find<WorkoutController>();
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: Get.back,
        ),
        title: Text(program.title),
      ),
      body: AppBackground(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            SizedBox(
              height: 240,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: PageView(
                  children: [
                    Image.network(program.image, fit: BoxFit.cover),
                    Image.network('https://images.unsplash.com/photo-1554344728-77cf90d9ed26', fit: BoxFit.cover),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(program.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Text('${program.level} • ${program.weeks} weeks • Coach ${program.coach}'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: [
                Chip(label: Text('${program.setsPerWeek} Sets/Week')),
                Chip(label: Text('${program.durationMinutes} minutes')),
                for (final tag in program.tags) Chip(label: Text(tag)),
              ],
            ),
            const SizedBox(height: 16),
            GlassContainer(
              padding: const EdgeInsets.all(20),
              child: Text(
                program.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      workoutController.startSession(program.exercises);
                      Get.toNamed(AppRoutes.session);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      backgroundColor: const Color(0xFF6C7CFF),
                    ),
                    child: Text('join_program'.tr, style: const TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.toNamed(AppRoutes.warmups),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                    child: Text('warmups'.tr),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
