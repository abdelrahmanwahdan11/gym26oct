import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/trainers_controller.dart';

class BookingSheet extends StatefulWidget {
  const BookingSheet({super.key, required this.trainerId});

  final String trainerId;

  @override
  State<BookingSheet> createState() => _BookingSheetState();
}

class _BookingSheetState extends State<BookingSheet> {
  final _formKey = GlobalKey<FormState>();
  String? _gym;
  DateTime? _date;
  String? _note;
  String? _coupon;

  @override
  Widget build(BuildContext context) {
    final trainers = Get.find<TrainersController>();
    final matching = trainers.trainers.where((element) => element.id == widget.trainerId);
    final trainer = matching.isNotEmpty
        ? matching.first
        : (trainers.trainers.isNotEmpty ? trainers.trainers.first : null);
    if (trainer == null) {
      return const Scaffold(body: Center(child: Text('Trainer not available')));
    }
    return Scaffold(
      appBar: AppBar(title: Text('تأكيد الحجز مع ${trainer.name}')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                value: _gym,
                hint: const Text('اختر النادي'),
                items: trainer.gyms.map((gym) => DropdownMenuItem(value: gym.id, child: Text(gym.name))).toList(),
                onChanged: (value) => setState(() => _gym = value),
                validator: (value) => value == null ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text(_date?.toString() ?? 'اختر الوقت'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final now = DateTime.now();
                  final picked = await showDatePicker(context: context, initialDate: now, firstDate: now, lastDate: now.add(const Duration(days: 365)));
                  if (picked != null) {
                    setState(() => _date = picked);
                  }
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'ملاحظات'),
                onChanged: (value) => _note = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'كوبون خصم (اختياري)'),
                onChanged: (value) => _coupon = value,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (!(_formKey.currentState?.validate() ?? false)) return;
                  await trainers.addBooking({
                    'trainerId': trainer.id,
                    'gymId': _gym,
                    'slot': _date?.toIso8601String(),
                    'status': 'pending',
                    'note': _note,
                    'coupon': _coupon,
                  });
                  if (!mounted) return;
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('تم الحجز (Mock)')));
                  Get.back();
                },
                style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(52), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
                child: const Text('تأكيد الحجز'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
