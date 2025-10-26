import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../data/feature_catalog.dart';

class FeatureCatalogSection extends StatelessWidget {
  const FeatureCatalogSection({super.key, required this.pageKey, this.title});

  final String pageKey;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final features = FeatureCatalog.featuresFor(pageKey);
    if (features.isEmpty) {
      return const SizedBox.shrink();
    }
    final total = FeatureCatalog.totalFeatureCountFor(pageKey);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title ?? 'Feature Drops • $total',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.12),
                ),
                child: Text('${FeatureCatalog.totalFeatureCount()} مجموع الابتكارات'),
              ),
            ],
          ).animate().fadeIn(duration: 260.ms).moveY(begin: 12, end: 0),
          const SizedBox(height: 16),
          ...features.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: _FeatureGroup(name: entry.key, items: entry.value),
            );
          }),
        ],
      ),
    );
  }
}

class _FeatureGroup extends StatelessWidget {
  const _FeatureGroup({required this.name, required this.items});

  final String name;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final chipColor = isDark
        ? Colors.white.withOpacity(0.12)
        : theme.colorScheme.surface.withOpacity(0.86);
    final textColor = isDark
        ? Colors.white.withOpacity(0.9)
        : theme.colorScheme.onSurface.withOpacity(0.84);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withOpacity(isDark ? 0.22 : 0.12),
            theme.colorScheme.secondary.withOpacity(isDark ? 0.18 : 0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: theme.colorScheme.onSurface.withOpacity(0.08)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: items
                .map((item) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: chipColor,
                        border: Border.all(color: theme.colorScheme.primary.withOpacity(0.12)),
                      ),
                      child: Text(
                        item,
                        style: theme.textTheme.bodyMedium?.copyWith(color: textColor),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 320.ms).moveY(begin: 16, end: 0);
  }
}
