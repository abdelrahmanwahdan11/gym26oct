import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../controllers/app_scope.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/settings_controller.dart';
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = AppScope.of(context).auth;
    final settings = AppScope.of(context).settings;
    final theme = Theme.of(context);
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('تسجيل الدخول', style: theme.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold))
                            .animate()
                            .fadeIn(duration: 280.ms)
                            .moveY(begin: 12, end: 0),
                        const SizedBox(height: 32),
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
                            if (value == null || value.isEmpty) return 'Required';
                            if (value.length < 6) return 'Min 6 chars';
                            return null;
                          },
                        ).animate().fadeIn(duration: 280.ms).moveY(begin: 12, end: 0),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('ميزة الاستعادة قيد التطوير')),
                              );
                            },
                            child: const Text('نسيت كلمة المرور؟'),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            if (_formKey.currentState?.validate() ?? false) {
                              await auth.loginMock(_emailController.text.trim());
                              if (!mounted) return;
                              Navigator.of(context).pushReplacementNamed('home.generator');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(52),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          child: const Text('Login / تسجيل الدخول'),
                        ).animate().fadeIn(duration: 280.ms).moveY(begin: 12, end: 0),
                        const SizedBox(height: 16),
                        OutlinedButton(
                          onPressed: () => Navigator.of(context).pushReplacementNamed('home.generator'),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size.fromHeight(52),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          child: const Text('Continue as Guest / دخول كضيف'),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pushNamed('auth.register'),
                              child: const Text('Create account / إنشاء حساب'),
                            ),
                            IconButton(
                              onPressed: settings.toggleTheme,
                              icon: const Icon(Icons.brightness_6),
                            ),
                          ],
                        )
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
