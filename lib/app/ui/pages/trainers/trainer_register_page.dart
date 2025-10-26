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
  Widget build(BuildContext context) {
    final controller = Get.find<TrainersController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register as Trainer'),
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
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: bioController,
                  decoration: const InputDecoration(labelText: 'Bio'),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: specialtiesController,
                  decoration: const InputDecoration(labelText: 'Specialties (comma separated)'),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Price per session'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: contactsController,
                  decoration: const InputDecoration(labelText: 'Contact info'),
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
                        Get.snackbar('Trainer', 'Profile created locally');
                        Get.back();
                      }
                    },
                    child: const Text('Save'),
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
