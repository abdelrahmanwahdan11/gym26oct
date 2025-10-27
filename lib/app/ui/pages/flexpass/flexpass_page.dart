import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/flexpass_controller.dart';
import '../../widgets/app_background.dart';
import '../../widgets/flexpass_badge.dart';
import '../../widgets/glass_container.dart';

class FlexPassPage extends GetView<FlexPassController> {
  const FlexPassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('flexpass'.tr),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AppBackground(
        child: Obx(() {
          final pass = controller.flexPass.value;
          if (pass == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              FlexPassBadge(tier: pass.tier, expiry: pass.expiry),
              const SizedBox(height: 20),
              GlassContainer(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('weekly_schedule'.tr,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    for (final item in pass.weeklySchedule)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            Text(item['day'] as String),
                            const SizedBox(width: 12),
                            Expanded(child: Text('${item['class']} @ ${item['club']} ${item['time']}')),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GlassContainer(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('perks'.tr, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 12),
                    for (final perk in pass.perks)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            const Icon(Icons.check, color: Color(0xFF6C7CFF)),
                            const SizedBox(width: 12),
                            Expanded(child: Text(perk)),
                          ],
                        ),
                      ),
                  ],
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
