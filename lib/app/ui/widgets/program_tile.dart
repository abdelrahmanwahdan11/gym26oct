import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../data/models/program.dart';
import '../../routes/app_routes.dart';
import 'glass_container.dart';

class ProgramTile extends StatelessWidget {
  const ProgramTile({super.key, required this.program});

  final Program program;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.programDetails, arguments: program),
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.network(program.image, height: 120, width: double.infinity, fit: BoxFit.cover),
            ),
            const SizedBox(height: 12),
            Text(program.title,
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Text('${program.level} • ${program.weeks} weeks',
                style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.62))),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.schedule, size: 16, color: theme.colorScheme.primary),
                const SizedBox(width: 6),
                Text('${program.durationMinutes} min',
                    style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
      ).animate().fadeIn(260.ms).moveY(begin: 14, end: 0, curve: Curves.easeOut),
    );
  }
}
