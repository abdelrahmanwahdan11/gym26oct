import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HeroProgramCard extends StatelessWidget {
  const HeroProgramCard({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: const LinearGradient(colors: [Color(0xFF6C7CFF), Color(0xFF7CD4F9)]),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Get Set, Ready for Warm-Up',
                      style: theme.textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Start workout with guided warm-ups and shimmering hero cards.',
                      style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: theme.colorScheme.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                    ),
                    child: const Text('ابدأ التمرين'),
                  )
                ],
              ),
            ),
            const SizedBox(width: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.network(
                'https://images.unsplash.com/photo-1517836357463-d25dfeac3438',
                width: 120,
                height: 140,
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
      ),
    ).animate().shimmer(duration: 1600.ms).fadeIn(duration: 280.ms).moveY(begin: 12, end: 0);
  }
}
