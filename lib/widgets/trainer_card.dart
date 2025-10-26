import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../data/models/trainer.dart';

class TrainerCard extends StatelessWidget {
  const TrainerCard({super.key, required this.trainer, this.onTap});

  final Trainer trainer;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.all(16),
      leading: CircleAvatar(backgroundImage: NetworkImage(trainer.avatar), radius: 32),
      title: Text(trainer.name, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('⭐ ${trainer.rating.toStringAsFixed(1)} • ${trainer.specialties.join(', ')}',
              style: theme.textTheme.bodySmall),
          const SizedBox(height: 4),
          Text('${trainer.pricePerSession.toStringAsFixed(0)} USD / session', style: theme.textTheme.bodySmall),
        ],
      ),
      trailing: const Icon(Icons.chevron_right),
    ).animate(interval: 60.ms).fadeIn().scale(begin: 0.98, end: 1);
  }
}
