import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../data/models/exercise.dart';
import 'glass_container.dart';

class ExerciseTile extends StatelessWidget {
  const ExerciseTile({super.key, required this.exercise});

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GlassContainer(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.network(exercise.image, width: 72, height: 72, fit: BoxFit.cover),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(exercise.title,
                    style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Text('${exercise.durationSeconds}s • Rest ${exercise.restSeconds}s',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.6))),
              ],
            ),
          )
        ],
      ),
    ).animate(interval: 60.ms).fadeIn(260.ms).moveY(begin: 14, end: 0, curve: Curves.easeOut);
  }
}
