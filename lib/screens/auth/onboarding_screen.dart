import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../controllers/app_scope.dart';
import '../../controllers/settings_controller.dart';
import '../shared/gradient_background.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  late final List<_OnboardingSlide> _slides;
  Timer? _timer;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _slides = const [
      _OnboardingSlide(
        image: 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b',
        title: 'صمم برنامجك الذكي، وابدأ اللياقة بثقة',
        bullets: ['تحكم كامل في أهدافك', 'جدولة تلقائية لكل أسبوع', 'اقتراحات تسخين وتبريد ذكية'],
      ),
      _OnboardingSlide(
        image: 'https://images.unsplash.com/photo-1517963628607-235ccdd5476b',
        title: 'مدربون وأندية بشراكات قوية',
        bullets: ['حجوزات فورية بخصومات حصرية', 'إدارة FlexPass متعددة الأندية', 'تجارب حية مع بث مباشر'],
      ),
      _OnboardingSlide(
        image: 'https://images.unsplash.com/photo-1546484959-f9a53db89c2d',
        title: 'متجر متكامل ومركز إنجازات',
        bullets: ['عربة ذكية مع كوبونات شخصية', 'لوحة تقدم زجاجية ببيانات غنية', 'إشعارات موسمية تبقيك متحمساً'],
      ),
    ];
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      final next = (_index + 1) % _slides.length;
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = AppScope.of(context).settings;
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: _controller,
                      onPageChanged: (value) => setState(() => _index = value),
                      itemCount: _slides.length,
                      itemBuilder: (context, index) {
                        final slide = _slides[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                          child: _OnboardingCard(slide: slide),
                        );
                      },
                    ),
                    Positioned(
                      bottom: 24,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _slides.length,
                          (i) => AnimatedContainer(
                            duration: const Duration(milliseconds: 350),
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            width: i == _index ? 32 : 10,
                            height: 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: i == _index
                                  ? LinearGradient(colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary])
                                  : null,
                              color: i == _index
                                  ? null
                                  : Theme.of(context).colorScheme.primary.withOpacity(0.25),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await settings.markOnboardingComplete();
                        if (!mounted) return;
                        Navigator.of(context).pushReplacementNamed('auth.login');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(58),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                      ),
                      child: const Text('ابدأ الآن'),
                    ).animate().fadeIn(duration: 280.ms).moveY(begin: 16, end: 0),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () async {
                        await settings.markOnboardingComplete();
                        if (!mounted) return;
                        Navigator.of(context).pushReplacementNamed('auth.login');
                      },
                      child: Text(
                        'تخطى واستكشف التطبيق',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingCard extends StatelessWidget {
  const _OnboardingCard({required this.slide});

  final _OnboardingSlide slide;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(slide.image, fit: BoxFit.cover),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black.withOpacity(0.15), Colors.black.withOpacity(0.65)],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.white.withOpacity(0.18),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.auto_awesome, color: theme.colorScheme.secondary),
                      const SizedBox(width: 8),
                      Text('Athletica X', style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white)),
                    ],
                  ),
                ).animate().shimmer(duration: 1600.ms),
                const Spacer(),
                Text(
                  slide.title,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ).animate().fadeIn(duration: 400.ms).moveY(begin: 20, end: 0),
                const SizedBox(height: 16),
                ...slide.bullets.map(
                  (bullet) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.check_circle, color: Color(0xFF22C55E)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            bullet,
                            style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white70),
                          ),
                        ),
                      ],
                    ).animate().fadeIn(duration: 320.ms).moveY(begin: 12, end: 0),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _OnboardingSlide {
  const _OnboardingSlide({required this.image, required this.title, required this.bullets});

  final String image;
  final String title;
  final List<String> bullets;
}
