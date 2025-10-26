import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/app_scope.dart';

class TrainerRegisterScreen extends StatefulWidget {
  const TrainerRegisterScreen({super.key});

  @override
  State<TrainerRegisterScreen> createState() => _TrainerRegisterScreenState();
}

class _TrainerRegisterScreenState extends State<TrainerRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formValues = {};

  @override
  Widget build(BuildContext context) {
    final trainers = AppScope.of(context).trainers;
    return Scaffold(
      appBar: AppBar(title: const Text('سجّل كمدرب')), 
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildField('name', 'الاسم'),
              _buildField('bio', 'نبذة قصيرة'),
              _buildField('specialties', 'التخصصات (مفصولة بفواصل)'),
              _buildField('price', 'السعر لكل حصة', keyboard: TextInputType.number),
              _buildField('contacts', 'الهاتف/واتساب/بريد'),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (!(_formKey.currentState?.validate() ?? false)) return;
                  _formKey.currentState?.save();
                  await trainers.createTrainer(_formValues);
                  if (!mounted) return;
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('تم إنشاء ملف المدرب (محلي)')));
                  Get.back();
                },
                style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(52), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
                child: const Text('حفظ الملف وإتاحته في التطبيق'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String key, String label, {TextInputType keyboard = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        keyboardType: keyboard,
        decoration: InputDecoration(labelText: label),
        validator: (value) => value == null || value.isEmpty ? 'Required' : null,
        onSaved: (value) => _formValues[key] = value,
      ),
    );
  }
}
