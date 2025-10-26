import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../shared/gradient_background.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscure = true;
  bool _confirmObscure = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: const Text('Create Account / إنشاء حساب')),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight - 48),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(labelText: 'Name / الاسم'),
                          validator: (value) => value == null || value.trim().length < 3 ? 'Min 3 chars' : null,
                        ).animate().fadeIn(duration: 280.ms).moveY(begin: 12, end: 0),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(labelText: 'Email / البريد الإلكتروني'),
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'Required';
                            final email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                            if (!email.hasMatch(value)) return 'Invalid email';
                            return null;
                          },
                        ).animate().fadeIn(duration: 280.ms).moveY(begin: 12, end: 0),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscure,
                          decoration: InputDecoration(
                            labelText: 'Password / كلمة المرور',
                            suffixIcon: IconButton(
                              icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                              onPressed: () => setState(() => _obscure = !_obscure),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.length < 6) return 'Min 6 chars';
                            return null;
                          },
                        ).animate().fadeIn(duration: 280.ms).moveY(begin: 12, end: 0),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _confirmController,
                          obscureText: _confirmObscure,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password / تأكيد كلمة المرور',
                            suffixIcon: IconButton(
                              icon: Icon(_confirmObscure ? Icons.visibility_off : Icons.visibility),
                              onPressed: () => setState(() => _confirmObscure = !_confirmObscure),
                            ),
                          ),
                          validator: (value) {
                            if (value != _passwordController.text) return 'Passwords must match';
                            return null;
                          },
                        ).animate().fadeIn(duration: 280.ms).moveY(begin: 12, end: 0),
                        const SizedBox(height: 24),
                        CheckboxListTile(
                          value: true,
                          onChanged: (_) {},
                          controlAffinity: ListTileControlAffinity.leading,
                          title: const Text('أوافق على الشروط وسياسة الاستخدام (Mock)'),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            if (_formKey.currentState?.validate() ?? false) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('تم إنشاء الحساب محلياً (Mock)')),
                              );
                              Get.back();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(52),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          child: const Text('Register (Mock)'),
                        ).animate().fadeIn(duration: 280.ms).moveY(begin: 12, end: 0),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
