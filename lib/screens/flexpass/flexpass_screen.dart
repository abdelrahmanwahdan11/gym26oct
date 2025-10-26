import 'package:flutter/material.dart';

import '../../controllers/app_scope.dart';
import '../../widgets/feature_catalog_section.dart';
import '../../widgets/flexpass_badge.dart';

class FlexPassScreen extends StatelessWidget {
  const FlexPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final flexPassController = AppScope.of(context).flexPass;
    return AnimatedBuilder(
      animation: flexPassController,
      builder: (context, _) {
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
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('تمت مشاركة FlexPass مع الأصدقاء (Mock)')));
                },
                icon: const Icon(Icons.share_outlined),
                label: const Text('شارك امتيازات FlexPass'),
              ),
              FeatureCatalogSection(pageKey: 'flexpass', title: 'ابتكارات FlexPass'),
            ],
          ),
        );
      },
    );
  }
}
