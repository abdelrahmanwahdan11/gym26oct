import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class StatCard extends StatelessWidget {
  const StatCard({super.key, required this.title, required this.value, this.subtitle});

  final String title;
  final String value;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(colors: [theme.colorScheme.primary.withOpacity(0.12), theme.cardColor]),
        border: Border.all(color: theme.dividerColor.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text(value, style: theme.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold)),
          if (subtitle != null) ...[
            const SizedBox(height: 6),
            Text(subtitle!, style: theme.textTheme.bodySmall),
          ],
          const SizedBox(height: 12),
          Expanded(
            child: CustomPaint(
              painter: _MiniBarPainter(color: theme.colorScheme.primary),
              child: const SizedBox.expand(),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 280.ms).moveY(begin: 16, end: 0).shimmer(duration: 1600.ms);
  }
}

class _MiniBarPainter extends CustomPainter {
  _MiniBarPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    const bars = [0.4, 0.6, 0.9, 0.5, 0.7];
    final barWidth = size.width / (bars.length * 1.5);
    for (var i = 0; i < bars.length; i++) {
      final x = i * barWidth * 1.5;
      final barHeight = size.height * bars[i];
      final rect = Rect.fromLTWH(x, size.height - barHeight, barWidth, barHeight);
      final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(6));
      canvas.drawRRect(rrect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _MiniBarPainter oldDelegate) => oldDelegate.color != color;
}
