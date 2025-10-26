import 'package:flutter/material.dart';

import '../../controllers/app_scope.dart';
import '../../controllers/trainers_controller.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/trainer_card.dart';

class TrainersListScreen extends StatefulWidget {
  const TrainersListScreen({super.key});

  @override
  State<TrainersListScreen> createState() => _TrainersListScreenState();
}

class _TrainersListScreenState extends State<TrainersListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final trainers = AppScope.of(context).trainers;
    if (_scrollController.position.pixels > _scrollController.position.maxScrollExtent - 200) {
      trainers.loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final trainers = AppScope.of(context).trainers;
    return AnimatedBuilder(
      animation: trainers,
      builder: (context, _) {
        return AppScaffold(
          activeTab: 'trainers',
          onTabSelected: (tab) => _handleTab(context, tab),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  decoration: const InputDecoration(hintText: 'ابحث عن مدرب/نادي…'),
                  onChanged: trainers.search,
                ),
              ),
              ToggleButtons(
                isSelected: ['Trainers', 'Gyms', 'Live Classes'].map((e) => e == trainers.segment).toList(),
                onPressed: (index) => trainers.setSegment(['Trainers', 'Gyms', 'Live Classes'][index]),
                borderRadius: BorderRadius.circular(24),
                children: const [
                  Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('Trainers')),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('Gyms')),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('Live Classes')),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: trainers.refresh,
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: trainers.trainers.length + (trainers.isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index >= trainers.trainers.length) {
                        return const Padding(
                          padding: EdgeInsets.all(24),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      final trainer = trainers.trainers[index];
                      return TrainerCard(
                        trainer: trainer,
                        onTap: () => Navigator.of(context).pushNamed('trainer.details', arguments: trainer.id),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pushNamed('trainer.register'),
                  style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(52), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
                  child: const Text('سجّل كمدرب / Register as Trainer'),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void _handleTab(BuildContext context, String tab) {
    if (tab == 'trainers') return;
    Navigator.of(context).pushReplacementNamed(_tabToRoute(tab));
  }

  String _tabToRoute(String tab) {
    switch (tab) {
      case 'generator':
        return 'home.generator';
      case 'programs':
        return 'programs.list';
      case 'clips':
        return 'clips.list';
      case 'store':
        return 'store.home';
      case 'profile':
        return 'profile.home';
      default:
        return 'trainers.list';
    }
  }
}
