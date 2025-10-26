import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';

class AppBottomNav extends StatelessWidget {
  AppBottomNav({super.key, required this.active});

  final String active;

  final List<_NavItem> _items = const [
    _NavItem(id: 'generator', labelKey: 'generator', icon: Icons.bolt, route: AppRoutes.generator),
    _NavItem(id: 'programs', labelKey: 'programs', icon: Icons.layers, route: AppRoutes.programs),
    _NavItem(id: 'clips', labelKey: 'clips', icon: Icons.play_circle_fill, route: AppRoutes.clips),
    _NavItem(id: 'store', labelKey: 'store', icon: Icons.shopping_bag, route: AppRoutes.store),
    _NavItem(id: 'trainers', labelKey: 'trainers', icon: Icons.group, route: AppRoutes.trainers),
    _NavItem(id: 'profile', labelKey: 'profile', icon: Icons.person, route: AppRoutes.profile),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacity(0.94),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: theme.colorScheme.onSurface.withOpacity(0.08)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _items.map((item) {
          final selected = item.id == active;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                if (!selected) {
                  Get.offAllNamed(item.route);
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                decoration: BoxDecoration(
                  color: selected
                      ? theme.colorScheme.primary.withOpacity(0.14)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(item.icon,
                        color: selected
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurface.withOpacity(0.48)),
                    const SizedBox(height: 4),
                    Text(
                      item.labelKey.tr,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: selected
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurface.withOpacity(0.48),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _NavItem {
  const _NavItem({
    required this.id,
    required this.labelKey,
    required this.icon,
    required this.route,
  });

  final String id;
  final String labelKey;
  final IconData icon;
  final String route;
}
