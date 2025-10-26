import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controllers/app_scope.dart';
import '../../data/models/trainer.dart';

class TrainerDetailScreen extends StatefulWidget {
  const TrainerDetailScreen({super.key, required this.trainerId});

  final String trainerId;

  @override
  State<TrainerDetailScreen> createState() => _TrainerDetailScreenState();
}

class _TrainerDetailScreenState extends State<TrainerDetailScreen> {
  Future<Trainer?>? _future;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _future ??= AppScope.of(context).trainers.resolveTrainer(widget.trainerId);
  }

  @override
  Widget build(BuildContext context) {
    final trainers = AppScope.of(context).trainers;
    return FutureBuilder<Trainer?>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        final trainer = snapshot.data;
        if (trainer == null) {
          return const Scaffold(body: Center(child: Text('Trainer not found')));
        }
        return Scaffold(
          appBar: AppBar(title: Text(trainer.name)),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Row(
                children: [
                  CircleAvatar(radius: 40, backgroundImage: NetworkImage(trainer.avatar)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          trainer.name,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text('⭐ ${trainer.rating.toStringAsFixed(1)}'),
                        Text('${trainer.pricePerSession.toStringAsFixed(0)} USD / session'),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: trainer.specialties.map((s) => Chip(label: Text(s))).toList(),
              ),
              const SizedBox(height: 24),
              Text('About', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Text(trainer.bio),
              const SizedBox(height: 24),
              Text('Gyms', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              ...trainer.gyms.map((gym) => Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(gym.name),
                      subtitle: Text('${gym.address} • ${gym.city}\nخصم ${gym.discountPercent}%'),
                      trailing: IconButton(
                        icon: const Icon(Icons.copy),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: gym.phone));
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text('Copied ${gym.phone}')));
                        },
                      ),
                    ),
                  )),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        final phone = trainer.contacts['phone'] ?? '';
                        Clipboard.setData(ClipboardData(text: phone));
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('Copied contact $phone')));
                      },
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(52),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      ),
                      child: const Text('تواصل'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Get.toNamed('booking.sheet', arguments: trainer.id),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(52),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      ),
                      child: const Text('احجز'),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
