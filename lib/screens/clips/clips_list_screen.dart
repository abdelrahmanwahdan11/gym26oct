import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/clips_controller.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/clip_tile.dart';

class ClipsListScreen extends StatefulWidget {
  const ClipsListScreen({super.key});

  @override
  State<ClipsListScreen> createState() => _ClipsListScreenState();
}

class _ClipsListScreenState extends State<ClipsListScreen> {
  final ScrollController _scrollController = ScrollController();
  late final ClipsController clipsController;

  @override
  void initState() {
    super.initState();
    clipsController = Get.find<ClipsController>();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels > _scrollController.position.maxScrollExtent - 200) {
      clipsController.loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClipsController>(
      builder: (clips) {
        return AppScaffold(
          activeTab: 'clips',
          onTabSelected: (tab) => _handleTab(context, tab),
          body: RefreshIndicator(
            onRefresh: clips.refresh,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: clips.clips.length + 1 + (clips.isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      decoration: const InputDecoration(hintText: 'ابحث عن مقطع…'),
                      onChanged: clips.search,
                    ),
                  );
                }
                final clipIndex = index - 1;
                if (clipIndex >= clips.clips.length) {
                  return const Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final clip = clips.clips[clipIndex];
                return ClipTile(
                  clip: clip,
                  onTap: () => ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Playing ${clip.title} (Mock)'))),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _handleTab(BuildContext context, String tab) {
    if (tab == 'clips') return;
    Get.offNamed(_tabToRoute(tab));
  }

  String _tabToRoute(String tab) {
    switch (tab) {
      case 'generator':
        return 'home.generator';
      case 'programs':
        return 'programs.list';
      case 'store':
        return 'store.home';
      case 'trainers':
        return 'trainers.list';
      case 'profile':
        return 'profile.home';
      default:
        return 'clips.list';
    }
  }
}
