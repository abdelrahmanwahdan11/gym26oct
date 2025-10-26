import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../data/models/trainer.dart';
import '../../routes/app_routes.dart';
import 'glass_container.dart';

class TrainerCard extends StatelessWidget {
  const TrainerCard({super.key, required this.trainer});

  final Trainer trainer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.trainerDetails, arguments: trainer),
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(radius: 32, backgroundImage: NetworkImage(trainer.avatar)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(trainer.name,
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  Text('${trainer.specialties.join(' • ')}',
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.62))),
                  const SizedBox(height: 6),
                  Text('${trainer.pricePerSession.toStringAsFixed(0)} / session',
                      style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              children: [
                Icon(Icons.star, color: Colors.amber.shade400),
                Text(trainer.rating.toStringAsFixed(1)),
              ],
            )
          ],
        ),
      ).animate(interval: 60.ms).fadeIn().scale(begin: 0.98, end: 1),
    );
  }
}
