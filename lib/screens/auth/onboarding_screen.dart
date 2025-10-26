import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../controllers/app_scope.dart';
import '../../controllers/settings_controller.dart';
import '../shared/gradient_background.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = AppScope.of(context).settings;
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(28),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b',
                          height: 260,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ).animate().fadeIn(duration: 280.ms).moveY(begin: 16, end: 0),
                      const SizedBox(height: 32),
                      Text('صمم برنامجك الذكي، وابدأ اللياقة بثقة',
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold))
                          .animate()
                          .fadeIn(duration: 280.ms)
                          .moveY(begin: 12, end: 0),
                      const SizedBox(height: 24),
                      _GlassBullet(text: 'مقاطع تعليمية عالية الجودة'),
                      _GlassBullet(text: 'مدربون وأندية بخصومات'),
                      _GlassBullet(text: 'متجر مكملات ومعدات'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await settings.markOnboardingComplete();
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushReplacementNamed('auth.login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(56),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  ),
                  child: const Text('ابدأ الآن'),
                ).animate().fadeIn(duration: 280.ms).moveY(begin: 16, end: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GlassBullet extends StatelessWidget {
  const _GlassBullet({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Theme.of(context).cardColor.withOpacity(0.68),
        border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF22C55E)),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: Theme.of(context).textTheme.bodyLarge)),
        ],
      ),
    ).animate().fadeIn(duration: 280.ms).moveY(begin: 12, end: 0);
  }
}
