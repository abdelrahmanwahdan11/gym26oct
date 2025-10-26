import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/app_scope.dart';
import '../../controllers/clips_controller.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/clip_tile.dart';
import '../../widgets/feature_catalog_section.dart';

class ClipsListScreen extends StatefulWidget {
  const ClipsListScreen({super.key});

  @override
  State<ClipsListScreen> createState() => _ClipsListScreenState();
}

class _ClipsListScreenState extends State<ClipsListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final clips = AppScope.of(context).clips;
    if (_scrollController.position.pixels > _scrollController.position.maxScrollExtent - 200) {
      clips.loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clips = AppScope.of(context).clips;
    return AnimatedBuilder(
      animation: clips,
      builder: (context, _) {
        return AppScaffold(
          activeTab: 'clips',
          onTabSelected: (tab) => _handleTab(context, tab),
          body: RefreshIndicator(
            onRefresh: clips.refresh,
            child: ListView(
              controller: _scrollController,
              padding: const EdgeInsets.only(bottom: 120),
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    decoration: const InputDecoration(hintText: 'ابحث عن مقطع…'),
                    onChanged: clips.search,
                  ),
                ),
                ...clips.clips
                    .map(
                      (clip) => ClipTile(
                        clip: clip,
                        onTap: () => ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('Playing ${clip.title} (Mock)'))),
                      ),
                    )
                    .toList(),
                if (clips.isLoading)
                  const Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                FeatureCatalogSection(pageKey: 'clips', title: 'ابتكارات مكتبة المقاطع'),
              ],
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
        return '/home/generator';
      case 'programs':
        return '/programs';
      case 'store':
        return '/store';
      case 'trainers':
        return '/trainers';
      case 'profile':
        return '/profile';
      default:
        return '/clips';
    }
  }
}
