import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../../data/repositories/prefs_repository.dart';
import '../../../routes/app_routes.dart';
import '../../widgets/app_background.dart';
import '../../widgets/glass_container.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ).animate().fadeIn(260.ms).moveY(begin: 20, end: 0),
                  ),
                ),
                const SizedBox(height: 24),
                Text('صمم برنامجك الذكي، وابدأ اللياقة بثقة',
                    style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 16),
                GlassContainer(
                  padding: const EdgeInsets.all(20),
                  borderRadius: BorderRadius.circular(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      _Bullet(text: 'مقاطع تعليمية عالية الجودة'),
                      _Bullet(text: 'مدربون وأندية بخصومات'),
                      _Bullet(text: 'متجر مكملات ومعدات'),
                    ],
                  ),
                ).animate().fadeIn(260.ms).moveY(begin: 20, end: 0),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                      backgroundColor: const Color(0xFF6C7CFF),
                    ),
                    onPressed: () async {
                      await Get.find<PrefsRepository>().setOnboardingDone(true);
                      Get.offAllNamed(AppRoutes.login);
                    },
                    child: Text('start_now'.tr, style: theme.textTheme.titleMedium?.copyWith(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF6C7CFF)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style:
                  theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.8)),
            ),
          ),
        ],
      ),
    );
  }
}
