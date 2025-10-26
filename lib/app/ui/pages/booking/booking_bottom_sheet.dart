import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/booking_controller.dart';
import '../../../data/models/trainer.dart';

class BookingBottomSheet extends StatefulWidget {
  const BookingBottomSheet({super.key});

  @override
  State<BookingBottomSheet> createState() => _BookingBottomSheetState();
}

class _BookingBottomSheetState extends State<BookingBottomSheet> {
  String? selectedGym;
  String? selectedSlot;
  final noteController = TextEditingController();
  final couponController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final trainer = Get.arguments as Trainer?;
    final booking = Get.find<BookingController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: selectedGym,
              items: trainer?.gyms
                  .map((gym) => DropdownMenuItem(value: gym.id, child: Text(gym.name)))
                  .toList(),
              decoration: const InputDecoration(labelText: 'Select gym'),
              onChanged: (value) => setState(() => selectedGym = value),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: selectedSlot,
              items: trainer?.slots
                  .map((slot) => DropdownMenuItem(value: slot, child: Text(slot)))
                  .toList(),
              decoration: const InputDecoration(labelText: 'Select slot'),
              onChanged: (value) => setState(() => selectedSlot = value),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: noteController,
              decoration: const InputDecoration(labelText: 'Notes'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: couponController,
              decoration: const InputDecoration(labelText: 'Coupon (optional)'),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (trainer == null || selectedGym == null || selectedSlot == null) return;
                  booking.addBooking({
                    'trainerId': trainer.id,
                    'gymId': selectedGym!,
                    'slot': selectedSlot!,
                    'status': 'confirmed',
                  });
                  Get.back();
                  Get.snackbar('Booking', 'تم الحجز (Mock)');
                },
                child: const Text('Confirm'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
