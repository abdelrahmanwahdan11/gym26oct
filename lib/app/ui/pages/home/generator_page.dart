import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/programs_controller.dart';
import '../../../controllers/stats_controller.dart';
import '../../../routes/app_routes.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/chip_filter_row.dart';
import '../../widgets/exercise_tile.dart';
import '../../widgets/glass_app_bar.dart';
import '../../widgets/hero_program_card.dart';
import '../../widgets/program_tile.dart';
import '../../widgets/stat_card.dart';

class GeneratorPage extends GetView<ProgramsController> {
  const GeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = Get.find<StatsController>();
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      appBar: const GlassAppBar(title: 'Ready to Workout'),
      body: AppBackground(
        child: RefreshIndicator(
          onRefresh: controller.loadInitial,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                const ChipFilterRow(
                  filters: ['Upper Body', 'Build Strength', 'Beginner', 'HIIT', 'Mobility'],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: HeroProgramCard(
                    image: 'https://images.unsplash.com/photo-1517836357463-d25dfeac3438',
                    title: 'Get Set, Ready for Warm-Up',
                    route: AppRoutes.session,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Text('Basic Warm-up Activities',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                ),
                Obx(
                  () => ListView.separated(
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ExerciseTile(exercise: controller.warmups[index]),
                    ),
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemCount: controller.warmups.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Text('Featured Programs',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                ),
                Obx(
                  () => GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.programs.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.74,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemBuilder: (context, index) => ProgramTile(program: controller.programs[index]),
                  ),
                ),
                if (controller.hasMore.value)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: ElevatedButton(
                      onPressed: controller.loadMore,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.12),
                        foregroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      ),
                      child: const Text('Load more'),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Text('Your Progress',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      childAspectRatio: 1.1,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      children: [
                        StatCard(title: 'Total Volume', value: '${stats.monthly['volume']} lbs'),
                        StatCard(title: 'Streak', value: '${stats.monthly['streak']} days'),
                        StatCard(title: 'Hydration', value: '${stats.monthly['hydration']} %'),
                        const StatCard(title: 'FlexPass', value: 'Pro', subtitle: 'Multi-club access'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNav(active: 'generator'),
    );
  }
}
