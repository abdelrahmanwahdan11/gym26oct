import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/trainers_controller.dart';
import '../../../data/models/trainer.dart';
import '../../../routes/app_routes.dart';
import '../../widgets/app_background.dart';
import '../../widgets/glass_container.dart';

class TrainerDetailsPage extends StatelessWidget {
  const TrainerDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TrainersController>();
    Trainer? trainer;
    final arg = Get.arguments;
    if (arg is Trainer) {
      trainer = arg;
    } else if (arg is String) {
      trainer = controller.findById(arg);
    }
    trainer ??= controller.trainers.first;
    return Scaffold(
      appBar: AppBar(
        title: Text(trainer.name),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AppBackground(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            CircleAvatar(radius: 48, backgroundImage: NetworkImage(trainer.avatar)),
            const SizedBox(height: 16),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, color: Colors.amber),
                  const SizedBox(width: 6),
                  Text(trainer.rating.toStringAsFixed(1)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(trainer.bio),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: trainer.specialties.map((e) => Chip(label: Text(e))).toList(),
            ),
            const SizedBox(height: 16),
            Text('gyms'.tr, style: Theme.of(context).textTheme.titleMedium),
            for (final gym in trainer.gyms)
              GlassContainer(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(gym.name, style: Theme.of(context).textTheme.titleSmall),
                    Text('${gym.city} • ${gym.address}'),
                    Text('discount'.trParams({'percent': gym.discountPercent.toString()})),
                  ],
                ),
              ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.snackbar('contact'.tr, trainer.contacts.phone),
                    child: Text('contact'.tr),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.booking, arguments: trainer);
                    },
                    child: Text('book'.tr),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
