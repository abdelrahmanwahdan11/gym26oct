import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/clips_controller.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/clip_tile.dart';

class ClipsListPage extends StatefulWidget {
  const ClipsListPage({super.key});

  @override
  State<ClipsListPage> createState() => _ClipsListPageState();
}

class _ClipsListPageState extends State<ClipsListPage> {
  final controller = Get.find<ClipsController>();
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
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
        title: Text('clips'.tr),
      ),
      body: AppBackground(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'search_hint'.tr,
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: theme.cardColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: controller.search,
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: controller.loadInitial,
                child: Obx(
                  () => ListView.separated(
                    controller: scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 120),
                    itemBuilder: (context, index) => ClipTile(clip: controller.clips[index]),
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemCount: controller.clips.length,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(active: 'clips'),
    );
  }
}
