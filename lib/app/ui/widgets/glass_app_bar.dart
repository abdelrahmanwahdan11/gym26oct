import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'glass_container.dart';

class GlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GlassAppBar({super.key, this.title, this.onSettings, this.onNotifications});

  final String? title;
  final VoidCallback? onSettings;
  final VoidCallback? onNotifications;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 28, 16, 12),
      child: GlassContainer(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        borderRadius: BorderRadius.circular(24),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title ?? '',
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.notifications_none),
              onPressed: onNotifications ?? () => Get.toNamed('/notifications'),
            ),
            const SizedBox(width: 4),
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: onSettings ?? () => Get.toNamed('/settings'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(86);
}
