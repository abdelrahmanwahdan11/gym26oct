import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../routes/app_routes.dart';
import '../../widgets/app_background.dart';
import '../../widgets/glass_container.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  bool obscure = true;
  bool obscureConfirm = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: GlassContainer(
              padding: const EdgeInsets.all(24),
              borderRadius: BorderRadius.circular(28),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('register'.tr,
                        style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: 'name'.tr),
                      validator: (value) => value == null || value.isEmpty ? 'required'.tr : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(labelText: 'email'.tr),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'required'.tr;
                        if (!value.contains('@')) return 'invalid_email'.tr;
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: passwordController,
                      obscureText: obscure,
                      decoration: InputDecoration(
                        labelText: 'password'.tr,
                        suffixIcon: IconButton(
                          icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
                          onPressed: () => setState(() => obscure = !obscure),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return 'min_chars'.trParams({'count': '6'});
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: confirmController,
                      obscureText: obscureConfirm,
                      decoration: InputDecoration(
                        labelText: 'confirm_password'.tr,
                        suffixIcon: IconButton(
                          icon: Icon(obscureConfirm ? Icons.visibility_off : Icons.visibility),
                          onPressed: () => setState(() => obscureConfirm = !obscureConfirm),
                        ),
                      ),
                      validator: (value) {
                        if (value != passwordController.text) {
                          return 'passwords_no_match'.tr;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                          backgroundColor: const Color(0xFF6C7CFF),
                        ),
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {
                            Get.find<AuthController>()
                                .register({
                                  'name': nameController.text,
                                  'email': emailController.text,
                                })
                                .then((_) => Get.offAllNamed(AppRoutes.generator));
                          }
                        },
                        child: Text('register'.tr,
                            style: theme.textTheme.titleMedium?.copyWith(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
