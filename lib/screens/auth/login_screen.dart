import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../controllers/app_scope.dart';
import '../../controllers/auth_controller.dart';
import '../shared/gradient_background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;
  bool _submitting = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit(AuthController auth) async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    setState(() => _submitting = true);
    await auth.loginMock(_emailController.text.trim());
    if (!mounted) return;
    Get.offAllNamed('/home/generator');
    if (!mounted) return;
    setState(() => _submitting = false);
  }

  Future<void> _loginAsGuest(AuthController auth) async {
    setState(() => _submitting = true);
    await auth.loginAsGuest();
    if (!mounted) return;
    Get.offAllNamed('/home/generator');
    if (!mounted) return;
    setState(() => _submitting = false);
  }

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final auth = scope.auth;
    final settings = scope.settings;
    final theme = Theme.of(context);

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 520),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(28, 32, 28, 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        color: theme.colorScheme.surface.withOpacity(theme.brightness == Brightness.dark ? 0.85 : 0.9),
                        border: Border.all(color: theme.colorScheme.primary.withOpacity(0.08)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            blurRadius: 38,
                            offset: const Offset(0, 18),
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('أهلاً بعودتك', style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700)),
                                    const SizedBox(height: 6),
                                    Text(
                                      'تابع تقدمك مع Athletica X',
                                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.68)),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  tooltip: 'تبديل النمط',
                                  onPressed: settings.toggleTheme,
                                  icon: Icon(settings.themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode),
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              autofillHints: const [AutofillHints.email],
                              decoration: InputDecoration(
                                labelText: 'Email / البريد الإلكتروني',
                                prefixIcon: const Icon(Icons.alternate_email_rounded),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'الرجاء إدخال البريد الإلكتروني';
                                }
                                final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                                if (!emailRegex.hasMatch(value.trim())) {
                                  return 'صيغة البريد غير صحيحة';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 18),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscure,
                              autofillHints: const [AutofillHints.password],
                              decoration: InputDecoration(
                                labelText: 'Password / كلمة المرور',
                                prefixIcon: const Icon(Icons.lock_rounded),
                                suffixIcon: IconButton(
                                  onPressed: () => setState(() => _obscure = !_obscure),
                                  icon: Icon(_obscure ? Icons.visibility_off_rounded : Icons.visibility_rounded),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'أدخل كلمة المرور';
                                }
                                if (value.length < 6) {
                                  return 'يجب أن تكون 6 أحرف على الأقل';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 14),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('ميزة استعادة كلمة المرور قيد التطوير')),
                                  );
                                },
                                child: const Text('نسيت كلمة المرور؟'),
                              ),
                            ),
                            const SizedBox(height: 12),
                            FilledButton(
                              onPressed: _submitting ? null : () => _submit(auth),
                              style: FilledButton.styleFrom(
                                minimumSize: const Size.fromHeight(54),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                              ),
                              child: _submitting
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(strokeWidth: 2.6),
                                    )
                                  : const Text('تسجيل الدخول / Login'),
                            ),
                            const SizedBox(height: 14),
                            OutlinedButton(
                              onPressed: _submitting ? null : () => _loginAsGuest(auth),
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size.fromHeight(52),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                              ),
                              child: const Text('دخول كضيف / Continue as Guest'),
                            ),
                            const SizedBox(height: 18),
                            Divider(color: theme.colorScheme.primary.withOpacity(0.18)),
                            const SizedBox(height: 18),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('ليس لديك حساب؟', style: theme.textTheme.bodyMedium),
                                TextButton(
                                  onPressed: _submitting ? null : () => Get.toNamed('/auth/register'),
                                  child: const Text('إنشاء حساب جديد'),
                                ),
                              ],
                            ),
                          ]
                              .animate(interval: 60.ms)
                              .fadeIn(duration: 280.ms, curve: Curves.easeOut)
                              .moveY(begin: 12, end: 0),
                        ),
                      ),
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
