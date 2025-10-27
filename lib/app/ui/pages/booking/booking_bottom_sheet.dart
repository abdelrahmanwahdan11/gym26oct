import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/booking_controller.dart';
import '../../../controllers/notifications_controller.dart';
import '../../../data/models/trainer.dart';
import '../../widgets/app_background.dart';

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
  void dispose() {
    noteController.dispose();
    couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final trainer = Get.arguments as Trainer?;
    final booking = Get.find<BookingController>();
    final notifications = Get.find<NotificationsController>();
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('book'.tr),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AppBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              DropdownButtonFormField<String>(
                value: selectedGym,
                items: trainer?.gyms
                    .map((gym) => DropdownMenuItem(value: gym.id, child: Text(gym.name)))
                    .toList(),
                decoration: InputDecoration(labelText: 'select_gym'.tr),
                onChanged: (value) => setState(() => selectedGym = value),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedSlot,
                items: trainer?.slots
                    .map((slot) => DropdownMenuItem(value: slot, child: Text(slot)))
                    .toList(),
                decoration: InputDecoration(labelText: 'select_slot'.tr),
                onChanged: (value) => setState(() => selectedSlot = value),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: noteController,
                decoration: InputDecoration(labelText: 'notes'.tr),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: couponController,
                decoration: InputDecoration(labelText: 'coupon_optional'.tr),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (trainer == null || selectedGym == null || selectedSlot == null) return;
                    booking.addBooking({
                      'trainerId': trainer.id,
                      'gymId': selectedGym!,
                      'slot': selectedSlot!,
                      'status': 'confirmed',
                    });
                    var gymName = '';
                    for (final gym in trainer.gyms) {
                      if (gym.id == selectedGym) {
                        gymName = gym.name;
                        break;
                      }
                    }
                    gymName = gymName.isEmpty && trainer.gyms.isNotEmpty
                        ? trainer.gyms.first.name
                        : gymName;
                    await notifications.pushNotification(
                      'booking_notification_title'.trParams(
                        {'trainer': trainer.name},
                      ),
                      'booking_notification_message'.trParams({
                        'trainer': trainer.name,
                        'gym': gymName,
                        'slot': selectedSlot!,
                      }),
                    );
                    Get.back();
                    Get.snackbar('book'.tr, 'booking_mock'.tr);
                  },
                  child: Text('confirm_booking'.tr),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
