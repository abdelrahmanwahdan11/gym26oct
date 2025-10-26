import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../data/models/clip.dart';

class ClipTile extends StatelessWidget {
  const ClipTile({super.key, required this.clip, this.onTap});

  final ClipItem clip;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.all(12),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            Image.network(clip.thumb, width: 72, height: 72, fit: BoxFit.cover),
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.black54, Colors.transparent]),
                ),
              ),
            ),
            const Positioned.fill(child: Icon(Icons.play_circle_fill, color: Colors.white70, size: 34)),
          ],
        ),
      ),
      title: Text(clip.title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
      subtitle: Text('${clip.durationSec ~/ 60} min • ${clip.coach}', style: theme.textTheme.bodySmall),
    ).animate(interval: 60.ms).fadeIn().scale(begin: 0.98, end: 1);
  }
}
