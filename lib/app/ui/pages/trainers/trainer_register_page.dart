import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/trainers_controller.dart';
import '../../widgets/app_background.dart';

class TrainerRegisterPage extends StatefulWidget {
  const TrainerRegisterPage({super.key});

  @override
  State<TrainerRegisterPage> createState() => _TrainerRegisterPageState();
}

class _TrainerRegisterPageState extends State<TrainerRegisterPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final bioController = TextEditingController();
  final specialtiesController = TextEditingController();
  final priceController = TextEditingController();
  final contactsController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    bioController.dispose();
    specialtiesController.dispose();
    priceController.dispose();
    contactsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TrainersController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('become_trainer'.tr),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AppBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'name'.tr),
                  validator: (value) => value == null || value.isEmpty ? 'required'.tr : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: bioController,
                  decoration: InputDecoration(labelText: 'bio'.tr),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: specialtiesController,
                  decoration: InputDecoration(labelText: 'specialties'.tr),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: priceController,
                  decoration: InputDecoration(labelText: 'price_per_session'.tr),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: contactsController,
                  decoration: InputDecoration(labelText: 'contact'.tr),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState?.validate() ?? false) {
                        await controller.createTrainer({
                          'name': nameController.text,
                          'bio': bioController.text,
                          'specialties': specialtiesController.text,
                          'price': double.tryParse(priceController.text) ?? 0,
                          'contacts': {
                            'phone': contactsController.text,
                            'whatsapp': contactsController.text,
                            'email': 'trainer@example.com',
                          }
                        });
                        Get.snackbar('trainers'.tr, 'trainer_created'.tr);
                        Get.back();
                      }
                    },
                    child: Text('save'.tr),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
