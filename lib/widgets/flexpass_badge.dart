import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FlexPassBadge extends StatelessWidget {
  const FlexPassBadge({super.key, required this.tier, required this.nextExpiry});

  final String tier;
  final String nextExpiry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(colors: [theme.colorScheme.primary, theme.colorScheme.secondary]),
      ),
      child: Row(
        children: [
          const Icon(Icons.local_activity, color: Colors.white, size: 36),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('FlexPass $tier', style: theme.textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text('Valid till $nextExpiry', style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70)),
            ],
          )
        ],
      ),
    ).animate().fadeIn(duration: 280.ms).moveY(begin: 12, end: 0).shimmer(duration: 1600.ms);
  }
}
