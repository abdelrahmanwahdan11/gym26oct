import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/app_scope.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/chip_filter_row.dart';
import '../../widgets/feature_catalog_section.dart';
import '../../widgets/glass_app_bar.dart';
import '../../widgets/hero_program_card.dart';
import '../../widgets/program_tile.dart';
import '../../widgets/stat_card.dart';

class GeneratorScreen extends StatefulWidget {
  const GeneratorScreen({super.key});

  @override
  State<GeneratorScreen> createState() => _GeneratorScreenState();
}

class _GeneratorScreenState extends State<GeneratorScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final controller = AppScope.of(context).programs;
    if (_scrollController.position.pixels > _scrollController.position.maxScrollExtent - 200) {
      controller.loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final programs = scope.programs;
    return AnimatedBuilder(
      animation: programs,
      builder: (context, _) {
        return AppScaffold(
          activeTab: 'generator',
          onTabSelected: (tab) => _handleTab(context, tab),
          appBar: GlassAppBar(title: 'Ready to Workout', actions: [
            IconButton(onPressed: scope.settings.toggleTheme, icon: const Icon(Icons.brightness_6)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none)),
          ]),
          body: RefreshIndicator(
            onRefresh: programs.refresh,
            child: ListView(
              controller: _scrollController,
              padding: const EdgeInsets.only(bottom: 120),
              children: [
                const SizedBox(height: 12),
                ChipFilterRow(
                  items: const ['Upper Body', 'Build Strength', 'Beginner', 'HIIT', 'Mobility'],
                  selected: programs.levelFilter,
                  onSelected: (value) {
                    programs.setLevelFilter(value == programs.levelFilter ? null : value);
                  },
                ),
                const SizedBox(height: 16),
                HeroProgramCard(onTap: () => Get.toNamed('/session')),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Basic Warm-up Activities',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 12),
                ...programs.programs
                    .map((program) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          child: ProgramTile(
                            program: program,
                            isFavorite: programs.favorites.contains(program.id),
                            onTap: () => Get.toNamed('/program/${program.id}'),
                            onFavorite: () => programs.toggleFavorite(program.id),
                          ),
                        ))
                    .toList(),
                if (programs.isLoading)
                  const Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Your Progress',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1,
                    children: const [
                      StatCard(title: 'Total Volume', value: '432 lbs', subtitle: '+12%'),
                      StatCard(title: 'Weekly Streak', value: '5 days', subtitle: '🔥 Keep going'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: () => Get.toNamed('/innovation'),
                  child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        gradient: LinearGradient(
                          colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
                        ),
                        boxShadow: const [
                          BoxShadow(color: Color.fromARGB(32, 16, 24, 64), blurRadius: 28, offset: Offset(0, 18)),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Innovation Lab',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 8),
                                Text('30 فكرة مستقبلية بانتظارك — استكشفها كتجربة تفاعلية.',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white.withOpacity(0.8))),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Icon(Icons.auto_awesome, color: Colors.white, size: 36),
                        ],
                      ),
                    ),
                ),
              ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    onTap: () => Get.toNamed('/challenges'),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        color: Theme.of(context).colorScheme.surface.withOpacity(0.92),
                        border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.18)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('لوحة التحديات الجديدة',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontWeight: FontWeight.bold)),
                                const SizedBox(height: 6),
                                Text('أنهِ مهام المجتمع وشارك إنجازك مباشرة.',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.8))),
                              ],
                            ),
                          ),
                          const Icon(Icons.emoji_events_outlined, size: 32),
                        ],
                      ),
                    ),
                  ),
                ),
                FeatureCatalogSection(pageKey: 'generator', title: 'ابتكارات صفحة المولد'),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleTab(BuildContext context, String tab) {
    if (tab == 'generator') return;
    Get.offNamed(_tabToRoute(tab));
  }

  String _tabToRoute(String tab) {
    switch (tab) {
      case 'programs':
        return '/programs';
      case 'clips':
        return '/clips';
      case 'store':
        return '/store';
      case 'trainers':
        return '/trainers';
      case 'profile':
        return '/profile';
      default:
        return '/home/generator';
    }
  }
}
