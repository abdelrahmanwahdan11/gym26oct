import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/app_scope.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/feature_catalog_section.dart';
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
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  gradient: LinearGradient(
                    colors: [Theme.of(context).colorScheme.primary.withOpacity(0.85), Theme.of(context).colorScheme.secondary.withOpacity(0.75)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(radius: 42, backgroundImage: NetworkImage('https://i.pravatar.cc/120?img=64')),
                    const SizedBox(width: 16),
                    if (user != null)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                            Text(user.email, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70)),
                            Text('${user.goal} • ${user.level}',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white70)),
                          ],
                        ),
                      ),
                    IconButton(onPressed: scope.settings.toggleTheme, icon: const Icon(Icons.brightness_6, color: Colors.white)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text('لوحة الأداء', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
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
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  _QuickAction(
                    icon: Icons.auto_graph,
                    label: 'Stats',
                    onTap: () => Get.toNamed('/stats'),
                  ),
                  _QuickAction(
                    icon: Icons.style,
                    label: 'FlexPass',
                    onTap: () => Get.toNamed('/flexpass'),
                  ),
                  _QuickAction(
                    icon: Icons.emoji_events_outlined,
                    label: 'Challenges',
                    onTap: () => Get.toNamed('/challenges'),
                  ),
                  _QuickAction(
                    icon: Icons.settings_outlined,
                    label: 'Settings',
                    onTap: () => Get.toNamed('/settings'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.lock_outline),
                      title: const Text('Privacy & Security'),
                      subtitle: const Text('إدارة كلمات المرور والأجهزة الموثوقة'),
                      onTap: () => Get.toNamed('/settings'),
                    ),
                    const Divider(height: 0),
                    ListTile(
                      leading: const Icon(Icons.palette_outlined),
                      title: const Text('Theme & Locale'),
                      subtitle: Text(scope.settings.isArabic ? 'الوضع الحالي: عربي' : 'Current: English'),
                      onTap: () => Get.toNamed('/settings'),
                    ),
                    const Divider(height: 0),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('تسجيل الخروج'),
                      subtitle: const Text('اخرج بأمان من حسابك الحالي'),
                      onTap: () {
                        scope.auth.logout();
                        Get.offAllNamed('/auth/login');
                      },
                    ),
                  ],
                ),
              ),
              FeatureCatalogSection(pageKey: 'profile', title: 'ابتكارات صفحة الملف الشخصي'),
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

class _QuickAction extends StatelessWidget {
  const _QuickAction({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.14),
              Theme.of(context).colorScheme.secondary.withOpacity(0.08),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.12)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 26, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 12),
            Text(label, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text('استكشف التفاصيل',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
                    )),
          ],
        ),
      ),
    );
  }
}
