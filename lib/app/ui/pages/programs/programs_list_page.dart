import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/programs_controller.dart';
import '../../../controllers/search_controller.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/program_tile.dart';

class ProgramsListPage extends StatefulWidget {
  const ProgramsListPage({super.key});

  @override
  State<ProgramsListPage> createState() => _ProgramsListPageState();
}

class _ProgramsListPageState extends State<ProgramsListPage> {
  final controller = Get.find<ProgramsController>();
  final search = Get.find<SearchController>();
  final scrollController = ScrollController();
  final TextEditingController searchFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
    searchFieldController.text = search.query.value;
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    searchFieldController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 120) {
      controller.loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('programs'.tr),
      ),
      body: AppBackground(
        child: RefreshIndicator(
          onRefresh: controller.loadInitial,
          child: CustomScrollView(
            controller: scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: searchFieldController,
                    decoration: InputDecoration(
                      hintText: 'search_hint'.tr,
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: Obx(() => search.query.value.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                search.clear();
                                searchFieldController.clear();
                              },
                            )
                          : null),
                      filled: true,
                      fillColor: theme.cardColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) => search.updateQuery(value),
                  ),
                ),
              ),
              Obx(
                () => SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => ProgramTile(program: controller.programs[index]),
                      childCount: controller.programs.length,
                    ),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.74,
                    ),
                  ),
                ),
              ),
              Obx(
                () => SliverToBoxAdapter(
                  child: controller.hasMore.value
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Center(
                            child: ElevatedButton(
                              onPressed: controller.loadMore,
                              child: Text('load_more'.tr),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNav(active: 'programs'),
    );
  }
}
