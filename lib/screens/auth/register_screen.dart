import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../shared/gradient_background.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: const Text('Create Account / إنشاء حساب')),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(decoration: const InputDecoration(labelText: 'Name / الاسم')).animate().fadeIn(duration: 280.ms).moveY(begin: 12, end: 0),
                const SizedBox(height: 16),
                TextFormField(decoration: const InputDecoration(labelText: 'Email / البريد الإلكتروني')).animate().fadeIn(duration: 280.ms).moveY(begin: 12, end: 0),
                const SizedBox(height: 16),
                TextFormField(obscureText: true, decoration: const InputDecoration(labelText: 'Password / كلمة المرور')).animate().fadeIn(duration: 280.ms).moveY(begin: 12, end: 0),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(52), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                  child: const Text('Register (Mock)'),
                ).animate().fadeIn(duration: 280.ms).moveY(begin: 12, end: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
