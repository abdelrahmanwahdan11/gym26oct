import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../controllers/workout_controller.dart';

class WorkoutSessionScreen extends StatelessWidget {
  const WorkoutSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WorkoutController>(
      builder: (workout) {
        return Scaffold(
          appBar: AppBar(title: const Text('Live Session')),
          body: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Image.network(
                  'https://images.unsplash.com/photo-1546484959-f9a53db89c2d',
                  height: 240,
                  fit: BoxFit.cover,
                ),
              ).animate().fadeIn(duration: 280.ms).moveY(begin: 16, end: 0),
              const SizedBox(height: 32),
              Center(
                child: SizedBox(
                  width: 180,
                  height: 180,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: workout.progress,
                        strokeWidth: 12,
                        backgroundColor: Theme.of(context).dividerColor,
                      ),
                      Text('${(workout.progress * 100).round()}%',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Theme.of(context).cardColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('اسحب لأعلى لرؤية التمرين التالي', style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.pause_circle),
                          iconSize: 48,
                          onPressed: workout.pauseSession,
                        ),
                        IconButton(
                          icon: const Icon(Icons.skip_next_rounded),
                          iconSize: 48,
                          onPressed: workout.skipAhead,
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text('Rest Timer'),
                            Text('${workout.restSeconds}s', style: Theme.of(context).textTheme.titleLarge),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: workout.startSession,
                style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(52), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
                child: const Text('Start Workout'),
              ),
            ],
          ),
        );
      },
    );
  }
}
