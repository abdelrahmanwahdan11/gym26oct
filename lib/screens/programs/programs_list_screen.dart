import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/app_scope.dart';
import '../../controllers/programs_controller.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/program_tile.dart';

class ProgramsListScreen extends StatefulWidget {
  const ProgramsListScreen({super.key});

  @override
  State<ProgramsListScreen> createState() => _ProgramsListScreenState();
}

class _ProgramsListScreenState extends State<ProgramsListScreen> {
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
    final programs = AppScope.of(context).programs;
    return AnimatedBuilder(
      animation: programs,
      builder: (context, _) {
        return AppScaffold(
          activeTab: 'programs',
          onTabSelected: (tab) => _handleTab(context, tab),
          body: RefreshIndicator(
            onRefresh: programs.refresh,
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  floating: true,
                  snap: true,
                  title: TextField(
                    decoration: const InputDecoration(hintText: 'ابحث عن برنامج… / Search program…'),
                    onChanged: programs.search,
                  ),
                  actions: [
                    IconButton(
                      onPressed: () => Get.toNamed('filters.sheet'),
                      icon: const Icon(Icons.filter_alt_outlined),
                    )
                  ],
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(20),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final program = programs.programs[index];
                        return ProgramTile(
                          program: program,
                          isFavorite: programs.favorites.contains(program.id),
                          onTap: () => Get.toNamed('program.details', arguments: program.id),
                          onFavorite: () => programs.toggleFavorite(program.id),
                        );
                      },
                      childCount: programs.programs.length,
                    ),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.68,
                    ),
                  ),
                ),
                if (programs.isLoading)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Center(child: CircularProgressIndicator()),
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
    if (tab == 'programs') return;
    Get.offNamed(_tabToRoute(tab));
  }

  String _tabToRoute(String tab) {
    switch (tab) {
      case 'generator':
        return 'home.generator';
      case 'clips':
        return 'clips.list';
      case 'store':
        return 'store.home';
      case 'trainers':
        return 'trainers.list';
      case 'profile':
        return 'profile.home';
      default:
        return 'programs.list';
    }
  }
}
