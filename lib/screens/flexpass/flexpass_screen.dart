import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/flexpass_controller.dart';
import '../../widgets/flexpass_badge.dart';

class FlexPassScreen extends StatelessWidget {
  const FlexPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FlexPassController>(
      builder: (flexPassController) {
        final flexPass = flexPassController.flexPass;
        if (flexPass == null) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        return Scaffold(
          appBar: AppBar(title: const Text('FlexPass')),
          body: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              FlexPassBadge(tier: flexPass.tier, nextExpiry: flexPass.expiry),
              const SizedBox(height: 24),
              Text('بطاقة اشتراك تتيح لك التدريب في عدة أندية مع جدول أسبوعي مرن.',
                  style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 24),
              Text('Weekly Schedule', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ...flexPass.weeklySchedule.map(
                (item) => Card(
                  child: ListTile(
                    title: Text('${item['day']} — ${item['class']}'),
                    subtitle: Text('${item['club']} • ${item['time']}'),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text('Perks', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ...flexPass.perks.map((perk) => ListTile(leading: const Icon(Icons.check), title: Text(perk))).toList(),
              const SizedBox(height: 24),
              ListTile(
                title: const Text('Expiry'),
                trailing: Text(flexPass.expiry),
              ),
              ListTile(
                title: const Text('Clubs Allowed'),
                trailing: Text(flexPass.clubsAllowed.toString()),
              ),
            ],
          ),
        );
      },
    );
  }
}
