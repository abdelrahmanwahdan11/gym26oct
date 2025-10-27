import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/trainers_controller.dart';
import '../../../routes/app_routes.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/trainer_card.dart';

class TrainersListPage extends StatefulWidget {
  const TrainersListPage({super.key});

  @override
  State<TrainersListPage> createState() => _TrainersListPageState();
}

class _TrainersListPageState extends State<TrainersListPage> {
  final controller = Get.find<TrainersController>();
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
        title: Text('trainers'.tr),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                    itemBuilder: (context, index) => TrainerCard(trainer: controller.trainers[index]),
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemCount: controller.trainers.length,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Get.toNamed(AppRoutes.trainerRegister),
                  child: Text('become_trainer'.tr),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(active: 'trainers'),
    );
  }
}
