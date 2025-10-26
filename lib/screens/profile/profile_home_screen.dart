import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/app_scope.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/stat_card.dart';

class ProfileHomeScreen extends StatelessWidget {
  const ProfileHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final auth = scope.auth;
    return AnimatedBuilder(
      animation: auth,
      builder: (context, _) {
        final user = auth.user;
        return AppScaffold(
          activeTab: 'profile',
          onTabSelected: (tab) => _handleTab(context, tab),
          body: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Row(
                children: [
                  const CircleAvatar(radius: 40, backgroundImage: NetworkImage('https://i.pravatar.cc/120?img=64')),
                  const SizedBox(width: 16),
                  if (user != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.name, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                        Text(user.email),
                      ],
                    ),
                  const Spacer(),
                  IconButton(onPressed: scope.settings.toggleTheme, icon: const Icon(Icons.brightness_6)),
                ],
              ),
              const SizedBox(height: 24),
              const Text('Performance'),
              const SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1,
                children: const [
                  StatCard(title: 'BMI', value: '21.3'),
                  StatCard(title: 'Water Intake', value: '6 cups'),
                ],
              ),
              const SizedBox(height: 24),
              ListTile(
                title: const Text('FlexPass'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Get.toNamed('/flexpass'),
              ),
              const SizedBox(height: 12),
              ListTile(
                title: const Text('Stats'),
                trailing: const Icon(Icons.bar_chart),
                onTap: () => Get.toNamed('/stats'),
              ),
              const SizedBox(height: 12),
              ListTile(
                title: const Text('Settings'),
                trailing: const Icon(Icons.settings_outlined),
                onTap: () => Get.toNamed('/settings'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleTab(BuildContext context, String tab) {
    if (tab == 'profile') return;
    Get.offNamed(_tabToRoute(tab));
  }

  String _tabToRoute(String tab) {
    switch (tab) {
      case 'generator':
        return '/home/generator';
      case 'programs':
        return '/programs';
      case 'clips':
        return '/clips';
      case 'store':
        return '/store';
      case 'trainers':
        return '/trainers';
      default:
        return '/profile';
    }
  }
}
