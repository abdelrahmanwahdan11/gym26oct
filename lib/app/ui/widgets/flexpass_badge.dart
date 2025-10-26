import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'glass_container.dart';

class FlexPassBadge extends StatelessWidget {
  const FlexPassBadge({super.key, required this.tier, required this.expiry});

  final String tier;
  final String expiry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GlassContainer(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: const LinearGradient(colors: [Color(0xFF6C7CFF), Color(0xFFA77DFF)]),
            ),
            alignment: Alignment.center,
            child: Text(
              tier,
              style: theme.textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('FlexPass', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text('Expires $expiry',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.6))),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(260.ms).moveY(begin: 14, end: 0);
  }
}
