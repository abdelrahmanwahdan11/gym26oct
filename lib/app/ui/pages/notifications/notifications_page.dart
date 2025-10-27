import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../../controllers/notifications_controller.dart';
import '../../widgets/app_background.dart';
import '../../widgets/glass_container.dart';

class NotificationsPage extends GetView<NotificationsController> {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('notifications'.tr),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Obx(
            () => TextButton(
              onPressed:
                  controller.notifications.isEmpty ? null : () => controller.clear(),
              child: Text('clear_all'.tr),
            ),
          )
        ],
      ),
      body: AppBackground(
        child: Obx(
          () => RefreshIndicator(
            onRefresh: controller.reload,
            child: controller.notifications.isEmpty
                ? ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      const SizedBox(height: 120),
                      Center(
                        child: Text(
                          'no_notifications'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(20),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = controller.notifications[index];
                      final timestamp = DateTime.tryParse(item['time'] as String? ?? '');
                      final subtitle = timestamp == null
                          ? ''
                          : TimeOfDay.fromDateTime(timestamp).format(context);
                      return GlassContainer(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['title'] as String? ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              item['message'] as String? ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.7),
                                  ),
                            ),
                            if (subtitle.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Text(
                                subtitle,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withOpacity(0.5),
                                    ),
                              ),
                            ],
                          ],
                        ),
                      )
                          .animate(delay: (index * 60).ms)
                          .fadeIn(duration: 260.ms, curve: Curves.easeOut)
                          .moveY(begin: 14, end: 0, curve: Curves.easeOut);
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemCount: controller.notifications.length,
                  ),
          ),
        ),
      ),
    );
  }
}
