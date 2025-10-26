import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../controllers/app_scope.dart';
import '../../controllers/challenges_controller.dart';
import '../../data/models/challenge.dart';

class ChallengesScreen extends StatelessWidget {
  const ChallengesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AppScope.of(context).challenges;
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('التحديات الجماعية'),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: controller.bootstrap,
              )
            ],
          ),
          body: controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : _ChallengeBody(controller: controller),
        );
      },
    );
  }
}

class _ChallengeBody extends StatelessWidget {
  const _ChallengeBody({required this.controller});

  final ChallengesController controller;

  @override
  Widget build(BuildContext context) {
    final grouped = controller.groupedByCategory;
    return RefreshIndicator(
      onRefresh: controller.bootstrap,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.85),
                  Theme.of(context).colorScheme.secondary.withOpacity(0.85),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: const [
                BoxShadow(color: Color.fromARGB(72, 16, 24, 64), blurRadius: 28, offset: Offset(0, 18)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('50+ مغامرة جديدة',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold))
                    .animate()
                    .shimmer(duration: 1600.ms),
                const SizedBox(height: 8),
                Text(
                  'أكمل التحديات وشارك قصتك مع المجتمع. عند الإنهاء ستحصل على زر مشاركة فوري.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white.withOpacity(0.9)),
                ),
                const SizedBox(height: 12),
                FilledButton.tonal(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                  ),
                  onPressed: () => Navigator.of(context).maybePop(),
                  child: const Text('العودة للوحة الرئيسية'),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 320.ms).moveY(begin: 18, end: 0),
          const SizedBox(height: 24),
          ...grouped.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: _ChallengeCategory(
                title: entry.key,
                challenges: entry.value,
                controller: controller,
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _ChallengeCategory extends StatelessWidget {
  const _ChallengeCategory({required this.title, required this.challenges, required this.controller});

  final String title;
  final List<Challenge> challenges;
  final ChallengesController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        ...challenges.map((challenge) => _ChallengeCard(controller: controller, challenge: challenge)),
      ],
    );
  }
}

class _ChallengeCard extends StatefulWidget {
  const _ChallengeCard({required this.controller, required this.challenge});

  final ChallengesController controller;
  final Challenge challenge;

  @override
  State<_ChallengeCard> createState() => _ChallengeCardState();
}

class _ChallengeCardState extends State<_ChallengeCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    final challenge = widget.challenge;
    final completed = controller.isCompleted(challenge.id);
    final shareCount = controller.shareCounts[challenge.id] ?? 0;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOut,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Theme.of(context).colorScheme.surface.withOpacity(0.9),
        border: Border.all(
          color: completed
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
        boxShadow: const [
          BoxShadow(color: Color(0x140E1116), blurRadius: 18, offset: Offset(0, 12)),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () => setState(() => _expanded = !_expanded),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      completed ? Icons.verified_rounded : Icons.flag_outlined,
                      color: completed
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        challenge.title,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 280),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: completed
                            ? Theme.of(context).colorScheme.primary.withOpacity(0.18)
                            : Theme.of(context).colorScheme.primary.withOpacity(0.08),
                      ),
                      child: Text(challenge.goal),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(challenge.description),
                const SizedBox(height: 12),
                AnimatedCrossFade(
                  firstChild: const SizedBox.shrink(),
                  secondChild: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('الجائزة: ${challenge.reward}', style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () async {
                              await controller.toggleComplete(challenge.id);
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      controller.isCompleted(challenge.id)
                                          ? 'تهانينا! شارك إنجازك الآن.'
                                          : 'تم إعادة التحدي إلى القائمة النشطة.',
                                    ),
                                  ),
                                );
                              }
                            },
                            icon: Icon(completed ? Icons.restart_alt : Icons.check_circle),
                            label: Text(completed ? 'إعادة التحدي' : 'وضع علامة مكتمل'),
                          ),
                          const SizedBox(width: 12),
                          if (completed)
                            OutlinedButton.icon(
                              onPressed: () {
                                controller.registerShare(challenge.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('تمت مشاركة ${challenge.title} مع ${challenge.isCommunity ? 'المجتمع' : 'أصدقائك'}'),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.ios_share),
                              label: Text('شارك${shareCount > 0 ? ' ($shareCount)' : ''}'),
                            ),
                        ],
                      ),
                    ],
                  ),
                  crossFadeState: _expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 280),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 280.ms).moveY(begin: 14, end: 0);
  }
}
