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
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
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
                      if (!value.contains('@')) return 'Invalid email';
                      return null;
                    },
                  ).animate().fadeIn(duration: 280.ms).moveY(begin: 12, end: 0),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Password / كلمة المرور'),
                    validator: (value) {
                      if (value == null || value.length < 6) return 'Min 6 chars';
                      return null;
                    },
                  ).animate().fadeIn(duration: 280.ms).moveY(begin: 12, end: 0),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        await auth.loginMock(_emailController.text);
                        // ignore: use_build_context_synchronously
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
                    style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(52), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                    child: const Text('Continue as Guest / دخول كضيف'),
                  ),
                  const SizedBox(height: 24),
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
        ),
      ),
    );
  }
}
