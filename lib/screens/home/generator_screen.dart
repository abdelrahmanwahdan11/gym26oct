import 'package:flutter/material.dart';

import '../../controllers/app_scope.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/chip_filter_row.dart';
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
                HeroProgramCard(onTap: () => Navigator.of(context).pushNamed('workout.session')),
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
                            onTap: () => Navigator.of(context).pushNamed('program.details', arguments: program.id),
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
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleTab(BuildContext context, String tab) {
    if (tab == 'generator') return;
    Navigator.of(context).pushReplacementNamed(_tabToRoute(tab));
  }

  String _tabToRoute(String tab) {
    switch (tab) {
      case 'programs':
        return 'programs.list';
      case 'clips':
        return 'clips.list';
      case 'store':
        return 'store.home';
      case 'trainers':
        return 'trainers.list';
      case 'profile':
        return 'profile.home';
      default:
        return 'home.generator';
    }
  }
}
