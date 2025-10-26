import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../controllers/stats_controller.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/stat_card.dart';

class ProfileHomePage extends StatelessWidget {
  const ProfileHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    final stats = Get.find<StatsController>();
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: auth.logout,
          )
        ],
      ),
      body: AppBackground(
        child: Obx(
          () {
            final user = auth.currentUser.value;
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                ListTile(
                  leading: CircleAvatar(
                    radius: 32,
                    backgroundImage: NetworkImage(user?.avatar ?? 'https://i.pravatar.cc/120?img=64'),
                  ),
                  title: Text(user?.name ?? 'Athletica User'),
                  subtitle: Text(user?.email ?? 'user@example.com'),
                ),
                const SizedBox(height: 20),
                Obx(
                  () => GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: [
                      StatCard(title: 'Total Volume', value: '${stats.monthly['volume']} lbs'),
                      StatCard(title: 'Streak', value: '${stats.monthly['streak']} days'),
                      StatCard(title: 'Hydration', value: '${stats.monthly['hydration']} %'),
                      const StatCard(title: 'FlexPass', value: 'Active', subtitle: 'Tap to view'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Get.toNamed('/flexpass'),
                  child: Text('flexpass'.tr),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: AppBottomNav(active: 'profile'),
    );
  }
}
